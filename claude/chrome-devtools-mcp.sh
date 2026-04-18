#!/bin/zsh
# Starts the Chrome DevTools MCP server.
# Chrome setup is deferred — a PreToolUse hook (chrome-devtools-ensure.sh)
# ensures Chrome is running with remote debugging only when a tool is called.

DEBUGGING_PORT=9222

exec npx -y chrome-devtools-mcp@latest --browser-url=http://127.0.0.1:$DEBUGGING_PORT
