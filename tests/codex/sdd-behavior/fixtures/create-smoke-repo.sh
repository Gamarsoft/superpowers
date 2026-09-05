#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: create-smoke-repo.sh DESTINATION" >&2
  exit 2
fi

destination="$1"
if [[ -e "$destination" ]]; then
  echo "destination already exists: $destination" >&2
  exit 2
fi

mkdir -p "$destination/src" "$destination/tests" "$destination/docs"
cp "$(dirname "$0")/approved-spec.md" "$destination/docs/approved-spec.md"
cp "$(dirname "$0")/implementation-plan.md" "$destination/docs/implementation-plan.md"

touch "$destination/src/__init__.py"
cat >"$destination/tests/test_fixture_shape.py" <<'PY'
import unittest
from pathlib import Path


class FixtureShapeTest(unittest.TestCase):
    def test_fixture_has_four_tasks_and_a_source_package(self):
        root = Path(__file__).parents[1]
        plan = (root / "docs" / "implementation-plan.md").read_text()
        self.assertEqual(plan.count("## Task "), 4)
        self.assertTrue((root / "src" / "__init__.py").exists())


if __name__ == "__main__":
    unittest.main()
PY

cat >"$destination/.gitignore" <<'EOF'
__pycache__/
.superpowers/
EOF

git -C "$destination" init -q -b main
git -C "$destination" config core.fsmonitor false
git -C "$destination" add .
git -C "$destination" \
  -c user.name=fixture \
  -c user.email=fixture@example.invalid \
  -c commit.gpgsign=false \
  commit -qm "test: seed SDD smoke fixture"
git -C "$destination" tag sdd-smoke-base

printf '%s\n' "$destination"
