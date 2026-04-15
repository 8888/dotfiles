#!/bin/bash
# Pre-Bash safety hook: block catastrophic and dangerous commands.
# Exit 2 = block the tool call.

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Profile-aware sudo policy.
# home/work = real machines, sudo stays blocked.
# server    = disposable agent VM, sudo allowed so the agent can self-provision.
PROFILE=$(cat "$HOME/.dotfiles_profile" 2>/dev/null || echo "home")
if [ "$PROFILE" != "server" ]; then
  if echo "$CMD" | grep -qE '(^|[|;&(])[ ]*sudo[ ]'; then
    echo "BLOCKED: sudo not allowed (profile=$PROFILE)" >&2
    exit 2
  fi
fi

# Block catastrophic rm
HOME_EXPANDED="$HOME"
case "$CMD" in
  *"rm -rf /"*|*"rm -rf ~"*|*"rm -rf $HOME_EXPANDED"*|*"rm -rf \$HOME"*)
    echo "BLOCKED: catastrophic rm" >&2
    exit 2
    ;;
esac

# Block force push (suggest --force-with-lease)
if echo "$CMD" | grep -qE 'git push.*(--force|-(f)[ ]|-f$)' && ! echo "$CMD" | grep -q '\-\-force-with-lease'; then
  echo "BLOCKED: force push — use --force-with-lease instead" >&2
  exit 2
fi

# Block destructive git operations without confirmation
case "$CMD" in
  *"git reset --hard"*|*"git checkout -- ."*|*"git clean -f"*)
    echo "BLOCKED: destructive git operation — review changes before discarding" >&2
    exit 2
    ;;
esac

# Block curl/wget piped to shell (common attack vector via prompt injection)
if echo "$CMD" | grep -qE '(curl|wget).*\|.*(sh|bash|zsh|python|node|perl)'; then
  echo "BLOCKED: piping remote content to shell is not allowed" >&2
  exit 2
fi

# Block data exfiltration: sending local files or env to remote servers
if echo "$CMD" | grep -qE '(curl|wget).*(-d @|-F |--data|--upload-file|--data-binary)'; then
  echo "BLOCKED: sending file/data to remote server — review the command" >&2
  exit 2
fi

# Block piping sensitive file content to network commands
if echo "$CMD" | grep -qE 'cat.*(ssh|aws|credentials|\.pem|\.key|kube).*\|.*(curl|wget|nc )'; then
  echo "BLOCKED: piping sensitive files to network commands" >&2
  exit 2
fi

# Block env/printenv piped to network commands
if echo "$CMD" | grep -qE '(^|[|;& ])env[^a-z].*\|.*(curl|wget|nc )|printenv.*\|.*(curl|wget|nc )'; then
  echo "BLOCKED: piping environment variables to network commands" >&2
  exit 2
fi

exit 0
