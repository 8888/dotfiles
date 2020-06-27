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
