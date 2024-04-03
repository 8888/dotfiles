# General aliases
alias dict='vim ~/Library/Spelling/LocalDictionary'
alias path='print -l $path'
alias rdbm='rails db:migrate'
alias rdbms='rails db:migrate:status'
alias rdbrb='rails db:rollback'
alias rsb='rails s -b 0.0.0.0'
alias sz='source ~/.zshrc'
alias utcdate='date -u +%FT%TZ'

# Git aliases
# Supplements oh-my-zsh git plugin aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
# if any of the above are not available, run `upgrade_oh_my_zsh`
alias gstsu='git stash save --include-untracked' #[<message>]

# Docker aliases
alias dcu='docker-compose up -d --remove-orphans'
alias dcs='docker-compose stop'
alias dcd='docker-compose down'
alias dpsa='docker ps -a'
alias drm='docker rm'

# Terraform aliases
alias twl='terraform workspace list'
alias tws='terraform workspace select'

# Python aliases
alias activate='source venv/bin/activate'
alias pip='pip3'
alias pmvv='python3 -m venv venv'
alias python='python3'

# RubiconMD aliases
alias cdang='cd ~/Documents/code/rmd/rubicon-angular'
alias cdrails='cd ~/Documents/code/rmd/rubicon'
alias dumpling='bundle exec ~/Documents/code/rmd/rubicon/bin/dumpling'

### Custom functions
# add ssh keys to keychain
function sak() {
  for filename in ~/.ssh/*.pem; do
    ssh-add --apple-use-keychain "$filename"
  done
}
