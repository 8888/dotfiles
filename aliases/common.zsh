# ls aliases
alias lsa='eza -la --icons --git'
alias lst='eza --tree --icons --git-ignore --git --group-directories-first --ignore-glob "node_modules|.git|venv|.venv|target|dist|build"'

# General aliases
if (( $+commands[bat] )); then
  alias cat='bat'
elif (( $+commands[batcat] )); then
  alias cat='batcat'
fi
if [[ "$(uname)" == "Darwin" ]]; then
  alias dict='vim ~/Library/Spelling/LocalDictionary'
fi
alias path='print -l $path'
alias sz='source ~/.zshrc'
alias utcdate='date -u +%FT%TZ'
alias c='claude'
alias cy='claude --dangerously-skip-permissions'

# Tmux shortcuts
alias ta='tmux attach-session -t'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'

# Git aliases
# Supplements oh-my-zsh git plugin aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
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
alias pip='pip3'
alias python='python3'
alias venv='python -m venv .venv'
alias activate='source .venv/bin/activate'
alias serve='python -m http.server 8000'

# Gemini aliases
alias gemini='gemini --include-directories ~/.gemini/docs'
alias agy='antigravity'
alias ag='antigravity'

### Custom functions
# add ssh keys to keychain
function sak() {
  for filename in ~/.ssh/*.pem; do
    if [[ "$(uname)" == "Darwin" ]]; then
      ssh-add --apple-use-keychain "$filename"
    else
      ssh-add "$filename"
    fi
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

# Open the current git repo in the browser
function gweb() {
  local remote_url=$(git remote get-url origin 2>/dev/null)
  if [ -z "$remote_url" ]; then
    echo "No git remote found."
    return 1
  fi

  local url=$(echo "$remote_url" | sed -E "s/^git@([^:]*):(.*)$/https:\/\/\1\/\2/" | sed "s/\.git$//")
  if [[ "$(uname)" == "Darwin" ]]; then
    open "$url"
  else
    xdg-open "$url" 2>/dev/null || echo "$url"
  fi
}
