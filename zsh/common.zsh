# skip verification of insecure directories
ZSH_DISABLE_COMPFIX=true

HIST_STAMPS="yyyy-mm-dd"
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

### Environment variables
export LANG=en_US.UTF-8

# Use file-based encryption key for gws (Google Workspace CLI) instead of OS keyring
export GOOGLE_WORKSPACE_CLI_KEYRING_BACKEND=file

# Load secrets/credentials
if [[ -f "$DOTFILES_DIR/.credentials" ]]; then
  source "$DOTFILES_DIR/.credentials"
fi

# java
if [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 21 2>/dev/null)
  if [[ -n "$JAVA_HOME" ]]; then
    export PATH="$JAVA_HOME/bin:$PATH"
  fi
fi

### zsh and oh-my-zsh configs
plugins=(
  git
  virtualenv
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

if [[ "$TERM_PROGRAM" == "WezTerm" && -f ~/.wezterm-shell-integration.sh ]]; then
  source ~/.wezterm-shell-integration.sh
fi

### PATH additions
[[ -d /opt/homebrew/bin ]] && path+=("/opt/homebrew/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.lee/bin")
[[ -d /usr/local/opt/libpq/bin ]] && path+=("/usr/local/opt/libpq/bin")
[[ -d /Library/TeX/texbin ]] && path+=("/Library/TeX/texbin")

### Initializers
if which mise > /dev/null; then eval "$(mise activate zsh)"; fi

# Powerlevel10k config
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
