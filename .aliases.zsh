# General aliases
alias dict='vim ~/Library/Spelling/LocalDictionary'
alias path='print -l $path'
alias sz='source ~/.zshrc'
alias utcdate='date -u +%FT%TZ'
alias c='cursor .'

# Git aliases
# Supplements oh-my-zsh git plugin aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
# if any of the above are not available, run `upgrade_oh_my_zsh`
alias gstsu='git stash save --include-untracked' #[<message>]
alias gla='update_all_repos'

# Docker aliases
alias dcu='docker compose up -d --remove-orphans'
alias dcs='docker compose stop'
alias dcd='docker compose down'
alias dpsa='docker ps -a'
alias drm='docker rm'

# Terraform aliases
alias twl='terraform workspace list'
alias tws='terraform workspace select'

# Python aliases
alias activate='source venv/bin/activate'
alias pip='pip3'
alias python='python3'
alias pmvv='python -m venv env'
alias serve='python -m http.server 8000'

# RubiconMD aliases
alias cdang='cd ~/Documents/rmd/code/rubicon-angular'
alias cdrails='cd ~/Documents/rmd/code/rubicon'
alias dumpling='bundle exec ~/Documents/rmd/code/rubicon/bin/dumpling'
# Rails aliases
alias rdbm='rails db:migrate'
alias rdbms='rails db:migrate:status'
alias rdbrb='rails db:rollback'
alias rsb='rails s -b 0.0.0.0'

### Custom functions
# add ssh keys to keychain
function sak() {
  for filename in ~/.ssh/*.pem; do
    ssh-add --apple-use-keychain "$filename"
  done
}

# Update all git repositories in current directory and one level deep
function update_all_repos() {
  # Update current directory if it's a git repo
  if [ -d .git ]; then
    echo "Updating $(pwd)"
    gfa
    gl
  fi

  # Update all git repos one level deep
  for dir in */; do
    if [ -d "$dir/.git" ]; then
      echo "Updating $dir"
      (cd "$dir" && gfa && gl)
    fi
  done
}
