# Dotfiles Directory

## Directory Overview

This repository uses a modular, profile-based architecture to manage configurations for both **Home** and **Work** environments from a single codebase.

### Core Philosophy
- **Commonality**: 90% of configurations (Git aliases, core ZSH logic, general tools) are shared.
- **Isolation**: Work-specific aliases, professional Git identities, and sensitive credentials are isolated into specific profiles.
- **Portability**: Symbolic links and dynamic sourcing ensure updates propagate to all machines.

## Directory Structure

- `zsh/`: Modular shell initialization (`common.zsh`, `home.zsh`, `work.zsh`).
- `aliases/`: Command shortcuts (`common.zsh`, `home.zsh`, `work.zsh`).
- `git/`: Git configuration modules (`common.gitconfig`, `work.gitconfig`, `home.gitconfig`).
- `agents/`: Tool-agnostic AI agent resources.
  - `standards/`: Domain knowledge (engineering, product management, git, cloud, design). Auto-loaded by Gemini via `~/.gemini/docs/`.
  - `skills/`: Specialized skill modules (`SKILL.md` per directory).
- `claude/`: Claude Code configuration (`CLAUDE.md`, `settings.json`, `hooks/`).
- `gemini/`: Gemini CLI configuration (`AGENTS.md`, `settings.json`, `commands/`, `trustedFolders.json`).
- `.lee/bin/`: Custom utility scripts.

## Key Files

- `.zshrc`: Bootstrap script. Reads `~/.dotfiles_profile` and sources the correct modular files.
- `.gitconfig`: Main Git template. Uses `includeIf` to switch identities by directory.
- `install.sh`: Setup script. Creates all symlinks and sets the local machine profile.

## Usage

```bash
# Home machine
./install.sh home

# Work machine
./install.sh work
```

## Agent System

Standards files in `agents/standards/` are the authoritative source for engineering, product management, git workflow, cloud architecture, and design conventions. They are:
- Auto-loaded by Gemini CLI via `~/.gemini/docs/` symlink
- Referenced from `claude/CLAUDE.md` for Claude Code sessions

Gemini CLI commands live in `gemini/commands/` as hand-written TOML files, organized by role (`dev/`, `pm/`, `designer/`, `architect/`). Symlinked to `~/.gemini/commands/` at install time.
