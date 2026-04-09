#!/bin/bash
# Pre-commit hook: scan staged changes for secrets using gitleaks.
# Runs before any git commit tool call. Blocks commit if secrets are found.
# Exit 2 = block the tool call.

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only intercept git commit commands
case "$CMD" in
  *"git commit"*) ;;
  *) exit 0 ;;
esac

# Find repo root from the working directory
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
  exit 0
fi

# Scan staged changes for secrets (skip if gitleaks not installed)
if ! command -v gitleaks &>/dev/null; then
  # Fall through to filename-pattern checks below
  EXIT_CODE=0
  OUTPUT=""
else
  OUTPUT=$(cd "$REPO_ROOT" && gitleaks protect --staged --no-banner 2>&1)
  EXIT_CODE=$?
fi

if [ $EXIT_CODE -ne 0 ]; then
  echo "BLOCKED: gitleaks found secrets in staged changes:" >&2
  echo "$OUTPUT" >&2
  echo "" >&2
  echo "Unstage the file, remove the secret, and rotate it before committing." >&2
  exit 2
fi

# Also check for common secret file patterns in staged files
STAGED_FILES=$(cd "$REPO_ROOT" && git diff --staged --name-only 2>/dev/null)
# Only match filenames that are clearly secret files, not code that happens to contain these words
BLOCKED_PATTERNS=('.env' '.env.' '.pem' '.key' '.p12' '.pfx' '.keystore' '.jks')

for file in $STAGED_FILES; do
  basename=$(basename "$file")
  for pattern in "${BLOCKED_PATTERNS[@]}"; do
    case "$basename" in
      *"$pattern"*)
        echo "BLOCKED: suspicious file staged for commit: $file (matches pattern: $pattern)" >&2
        echo "If this is intentional, remove this check or unstage the file." >&2
        exit 2
        ;;
    esac
  done
done

exit 0
