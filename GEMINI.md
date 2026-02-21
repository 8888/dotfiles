# Dotfiles Directory

## Directory Overview

This repository uses a modular, profile-based architecture to manage configurations for both **Home** and **Work** environments from a single codebase.

### Core Philosophy
*   **Commonality**: 90% of configurations (Git aliases, core ZSH logic, general tools) are shared.
*   **Isolation**: Work-specific aliases (e.g., RubiconMD tools), professional Git identities, and sensitive credentials are isolated into specific profiles.
*   **Portability**: Symbolic links and dynamic sourcing ensure that updates to common files propagate to all machines.

## Directory Structure

*   `zsh/`: Modular shell initialization.
    *   `common.zsh`: Core setup (OMZ, mise, Java, PATH).
    *   `home.zsh` / `work.zsh`: Profile-specific environment variables.
*   `aliases/`: Command shortcuts.
    *   `common.zsh`: General purpose tools (Git, Docker, Python).
    *   `home.zsh` / `work.zsh`: Environment-specific shortcuts.
*   `git/`: Git configuration modules.
    *   `common.gitconfig`: Shared settings (editor, core behaviors).
    *   `work.gitconfig`: Professional identity (email, work-specific paths).
    *   `home.gitconfig`: Personal identity.
*   `agents/`: Unified agent configurations (rules, workflows, skills).
*   `gemini/`: Gemini CLI & Antigravity configuration.
    *   `settings.json`: MCP server definitions, tool permissions, and CLI settings. Symlinked to `~/.gemini/settings.json`.
*   `.lee/bin/`: Custom utility scripts (including the command compiler).

## Key Files

*   `.zshrc`: The bootstrap script. It reads `~/.dotfiles_profile` and dynamically sources the correct modular files.
*   `.gitconfig`: The main Git template. Uses `includeIf` to switch identities automatically based on the directory (e.g., switches to Work email in `~/Documents/work/`).
*   `install.sh`: The setup script. Creates all necessary symlinks and sets the local machine profile.
*   `personal-install.sh`: Legacy/Optional script for manual linking of non-versioned sensitive files.

## Usage

### 1. Installation
Run the installer with the desired profile:
```bash
# Home machine
./install.sh home

# Work machine
./install.sh work
```

### 2. Switching Profiles
To switch profiles manually, change the content of `~/.dotfiles_profile` to either `home` or `work` and restart the shell.

## Agent Configuration & Unified Architecture
We use a unified Markdown-first approach for both the Gemini CLI and Antigravity. Personas, workflows, and skills are authored once in `agents/` and applied everywhere.

For a deep dive into how to extend or use these agentic tools, see [GEMINI_AGENT_ARCHITECTURE.md](file:///Users/leecostello/dotfiles/GEMINI_AGENT_ARCHITECTURE.md).

## Compilation & Installation
The `install.sh` script automatically handles:
1. **Symlinking**: Maps dotfiles, `agents/` components, and `gemini/settings.json` into the appropriate `~/.gemini/` and Antigravity directories.
2. **CLI Command Compilation**: Runs `.lee/bin/compile_cli_commands.py` to generate the TOML command structure for the Gemini CLI from the Markdown workflows.

To update your agents after making changes to `agents/workflows/`, just re-run:
```bash
./install.sh [home|work]
```
