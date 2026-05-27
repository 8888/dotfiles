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

# Gas Town tmux socket (gt manages its own tmux server on a separate socket
# named gt-<sha256(town_root)[:6]>). Hardcoded for /home/lee/gt.
alias gtt='tmux -L gt-5a172f'

# Gas City: when the source-built `gc` binary is installed on PATH, drop the
# oh-my-zsh git-plugin `gc` -> `git commit -v` alias so the real `gc` wins. This
# matters not just for the operator (no more `gas` typing) but critically for
# Gas City *agents* — their Bash tool spawns zsh, sources this file, and the
# alias would otherwise shadow every `gc` call in upstream gastown prompts
# (DocNow factory first-light, 2026-05-26). Memory: project_docnow_mac_auth,
# reference_gascity_invocation. `whence -p` resolves PATH binaries, ignoring
# aliases — so the guard is self-disabling on machines without the binary.
if whence -p gc >/dev/null 2>&1; then
  unalias gc 2>/dev/null
fi
# Kept for muscle memory — `gas` still works, just no longer required.
alias gas='gc'

# Vocal Dashboard operator session: launch from the life repo (keeps memory +
# guides + corpus), add-dir the product repo for project context + pull-main.
# Runbook: life/guides/vocal-dashboard-ops.md  (Mac-local workflow)
alias vd-ops='cd ~/Documents/life && CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude --dangerously-skip-permissions --add-dir ~/Documents/code/lee/vocal-dashboard'

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

# gws auth login prints a multi-kilobyte OAuth URL that exceeds WezTerm's
# clickable-hyperlink length cap. Wrap it so the URL opens in the default
# browser as soon as it's printed. gws is run under a PTY via script(1) so
# its stdout stays line-buffered and the post-callback success message
# still reaches the terminal.
function gws() {
  if [[ "$1" == "auth" && "$2" == "login" && "$(uname)" == "Darwin" ]]; then
    local logfile
    logfile="$(mktemp -t gws-auth)"
    (
      local opened=0
      while (( ! opened )); do
        if [[ -s "$logfile" ]]; then
          local url
          url=$(grep -oE 'https://accounts\.google\.com/[^[:space:]]+' "$logfile" | head -1)
          if [[ -n "$url" ]]; then
            open "$url" && opened=1
          fi
        fi
        sleep 0.3
      done
    ) &!
    local watcher=$!
    script -q "$logfile" gws "$@"
    local rc=$?
    kill "$watcher" 2>/dev/null
    rm -f "$logfile"
    return $rc
  else
    command gws "$@"
  fi
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
