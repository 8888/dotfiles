#!/bin/zsh
# PreToolUse hook for mcp__chrome-devtools__ tools.
# Ensures Chrome is running with remote debugging on the user's real profile.
# No-op if Chrome is already debuggable on the expected port.
#
# Chrome 146+ requires --user-data-dir to be a "non-default" path for remote
# debugging. We work around this by creating a thin wrapper directory that
# symlinks the real Default profile, so Chrome sees a non-default path while
# still using the user's actual profile data.

DEBUGGING_PORT=9222
CHROME_REAL_DIR="$HOME/Library/Application Support/Google/Chrome"
CHROME_DEBUG_DIR="$HOME/.chrome-debug-profile"

# Already running with debugging — nothing to do
if curl -s --max-time 1 "http://localhost:$DEBUGGING_PORT/json/version" > /dev/null 2>&1; then
  exit 0
fi

# Chrome is running without debug port — restart it
if pgrep -x "Google Chrome" > /dev/null; then
  echo "Quitting Chrome (tabs will be restored on relaunch)..." >&2
  osascript -e 'tell application "Google Chrome" to quit'
  while pgrep -x "Google Chrome" > /dev/null; do sleep 0.5; done
fi

# Set up the debug profile wrapper pointing at the real profile
mkdir -p "$CHROME_DEBUG_DIR"
cp -f "$CHROME_REAL_DIR/Local State" "$CHROME_DEBUG_DIR/" 2>/dev/null
ln -sfn "$CHROME_REAL_DIR/Default" "$CHROME_DEBUG_DIR/Default"

echo "Launching Chrome with remote debugging on port $DEBUGGING_PORT..." >&2
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port=$DEBUGGING_PORT \
  --user-data-dir="$CHROME_DEBUG_DIR" \
  --restore-last-session \
  --no-first-run &>/dev/null &

# Wait for Chrome to be ready
for i in {1..15}; do
  sleep 1
  if curl -s --max-time 1 "http://localhost:$DEBUGGING_PORT/json/version" > /dev/null 2>&1; then
    exit 0
  fi
done

echo "Chrome did not become ready in time." >&2
exit 1
