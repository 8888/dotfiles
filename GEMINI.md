# Dotfiles Directory

## Directory Overview

This directory contains personal configuration files (dotfiles) for setting up a development environment on macOS. It includes configurations for `zsh`, `git`, `vim`, and other tools. The `install.sh` script automates the process of creating symbolic links to these configuration files from the user's home directory.

## Key Files

*   `.zshrc`: This is the main configuration file for the Zsh shell. It sets up the shell theme (`powerlevel10k`), plugins (`oh-my-zsh`), environment variables (for Java, NVM), and sources other configuration files.
*   `install.sh`: This script automates the setup process by creating symbolic links from the user's home directory to the dotfiles in this repository. It sets up Git content filters for Gemini configuration and links settings for VS Code and Cursor.
*   `personal-install.sh`: This script is intended for creating symbolic links for personal and sensitive files, such as `.credentials`, which should not be checked into version control.
*   `.gitconfig`: This file configures Git with the user's details, sets `vi` as the default editor, and defines a global `.gitignore` file. It also includes a conditional configuration for a specific directory.
*   `.aliases.zsh`: This file likely contains custom shell aliases.
*   `.p10k.zsh`: This is the configuration file for the `powerlevel10k` Zsh theme.
*   `vscode/settings.json`: This file contains user settings for Visual Studio Code.
*   `gemini/settings.json`: This file contains settings for the Gemini CLI. It is symlinked to `~/.gemini/settings.json`.
*   `gemini/docs/senior-developer-persona.md`: A shared markdown file defining the "Senior Developer" persona (Role, Communication Style, Expertise) used by multiple Gemini commands via file injection.
*   `gemini/commands/.gitattributes`: Configures the `gemini-home` Git filter for `.toml` files to handle path portability.
*   `iterm/Profiles.json`: This file contains profiles for the iTerm2 terminal emulator.
*   `README.md`: Provides manual installation steps for tools like Homebrew, Git, and Oh My Zsh.

## Custom Scripts

This repository contains custom scripts in the `.lee/bin` directory:

*   `awsls`: Lists all EC2 instances in the configured AWS region, displaying details like instance ID, state, type, IP addresses, and the 'Name' tag.
*   `awssm`: Lists secrets from AWS Secrets Manager that have "prod" in their name.

## Gemini Configuration & Portability

The Gemini CLI configuration uses a sophisticated setup to ensure portability while maintaining the benefits of absolute paths and symlinks.

*   **Shared Personas:** Common instructions are stored in `gemini/docs/` and injected into commands using the `@{path}` syntax.
*   **Path Portability (Git Filters):**
    *   The `install.sh` script configures a custom Git filter (`gemini-home`).
    *   **On Disk:** Command files (e.g., `dev.toml`) contain the absolute path (e.g., `/Users/username/.gemini/...`) so that the CLI can resolve file injections correctly through the symlinks.
    *   **In Git:** When committed, the absolute path is automatically replaced with a `__HOME__` placeholder. When checked out, `__HOME__` is replaced with the local user's home directory.
    *   This allows the dotfiles to be shared across machines with different usernames without breaking the absolute path references required by the CLI.

## Usage

1.  **Clone the repository:**
    ```bash
    git clone <repository-url> ~/.dotfiles
    ```
2.  **Run the installation script:**
    ```bash
    ~/.dotfiles/install.sh
    ```
    This will create symbolic links for the configuration files and configure the necessary Git filters.

3.  **Follow manual installation steps:**
    The `README.md` file contains instructions for installing necessary tools like Homebrew, Git, Oh My Zsh, and more.

## Development Conventions

The repository uses symbolic links to manage configurations, which is a common convention for dotfiles repositories. The `install.sh` script is idempotent, as it removes existing files and links before creating new ones.