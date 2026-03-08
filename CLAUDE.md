# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation

```zsh
# Home machine
~/dotfiles/install.sh home

# Work machine
~/dotfiles/install.sh work
```

`install.sh` installs Homebrew, Oh My Zsh + plugins, Brewfile packages, creates symlinks for all configs, and compiles Gemini CLI commands from workflow Markdown files. After running, copy `.credentials.example` → `.credentials` and fill in values.

After any changes to `agents/workflows/` or `agents/skills/`, re-run `install.sh` to sync symlinks and recompile CLI commands.

## Repository Architecture

This is a **profile-based dotfiles system** with two profiles: `home` and `work`. The active profile is stored in `~/.dotfiles_profile` and controls which identity and aliases are loaded.

### Configuration Loading Order

`.zshrc` → reads `~/.dotfiles_profile` → sources `zsh/common.zsh` → sources `zsh/home.zsh` or `zsh/work.zsh` → sources `aliases/common.zsh` + profile-specific aliases.

### Git Identity Switching

`.gitconfig` uses `includeIf` directives to conditionally load `git/work.gitconfig` or `git/home.gitconfig` based on the working directory path (`~/Documents/work/`, `~/Documents/code/rmd/`, `~/Documents/personal/`).

### Agent System (`agents/`)

The `agents/` directory is the single source of truth for all AI agent configurations, shared across Gemini CLI, Antigravity, and Claude Code:

- **`agents/rules/`** — Global rules, engineering standards, and persona definitions (Markdown files)
- **`agents/workflows/`** — Reproducible task templates with YAML frontmatter; auto-compiled to Gemini CLI commands (e.g., `pm-prd.md` → `gemini pm:prd`)
- **`agents/skills/`** — Specialized skill modules, each directory containing a `SKILL.md`

`install.sh` symlinks these into `~/.gemini/antigravity/` and runs `.lee/bin/compile_cli_commands.py` to generate TOML command files in `~/.gemini/commands/`.

### Key Utilities (`.lee/bin/`)

- `compile_cli_commands.py` — Reads `agents/workflows/*.md` YAML frontmatter, outputs TOML to `~/.gemini/commands/`
- `agent-worktree` — Manages git worktrees for isolated agent task execution
- `gemini-exec` — Gemini CLI execution wrapper

### Homebrew Packages

Managed via `Brewfile`. Notable: `mise` (runtime version manager), `eza` (ls replacement), `gh`, `gemini-cli`, `awscli`, `azure-cli`.

### Gemini CLI & MCP

`gemini/settings.json` configures MCP servers (GitHub via Copilot API, Azure, Chrome DevTools) and uses `{{HOME}}` placeholders that are substituted by `install.sh` at install time. The model is `gemini-3-flash-preview`.

### VS Code / Cursor

`vscode/settings.json` is symlinked to both VS Code and Cursor user settings directories.
