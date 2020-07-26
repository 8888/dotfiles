# oh-my-zsh git plugin aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# General aliases
alias dcu='docker-compose up -d --remove-orphans'
alias dict='vim ~/Library/Spelling/LocalDictionary'
alias path='print -l $path'
alias rdbm='rails db:migrate'
alias rsb='rails s -b 0.0.0.0'
alias sz='source ~/.zshrc'
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
