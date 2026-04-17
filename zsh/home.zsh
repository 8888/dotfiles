# Home specific shell config
# source credential environment variables if they exist
[[ -f ~/.credentials ]] && source ~/.credentials

# Gas Town shell integration
[[ -f "$HOME/.config/gastown/shell-hook.sh" ]] && source "$HOME/.config/gastown/shell-hook.sh"
