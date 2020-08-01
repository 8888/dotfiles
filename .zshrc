# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HIST_STAMPS="yyyy-mm-dd"
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

### Environment variables
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home
export LANG=en_US.UTF-8
export TERM="xterm-256color"

# source expo credential environment variables
source ~/.expo_credentials

### zsh and oh-my-zsh configs
plugins=(
  git
  nvm
  virtualenv
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

### PATH additions
path+=("$HOME/.local/bin")
path+=("$HOME/.lee/bin")

### Initializers
# init rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Custom aliases
source ~/.aliases.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
