#!/usr/bin/env bash
set -euo pipefail

n=$(printf "%03d" "${1:?usage: ./new-day.sh <number> <title>}")
f="days/day${n}.md"

[ -e "$f" ] && { echo "$f already exists"; exit 1; }
mkdir -p days

cat > "$f" <<INNER
# Day $n : ${*:2}

\`\`\`bash

\`\`\`
INNER

echo "created $f"
