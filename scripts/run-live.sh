#!/usr/bin/env bash
# Live test: run every eval case's prompt through Claude Code with this plugin and
# the real Tirion connector, and save one stream-json trace per case.
#
# Plugin .mcp.json files do not expand environment variables, so the connector is
# passed with --mcp-config (which does) and the key never touches a file.
#
# Usage:
#   export TIRION_API_KEY=tak_...          # a key for a paid Tirion test account
#   scripts/run-live.sh [out_dir] [case ...]
# Output: <out_dir>/<case>.jsonl (full trace) and <out_dir>/<case>.md (final answer).
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
out="${1:-$root/evals/results/live-$(date -u +%Y%m%dT%H%M%SZ)}"
shift || true
: "${TIRION_API_KEY:?set TIRION_API_KEY to a Tirion API key (tak_...)}"
mkdir -p "$out"

config="$(mktemp)"
trap 'rm -f "$config"' EXIT
cat > "$config" <<'JSON'
{"mcpServers": {"tirion": {"type": "http", "url": "https://mcp.tiriondata.com/mcp",
  "headers": {"Authorization": "Bearer ${TIRION_API_KEY}"}}}}
JSON

cases=("$@")
if [ ${#cases[@]} -eq 0 ]; then
  for d in "$root"/evals/*/prompt.md; do cases+=("$(basename "$(dirname "$d")")"); done
fi

for c in "${cases[@]}"; do
  prompt="$(awk 'BEGIN{n=0} /^---$/{n++; next} n>=2' "$root/evals/$c/prompt.md")"
  echo "== $c"
  (cd "$out" && timeout 900 claude -p "$prompt" \
      --model "${MODEL:-sonnet}" \
      --plugin-dir "$root" \
      --mcp-config "$config" --strict-mcp-config \
      --allowedTools "Skill" "mcp__tirion__*" \
      --output-format stream-json --verbose > "$out/$c.jsonl" 2> "$out/$c.err") || echo "   exit $?"
  python3 - "$out/$c.jsonl" > "$out/$c.md" <<'PY'
import json, sys
last = ""
for line in open(sys.argv[1]):
    try:
        e = json.loads(line)
    except ValueError:
        continue
    if e.get("type") == "result":
        last = e.get("result") or last
print(last)
PY
done
echo "traces in $out"
