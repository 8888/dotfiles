#!/bin/sh
# Claude Code status line
# Segments: cwd | worktree+branch or branch | model | context % | total tokens

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
worktree_name=$(echo "$input" | jq -r '.worktree.name // ""')
worktree_branch=$(echo "$input" | jq -r '.worktree.branch // ""')

# Shorten home directory
short_cwd=$(echo "$cwd" | sed "s|^$HOME|~|")

# Git branch (skip lock to avoid blocking)
git_branch=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
fi

# Build status line using ANSI colors (will appear dimmed in Claude Code)
# Blue: cwd | Magenta: git/worktree | Yellow: model | Green/Red: context | Cyan: tokens
dir_part="\033[34m${short_cwd}\033[0m"
parts="${dir_part}"

# Worktree or branch segment
if [ -n "$worktree_name" ]; then
  wt_label="${worktree_name}"
  [ -n "$worktree_branch" ] && wt_label="${wt_label}:${worktree_branch}"
  parts="${parts}  \033[35mwt:${wt_label}\033[0m"
elif [ -n "$git_branch" ]; then
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

# Total tokens for session (input + output cumulative)
if [ "$total_input" -gt 0 ] || [ "$total_output" -gt 0 ]; then
  total=$(( total_input + total_output ))
  if [ "$total" -ge 1000000 ]; then
    total_fmt="$(printf "%.1fm" "$(echo "$total / 1000000" | bc -l)")"
  elif [ "$total" -ge 1000 ]; then
    total_fmt="$(printf "%.1fk" "$(echo "$total / 1000" | bc -l)")"
  else
    total_fmt="${total}"
  fi
  parts="${parts}  \033[36m${total_fmt}tok\033[0m"
fi

printf "${parts}\n"
