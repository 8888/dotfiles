# Server specific shell config

# Mise shims PATH (ensures node, claude, etc. are available in all contexts)
[[ -d "$HOME/.local/share/mise/shims" ]] && path+=("$HOME/.local/share/mise/shims")

# Source credentials
[[ -f ~/.credentials ]] && source ~/.credentials

# Use file-based encryption key for gws (no OS keyring on headless server)
export GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file

# Auto-attach to tmux on SSH login (skip if already in tmux or non-interactive)
if [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]] && [[ $- == *i* ]]; then
  tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi
