# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation

```zsh
# Home machine
~/dotfiles/install.sh home

# Work machine
~/dotfiles/install.sh work

# Remote server (Ubuntu)
# First run: server/bootstrap.sh as root on a fresh droplet
# Then: ~/dotfiles/install.sh server
~/dotfiles/install.sh server
```

`install.sh` installs packages (Homebrew on macOS, apt on Linux server), Oh My Zsh + plugins, and creates symlinks for all configs. After running, copy `.credentials.example` → `.credentials` and fill in values.

After any changes to `agents/skills/`, re-run `install.sh` to sync symlinks.

## Agent Rule: Never Edit Config Files Directly

Never edit files in their installed locations (e.g. `~/.zshrc`, `~/.gitconfig`, `~/.claude/settings.json`). Always edit the source file in this repo and let `install.sh` handle symlinking. If a config location is not yet tracked in this repo, add the file here and add the symlink to `install.sh` first.


## Repository Architecture

This is a **profile-based dotfiles system** with two profiles: `home` and `work`. The active profile is stored in `~/.dotfiles_profile` and controls which identity and aliases are loaded.

### Configuration Loading Order

`.zshrc` → reads `~/.dotfiles_profile` → sources `zsh/common.zsh` → sources `zsh/home.zsh` or `zsh/work.zsh` → sources `aliases/common.zsh` + profile-specific aliases.

### Git Identity Switching

`.gitconfig` uses `includeIf` directives to conditionally load `git/work.gitconfig` or `git/home.gitconfig` based on the working directory path (`~/Documents/work/`, `~/Documents/code/rmd/`, `~/Documents/personal/`).

### Agent System (`agents/`)

The `agents/` directory contains shared, tool-agnostic AI agent resources:

- **`agents/standards/`** — Domain knowledge files (engineering, product management, git, cloud architecture, design). Referenced by `claude/CLAUDE.md` for Claude Code.
- **`agents/skills/`** — Specialized skill modules, each directory containing a `SKILL.md`. Symlinked into `~/.claude/commands/` by `install.sh`.

### Tool-Native Configurations

- **`claude/`** — Claude Code config. `CLAUDE.md` → `~/.claude/CLAUDE.md`, `settings.{profile}.json` → `~/.claude/settings.json` (one complete file per profile), `hooks/` contains post-edit linting hook.

### Key Utilities (`.lee/bin/`)

- `agent-worktree` — Manages git worktrees for isolated agent task execution
- `awsls`, `awssm` — AWS utility scripts

### Homebrew Packages

Managed via `Brewfile`. Notable: `mise` (runtime version manager), `eza` (ls replacement), `gh`, `awscli`, `azure-cli`.

### VS Code

`vscode/settings.json` is symlinked to the VS Code user settings directory.
