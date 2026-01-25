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
*   `gemini/`: Gemini CLI configurations and personas.
*   `.lee/bin/`: Custom utility scripts.

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

## Gemini Configuration & Portability
The Gemini CLI configuration handles absolute paths via Git filters:
*   **On Disk**: Files contain absolute paths (resolved via symlinks).
*   **In Git**: Paths are automatically replaced with `__HOME__` placeholders during commit via the `gemini-home` filter.
