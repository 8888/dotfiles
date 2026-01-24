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

# java
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

### zsh and oh-my-zsh configs
plugins=(
  git
  nvm
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"
