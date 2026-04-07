#!/usr/bin/env bash
# Minimal behavioral eval for openclaw-terse
# Purpose: verify terse prompt files are in place and contain the key rules
# Not a live LLM eval — that requires a running agent session

set -euo pipefail

WORKSPACE="${1:-$HOME/.openclaw/workspace}"
PASS=0
FAIL=0

check() {
  local file="$1"
  local pattern="$2"
  local label="$3"
  if grep -qF "$pattern" "$file" 2>/dev/null; then
    echo "  ✅ $label"
    PASS=$((PASS + 1))
  else
    echo "  ❌ $label (not found in $(basename "$file"))"
    FAIL=$((FAIL + 1))
  fi
}

echo "=== openclaw-terse behavioral eval ==="
echo "Workspace: $WORKSPACE"
echo ""

SOUL="$WORKSPACE/SOUL.md"
PROTOCOL="$WORKSPACE/RESPONSE_PROTOCOL.md"
USER_FILE="$WORKSPACE/USER.md"

echo "--- SOUL.md checks ---"
check "$SOUL" "Answer first"         "answer-first rule present"
check "$SOUL" "Default short"        "default-short rule present"
check "$SOUL" "No fluff"             "no-fluff rule present"
check "$SOUL" "End once"             "end-once rule present"
check "$SOUL" "if you want"          "optional-offer rule present"

echo ""
echo "--- RESPONSE_PROTOCOL.md checks ---"
if [[ -f "$PROTOCOL" ]]; then
  check "$PROTOCOL" "Answer in the first line" "answer-first"
  check "$PROTOCOL" "Stop once"                "stop-once rule"
  check "$PROTOCOL" "if you want"              "optional-offer rule"
else
  echo "  ⚠️  RESPONSE_PROTOCOL.md not present (optional but recommended)"
fi

echo ""
echo "--- USER.md checks ---"
if [[ -f "$USER_FILE" ]]; then
  check "$USER_FILE" "do not" "proactive-step guidance present"
else
  echo "  ⚠️  USER.md not present"
fi

echo ""
echo "=== Result: $PASS passed, $FAIL failed ==="
if [[ $FAIL -gt 0 ]]; then
  echo "Run the skill or patch manually to fix the missing rules."
  exit 1
fi
echo "All checks passed."
