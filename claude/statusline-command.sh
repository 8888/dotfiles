#!/bin/sh
# Claude Code status line - mirrors p10k rainbow prompt style
# Segments: user@host | cwd | git branch | model | context %

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Shorten home directory
short_cwd=$(echo "$cwd" | sed "s|^$HOME|~|")

# Git branch (skip lock to avoid blocking)
git_branch=""
if [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Build status line using ANSI colors (will appear dimmed in Claude Code)
# Cyan: user@host | Blue: cwd | Magenta: git | Yellow: model | Green/Red: context
user_host="\033[36m$(whoami)@$(hostname -s)\033[0m"
dir_part="\033[34m${short_cwd}\033[0m"

parts="${user_host}  ${dir_part}"

if [ -n "$git_branch" ]; then
  parts="${parts}  \033[35m${git_branch}\033[0m"
fi

if [ -n "$model" ]; then
  parts="${parts}  \033[33m${model}\033[0m"
fi

if [ -n "$remaining" ]; then
  # Green if plenty of context, yellow if getting low, red if critical
  remaining_int=$(printf "%.0f" "$remaining")
  if [ "$remaining_int" -gt 30 ]; then
    ctx_color="\033[32m"
  elif [ "$remaining_int" -gt 10 ]; then
    ctx_color="\033[33m"
  else
    ctx_color="\033[31m"
  fi
  parts="${parts}  ${ctx_color}ctx:${remaining_int}%\033[0m"
fi

printf "${parts}\n"
