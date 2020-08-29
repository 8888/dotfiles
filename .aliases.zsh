# General aliases
alias dcu='docker-compose up -d --remove-orphans'
alias dict='vim ~/Library/Spelling/LocalDictionary'
alias path='print -l $path'
alias rdbm='rails db:migrate'
alias rdrb='rails db:rollback'
alias rsb='rails s -b 0.0.0.0'
alias sz='source ~/.zshrc'
alias utcdate='date -u +%FT%TZ'

# Git aliases
# Supplements oh-my-zsh git plugin aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
# if any of the above are not available, run `upgrade_oh_my_zsh`
alias gstsu='git stash save --include-untracked' #[<message>]

# RubiconMD aliases
alias cdang='cd ~/Documents/code/rmd/rubicon-angular'
alias cdrails='cd ~/Documents/code/rmd/rubicon'

### Custom functions
# add ssh keys to keychain
function sak() {
  for filename in ~/.ssh/*.pem; do
    ssh-add -K "$filename"
  done
}
