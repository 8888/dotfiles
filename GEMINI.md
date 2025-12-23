# Dotfiles Directory

## Directory Overview

This directory contains personal configuration files (dotfiles) for setting up a development environment on macOS. It includes configurations for `zsh`, `git`, `vim`, and other tools. The `install.sh` script automates the process of creating symbolic links to these configuration files from the user's home directory.

## Key Files

*   `.zshrc`: This is the main configuration file for the Zsh shell. It sets up the shell theme (`powerlevel10k`), plugins (`oh-my-zsh`), environment variables (for Java, NVM), and sources other configuration files.
*   `install.sh`: This script automates the setup process by creating symbolic links from the user's home directory to the dotfiles in this repository. It also links the settings for VS Code and Cursor.
*   `personal-install.sh`: This script is intended for creating symbolic links for personal and sensitive files, such as `.credentials`, which should not be checked into version control.
*   `.gitconfig`: This file configures Git with the user's details, sets `vi` as the default editor, and defines a global `.gitignore` file. It also includes a conditional configuration for a specific directory.
*   `.aliases.zsh`: This file likely contains custom shell aliases.
*   `.p10k.zsh`: This is the configuration file for the `powerlevel10k` Zsh theme.
*   `vscode/settings.json`: This file contains user settings for Visual Studio Code.
*   `gemini.settings.json`: This file contains settings for the Gemini CLI. It is symlinked to `~/.gemini/settings.json` by the `install.sh` script.
*   `iterm/Profiles.json`: This file contains profiles for the iTerm2 terminal emulator.
*   `README.md`: Provides manual installation steps for tools like Homebrew, Git, and Oh My Zsh.

## Custom Scripts

This repository contains custom scripts in the `.lee/bin` directory:

*   `awsls`: Lists all EC2 instances in the configured AWS region, displaying details like instance ID, state, type, IP addresses, and the 'Name' tag.
*   `awssm`: Lists secrets from AWS Secrets Manager that have "prod" in their name.

## Usage

1.  **Clone the repository:**
    ```bash
    git clone <repository-url> ~/.dotfiles
    ```
2.  **Run the installation script:**
    ```bash
    ~/.dotfiles/install.sh
    ```
    This will create symbolic links for the configuration files.

3.  **Follow manual installation steps:**
    The `README.md` file contains instructions for installing necessary tools like Homebrew, Git, Oh My Zsh, and more.

## Development Conventions

The repository uses symbolic links to manage configurations, which is a common convention for dotfiles repositories. The `install.sh` script is idempotent, as it removes existing files and links before creating new ones.
