#!/usr/bin/env bash
set -euo pipefail

n=$(printf "%03d" "${1:?usage: ./new-day.sh <number> <title>}")
title="${*:2}"
f="days/day${n}.sh"

[ -e "$f" ] && { echo "$f already exists"; exit 1; }
mkdir -p days

cat > "$f" <<INNER
#!/usr/bin/env bash
# =============================================
# Day $n : $title
# Date: $(date +%F)
# =============================================

# --- Goal ---

# --- What I did ---

# --- Problem I hit ---

# --- What I learned ---
INNER

chmod +x "$f"
echo "created $f"
