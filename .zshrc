HIST_STAMPS="yyyy-mm-dd"
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel9k/powerlevel9k"

# environment variables
export TERM="xterm-256color"

plugins=(
  git
  virtualenv
  zsh-autosuggestions
)

# POWERLEVEL9K customizations
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  vcs
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  virtualenv
)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
local vamp="🧛🏻‍♂️"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{red} $vamp %k%F{red}%f"

# source old .zshrc
# remove after everything is cleaned up and migrated
source ~/.old_zshrc

source $ZSH/oh-my-zsh.sh

# Custom aliases
alias dcu='docker-compose up -d --remove-orphans'
alias rdbm='rails db:migrate'
alias rsb='rails s -b 0.0.0.0'
alias sz="source ~/.zshrc"
alias utcdate='date -u +%FT%TZ'

# RubiconMD aliases
alias cdang='cd ~/Documents/code/rubicon-angular'
alias cdrails='cd ~/Documents/code/rubicon'

### Custom functions
# add ssh keys to keychain
function sak() {
  for filename in ~/.ssh/*.pem; do
    ssh-add -K "$filename"
  done
}
