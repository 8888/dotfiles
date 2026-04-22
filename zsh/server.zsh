# Server specific shell config

# Mise shims PATH (ensures node, claude, etc. are available in all contexts)
[[ -d "$HOME/.local/share/mise/shims" ]] && path+=("$HOME/.local/share/mise/shims")

# Source credentials
[[ -f ~/.credentials ]] && source ~/.credentials

