#!/usr/bin/env bash
# session-memory-sync.sh — SessionStart hook.
#
# When a session starts in the `life` repo, surface any laptop Claude auto-memory
# facts that have drifted from the committed repo memory/ store, so durable ones
# get promoted (the lifebox/Gemini only ever see the repo copy). Read-only: it
# never writes the repo and never commits — it just emits a reminder. All real
# work + the curation/promote flow live in life/scripts/memory/promote.sh.
#
# Fires for every session globally, so it guards on cwd and exits silently
# everywhere except the life repo (and silently when there is no drift).
set -uo pipefail

input="$(cat 2>/dev/null || true)"
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null || true)"
LIFE="${HOME}/Documents/life"

case "$cwd" in
  "$LIFE"|"$LIFE"/*) ;;
  *) exit 0 ;;                       # not the life repo → silent no-op
esac

tool="${LIFE}/scripts/memory/promote.sh"
[[ -x "$tool" ]] || exit 0
"$tool" --hook-check 2>/dev/null || true
exit 0
