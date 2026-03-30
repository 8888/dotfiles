# Work specific shell config

# PostgreSQL (installed via libpq/postgresql homebrew)
export PATH="$(brew --prefix)/opt/postgresql@18/bin:$PATH"

# source credential environment variables if they exist
[[ -f ~/.credentials ]] && source ~/.credentials
[[ -f ~/.expo_credentials ]] && source ~/.expo_credentials
[[ -f ~/.claude_credentials.work ]] && source ~/.claude_credentials.work
