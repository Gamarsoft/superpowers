#!/usr/bin/env python3
"""Verify the recorded campaign identities; manual scores remain human-readable evidence."""
import hashlib
import json
from pathlib import Path
import subprocess

here = Path(__file__).resolve().parent
root = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
inputs = json.loads((here / "execution-inputs.json").read_text())
manifest = json.loads((here / "evaluation-manifest.json").read_text())
evidence = here / "evaluation"


def digest(data):
    return hashlib.sha256(data).hexdigest()


for name, expected in inputs["spec_sha256"].items():
    assert digest((here / name).read_bytes()) == expected, name
for name, expected in manifest["inputs"].items():
    assert digest((here / name).read_bytes()) == expected, name
for arm in ("baseline", "candidate"):
    source = manifest["sources"][arm]
    assert set(source) == set(inputs["snapshot_files"]), arm
    bodies = []
    for name, expected in source.items():
        live = (subprocess.check_output(["git", "show", f'{inputs["base"]}:{name}'])
                if arm == "baseline" else (root / name).read_bytes())
        assert digest(live) == expected, f"{arm}: {name}"
        bodies.append((name, live.decode()))
    if arm == "baseline":
        packet = "\n".join(f"\n--- SOURCE FILE: {name} ---\n{body}" for name, body in bodies)
    else:
        packet = "Immutable brainstorming instruction packet. Read all sources before responding to the supplied cases.\n"
        packet += "".join(f"\n\n# SOURCE: {name}\n\n{body}" for name, body in bodies)
    assert digest(packet.encode()) == manifest["packets"][arm], f"{arm}: packet"
for arm in ("baseline", "control", "candidate"):
    samples = [s for s in manifest["samples"] if s["arm"] == arm]
    assert len(samples) == 5, f"{arm}: expected five independent actors"
    assert len({s["actor"] for s in samples}) == 5, f"{arm}: actor reuse"
    for sample in samples:
        content = (evidence / sample["output"]).read_bytes()
        assert digest(content) == sample["sha256"], sample["output"]
        assert len(content.decode().split()) == sample["words"], sample["output"]
        assert set(sample["scores"]) == set("ABCDEFG"), sample["output"]
        assert set(sample["scores"].values()) <= {"PASS", "FAIL"}, sample["output"]
assert len({s["actor"] for s in manifest["samples"]}) == 15, "reused actor"
for sample in manifest["pressure"]:
    assert digest((evidence / sample["output"]).read_bytes()) == sample["sha256"], sample["output"]
assert len(manifest["pressure"]) >= 2, "missing independent pressure evidence"
print("PASS: frozen requirements, instruction snapshots, 15 sample vectors and pressure evidence")
