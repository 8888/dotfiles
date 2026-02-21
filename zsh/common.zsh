# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# skip verification of insecure directories
ZSH_DISABLE_COMPFIX=true

HIST_STAMPS="yyyy-mm-dd"
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

### Environment variables
export LANG=en_US.UTF-8
export TERM="xterm-256color"

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
)

source $ZSH/oh-my-zsh.sh

### PATH additions
path+=("/opt/homebrew/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.lee/bin")
path+=("$HOME/.rbenv/bin")
path+=("/usr/local/opt/libpq/bin")

### Initializers
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which mise > /dev/null; then eval "$(mise activate zsh)"; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
