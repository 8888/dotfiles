#!/bin/bash
# Post-edit hook: run project linter/formatter on edited files if available.
# Reads the tool result from stdin (JSON with tool_input.file_path).

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Get file extension
EXT="${FILE_PATH##*.}"

# Find project root (look for common markers)
DIR=$(dirname "$FILE_PATH")
PROJECT_ROOT=""
while [ "$DIR" != "/" ]; do
  if [ -f "$DIR/package.json" ] || [ -f "$DIR/pyproject.toml" ] || [ -f "$DIR/build.gradle" ] || [ -f "$DIR/Cargo.toml" ]; then
    PROJECT_ROOT="$DIR"
    break
  fi
  DIR=$(dirname "$DIR")
done

if [ -z "$PROJECT_ROOT" ]; then
  exit 0
fi

cd "$PROJECT_ROOT" || exit 0

# Run prettier if available (JS/TS/CSS/HTML/JSON/MD)
case "$EXT" in
  js|jsx|ts|tsx|css|scss|html|json|md|yaml|yml)
    if [ -f "node_modules/.bin/prettier" ]; then
      node_modules/.bin/prettier --write "$FILE_PATH" 2>/dev/null
    fi
    ;;
esac

# Run black if available (Python)
case "$EXT" in
  py)
    if command -v black &>/dev/null && [ -f "pyproject.toml" ]; then
      black --quiet "$FILE_PATH" 2>/dev/null
    fi
    ;;
esac

exit 0
