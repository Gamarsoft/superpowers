#!/usr/bin/env python3
"""Validate and summarize one immutable Codex behavior-evaluation run."""

from __future__ import annotations

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

ALLOWED_DISPOSITIONS = {"BLOCKING", "DECISION", "FOLLOW_UP", "INVALID"}
MANIFEST_FIELDS = {
    "schema_version",
    "run_id",
    "variant",
    "variant_revision",
    "scenario_revision",
    "harness",
    "harness_version",
    "model",
    "reasoning_effort",
    "plugins",
    "typed_roles_available",
    "expected_samples",
}
RESULT_FIELDS = {
    "schema_version",
    "variant",
    "variant_revision",
    "scenario",
    "scenario_revision",
    "repetition",
    "model",
    "reasoning_effort",
    "plugins",
    "typed_roles_available",
    "outcome",
    "response",
    "event_trace",
    "dispatch_count",
    "review_count",
    "fix_round_count",
    "human_stop_count",
    "dispositions",
    "assertions",
}


class ContractError(ValueError):
    pass


def read_json(path: Path) -> object:
    try:
        return json.loads(path.read_text())
    except (OSError, json.JSONDecodeError) as error:
        raise ContractError(f"{path}: cannot read JSON: {error}") from error


def require_fields(data: dict[str, object], fields: set[str], path: Path) -> None:
    missing = sorted(fields - data.keys())
    if missing:
        raise ContractError(f"{path}: missing required fields: {', '.join(missing)}")


def validate_manifest(path: Path) -> dict[str, object]:
    data = read_json(path)
    if not isinstance(data, dict):
        raise ContractError(f"{path}: manifest must be an object")
    require_fields(data, MANIFEST_FIELDS, path)
    if data["schema_version"] != 1:
        raise ContractError(f"{path}: schema_version must be 1")
    expected = data["expected_samples"]
    if not isinstance(expected, dict) or not expected:
        raise ContractError(f"{path}: expected_samples must be a non-empty object")
    for scenario, count in expected.items():
        if not isinstance(scenario, str) or not isinstance(count, int) or count < 1:
            raise ContractError(f"{path}: invalid expected sample entry")
    return data


def validate_result(
    path: Path, data: object, manifest: dict[str, object]
) -> dict[str, object]:
    if not isinstance(data, dict):
        raise ContractError(f"{path}: result must be an object")
    require_fields(data, RESULT_FIELDS, path)
    if data["schema_version"] != 1:
        raise ContractError(f"{path}: schema_version must be 1")

    for field in (
        "variant",
        "variant_revision",
        "scenario_revision",
        "model",
        "reasoning_effort",
        "plugins",
        "typed_roles_available",
    ):
        if data[field] != manifest[field]:
            raise ContractError(f"{path}: {field} does not match manifest")

    scenario = data["scenario"]
    if scenario not in manifest["expected_samples"]:
        raise ContractError(f"{path}: unexpected scenario {scenario!r}")
    repetition = data["repetition"]
    if not isinstance(repetition, int) or repetition < 1:
        raise ContractError(f"{path}: repetition must be a positive integer")

    for field in (
        "dispatch_count",
        "review_count",
        "fix_round_count",
        "human_stop_count",
    ):
        if not isinstance(data[field], int) or data[field] < 0:
            raise ContractError(f"{path}: {field} must be a non-negative integer")

    dispositions = data["dispositions"]
    if not isinstance(dispositions, list) or any(
        item not in ALLOWED_DISPOSITIONS for item in dispositions
    ):
        raise ContractError(f"{path}: invalid disposition")

    if not isinstance(data["response"], str) or not data["response"].strip():
        raise ContractError(f"{path}: response must be non-empty text")
    if not isinstance(data["event_trace"], list):
        raise ContractError(f"{path}: event_trace must be a list")

    assertions = data["assertions"]
    if not isinstance(assertions, list) or not assertions:
        raise ContractError(f"{path}: assertions must be a non-empty list")
    for assertion in assertions:
        if (
            not isinstance(assertion, dict)
            or not isinstance(assertion.get("id"), str)
            or not isinstance(assertion.get("passed"), bool)
            or not isinstance(assertion.get("evidence"), str)
        ):
            raise ContractError(f"{path}: malformed assertion")

    expected_outcome = "pass" if all(item["passed"] for item in assertions) else "fail"
    if data["outcome"] != expected_outcome:
        raise ContractError(
            f"{path}: outcome {data['outcome']!r} disagrees with assertions"
        )
    return data


def load_run(run_dir: Path) -> tuple[dict[str, object], list[dict[str, object]]]:
    manifest = validate_manifest(run_dir / "manifest.json")
    raw_dir = run_dir / "raw"
    paths = sorted(raw_dir.glob("*.json")) if raw_dir.is_dir() else []
    if not paths:
        raise ContractError(f"{raw_dir}: no raw result files")

    results: list[dict[str, object]] = []
    seen: set[tuple[str, int]] = set()
    counts: dict[str, int] = defaultdict(int)
    for path in paths:
        result = validate_result(path, read_json(path), manifest)
        key = (str(result["scenario"]), int(result["repetition"]))
        if key in seen:
            raise ContractError(
                f"{path}: duplicate scenario/repetition {key[0]} #{key[1]}"
            )
        seen.add(key)
        counts[key[0]] += 1
        results.append(result)

    expected = manifest["expected_samples"]
    for scenario, count in expected.items():
        if counts[scenario] != count:
            raise ContractError(
                f"{run_dir}: {scenario} has {counts[scenario]} samples; expected {count}"
            )
    return manifest, results


def totals(results: list[dict[str, object]]) -> dict[str, tuple[int, int]]:
    by_scenario: dict[str, list[dict[str, object]]] = defaultdict(list)
    for result in results:
        by_scenario[str(result["scenario"])].append(result)
    return {
        scenario: (
            sum(result["outcome"] == "pass" for result in rows),
            len(rows),
        )
        for scenario, rows in by_scenario.items()
    }


def print_summary(manifest: dict[str, object], results: list[dict[str, object]]) -> None:
    print(f"# Behavior run: {manifest['run_id']}")
    print()
    print(f"- Variant: {manifest['variant']} @ {manifest['variant_revision']}")
    print(f"- Harness: {manifest['harness']} {manifest['harness_version']}")
    print(f"- Model: {manifest['model']} ({manifest['reasoning_effort']})")
    print()
    print("| Scenario | Passed | Samples | Pass rate | Raw evidence |")
    print("| --- | ---: | ---: | ---: | --- |")
    for scenario, (passed, count) in sorted(totals(results).items()):
        repetitions = sorted(
            int(result["repetition"])
            for result in results
            if result["scenario"] == scenario
        )
        evidence = ", ".join(
            f"[{repetition:02d}](raw/{scenario}-{repetition:02d}.json)"
            for repetition in repetitions
        )
        print(
            f"| {scenario} | {passed} | {count} | {passed / count:.1%} | "
            f"{evidence} |"
        )


def compare_candidate(
    candidate: list[dict[str, object]], baseline: list[dict[str, object]]
) -> None:
    candidate_totals = totals(candidate)
    baseline_totals = totals(baseline)
    for scenario, (candidate_passed, candidate_count) in candidate_totals.items():
        if scenario not in baseline_totals:
            raise ContractError(f"baseline has no scenario {scenario}")
        baseline_passed, baseline_count = baseline_totals[scenario]
        if candidate_count != baseline_count:
            raise ContractError(
                f"{scenario}: candidate count {candidate_count} != baseline {baseline_count}"
            )
        if candidate_passed != candidate_count:
            raise ContractError(f"{scenario}: candidate must pass every sample")
        if baseline_count - baseline_passed >= 2 and candidate_passed - baseline_passed < 2:
            raise ContractError(f"{scenario}: candidate improvement is less than 2 samples")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("run_dir", type=Path)
    parser.add_argument("--baseline", type=Path)
    args = parser.parse_args()
    try:
        manifest, results = load_run(args.run_dir)
        if args.baseline:
            _, baseline = load_run(args.baseline)
            compare_candidate(results, baseline)
        print_summary(manifest, results)
    except ContractError as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
