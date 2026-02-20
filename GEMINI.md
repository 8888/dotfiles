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

## Agent Personas & Modular Workflows
The agent capabilities are customized through modular personas and slash commands located in `gemini/`. However, to be used universally inside Antigravity agent interactions, they are compiled into global **Workflows**.

### 1. Personas (`gemini/docs/`)
Personas define the "who" – the expertise, communication style, and guiding principles of the agent.
*   **Storage**: Markdown files in `gemini/docs/`.
*   **Examples**: `senior-developer-persona.md`, `principal-architect-persona.md`.
*   **Usage**: Included in commands to provide consistent context using the macro syntax: `@{__HOME__/.gemini/docs/persona.md}`.

### 2. Slash Commands (`gemini/commands/`)
Commands define the "what" – specific tasks or goals.
*   **Storage**: TOML files organized by domain (e.g., `dev/`, `pm/`).
*   **Naming Convention**: Organized in folders matching their category.
*   **Strategy**: Each command file contains a `description` and a `prompt` (which often includes a persona).

### 3. Antigravity Workflows Compilation (`~/.agents/workflows/`)
Because Antigravity leverages global `.md` files equipped with YAML frontmatter to act as slash commands, an automated script merges the personas and toml commands into flat workflow formats.

*   **Compilation Script**: `.lee/bin/compile_workflows.py`.
*   **Process**: It iterates through `gemini/commands/`, resolves any `@{.../.gemini/docs/persona.md}` macros, and writes the output directly to `.agents/workflows/`.
*   **Result**: A file like `dev/task.toml` becomes `~/.agents/workflows/dev-task.md`. Typing `/dev-task` inside Antigravity will now inject that exact workflow, including its injected modular persona.

*(Note: The install script automatically runs the workflow compiler during setup).*
