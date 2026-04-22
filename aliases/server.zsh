# Server specific aliases

# Project management
function proj() {
  local projects_dir=~/projects
  if [ -z "$1" ]; then
    ls -1 "$projects_dir" 2>/dev/null || echo "No projects directory found. Create ~/projects/"
    return
  fi
  if [ -d "$projects_dir/$1" ]; then
    cd "$projects_dir/$1" && echo "Switched to $1"
  else
    echo "Project '$1' not found. Available:"
    ls -1 "$projects_dir" 2>/dev/null
  fi
}

# List running claude agent processes
function agents() {
  local procs=$(ps aux | grep '[c]laude' | grep -v 'grep')
  if [ -z "$procs" ]; then
    echo "No claude processes running."
  else
    echo "$procs"
  fi
}
