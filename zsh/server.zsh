# Server specific shell config

# Source credentials
[[ -f ~/.credentials ]] && source ~/.credentials

# Use file-based encryption key for gws (no OS keyring on headless server)
export GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file

# Auto-attach to tmux on SSH login (skip if already in tmux or non-interactive)
if [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]] && [[ $- == *i* ]]; then
  tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi
