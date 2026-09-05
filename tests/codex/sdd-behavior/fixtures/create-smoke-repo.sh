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
    def test_fixture_starts_with_four_unimplemented_tasks(self):
        root = Path(__file__).parents[1]
        plan = (root / "docs" / "implementation-plan.md").read_text()
        self.assertEqual(plan.count("## Task "), 4)
        self.assertFalse((root / "src" / "queue_label.py").exists())
        self.assertFalse((root / "src" / "reservations.py").exists())


if __name__ == "__main__":
    unittest.main()
PY

cat >"$destination/.gitignore" <<'EOF'
__pycache__/
.superpowers/
EOF

git -C "$destination" init -q -b main
git -C "$destination" add .
git -C "$destination" \
  -c user.name=fixture \
  -c user.email=fixture@example.invalid \
  -c commit.gpgsign=false \
  commit -qm "test: seed SDD smoke fixture"

printf '%s\n' "$destination"
