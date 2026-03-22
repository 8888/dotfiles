# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation

```zsh
# Home machine
~/dotfiles/install.sh home

# Work machine
~/dotfiles/install.sh work
```

`install.sh` installs Homebrew, Oh My Zsh + plugins, Brewfile packages, and creates symlinks for all configs. After running, copy `.credentials.example` → `.credentials` and fill in values.

After any changes to `agents/skills/` or `gemini/commands/`, re-run `install.sh` to sync symlinks.

## Agent Rule: Never Edit Config Files Directly

Never edit files in their installed locations (e.g. `~/.zshrc`, `~/.gitconfig`, `~/.claude/settings.json`). Always edit the source file in this repo and let `install.sh` handle symlinking. If a config location is not yet tracked in this repo, add the file here and add the symlink to `install.sh` first.

## Agent Rule: Auto-run install.sh

After making any changes to files that require `install.sh` to take effect, **run it yourself** before finishing the task. Do not leave it for the user to run manually.

Changes that require `install.sh`:
- `agents/skills/` — skill symlinks to `~/.claude/commands/` and Gemini
- `gemini/commands/` — Gemini command symlinks
- `gemini/settings.json` or `gemini/trustedFolders.json` — require template expansion
- `claude/settings.json`, `claude/CLAUDE.md`, `claude/statusline-command.sh` — Claude Code config symlinks
- `Brewfile` or `Brewfile.home` / `Brewfile.work` — package installation
- `.zshrc`, `.gitconfig`, `.gitignore_global`, `.vimrc`, `.bash_profile` — dotfile symlinks
- `vscode/settings.json` — VS Code / Cursor symlinks
- `wezterm/` — WezTerm config symlinks

Use the active profile (read from `~/.dotfiles_profile`) when running:
```zsh
~/dotfiles/install.sh $(cat ~/.dotfiles_profile)
```

## Repository Architecture

This is a **profile-based dotfiles system** with two profiles: `home` and `work`. The active profile is stored in `~/.dotfiles_profile` and controls which identity and aliases are loaded.

### Configuration Loading Order

`.zshrc` → reads `~/.dotfiles_profile` → sources `zsh/common.zsh` → sources `zsh/home.zsh` or `zsh/work.zsh` → sources `aliases/common.zsh` + profile-specific aliases.

### Git Identity Switching

`.gitconfig` uses `includeIf` directives to conditionally load `git/work.gitconfig` or `git/home.gitconfig` based on the working directory path (`~/Documents/work/`, `~/Documents/code/rmd/`, `~/Documents/personal/`).

### Agent System (`agents/`)

The `agents/` directory contains shared, tool-agnostic AI agent resources:

- **`agents/standards/`** — Domain knowledge files (engineering, product management, git, cloud architecture, design). Symlinked to `~/.gemini/docs/` for Gemini auto-loading. Referenced by `claude/CLAUDE.md` for Claude Code.
- **`agents/skills/`** — Specialized skill modules, each directory containing a `SKILL.md`. Tool-agnostic process guides used by both Claude Code and Gemini CLI.

### Tool-Native Configurations

- **`claude/`** — Claude Code config. `CLAUDE.md` → `~/.claude/CLAUDE.md`, `settings.json` → `~/.claude/settings.json`, `hooks/` contains post-edit linting hook.
- **`gemini/`** — Gemini CLI config. `AGENTS.md` → `~/.gemini/AGENTS.md`, `commands/` → `~/.gemini/commands/` (hand-written TOML commands, organized by `dev/`, `pm/`, `designer/`, `architect/`). `settings.json` uses `{{HOME}}` placeholders expanded at install time.

### Key Utilities (`.lee/bin/`)

- `agent-worktree` — Manages git worktrees for isolated agent task execution
- `awsls`, `awssm` — AWS utility scripts

### Homebrew Packages

Managed via `Brewfile`. Notable: `mise` (runtime version manager), `eza` (ls replacement), `gh`, `gemini-cli`, `awscli`, `azure-cli`.

### VS Code / Cursor

`vscode/settings.json` is symlinked to both VS Code and Cursor user settings directories.
