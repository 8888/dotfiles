# Home specific shell config
# source credential environment variables if they exist
[[ -f ~/.credentials ]] && source ~/.credentials

# Use file-based encryption key for gws (Google Workspace CLI) instead of OS keyring
# Prevents macOS keychain popups; key is stored at ~/.config/gws/.encryption_key
export GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file
