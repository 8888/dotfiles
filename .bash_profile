# load old bash profile
# this contains legacy configs that will be migrated over
source .old_bash_profile

# git aliases
# redundant when using zsh git plugin
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit'
alias gco='git checkout'
alias gdf='git diff'
alias glol='git log --oneline'
alias gpl='git pull'
alias gpsuo='git push --set-upstream origin'
alias gst='git status'

# general aliases
alias dcu='docker-compose up -d --remove-orphans'
alias rdbm='rails db:migrate'
alias rsb='rails s -b 0.0.0.0'
alias utcdate='date -u +%FT%TZ'
