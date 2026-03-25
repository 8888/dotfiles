# Work specific shell config
# source credential environment variables if they exist
[[ -f ~/.credentials ]] && source ~/.credentials
[[ -f ~/.expo_credentials ]] && source ~/.expo_credentials
[[ -f ~/.claude_credentials.work ]] && source ~/.claude_credentials.work
