# dotfiles

## Setup
1. **Configure SSH for GitHub**: [GitHub Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
2. **Clone dotfiles**:
   ```zsh
   git clone git@github.com:8888/dotfiles.git ~/dotfiles
   ```
3. **Run Installation**:
   The script installs Homebrew, Oh My Zsh + plugins, Brewfile packages, and sets up all symlinks for shell configs, Git, VS Code/Cursor, and Gemini/Antigravity agents.
   ```zsh
   # Home machine
   ~/dotfiles/install.sh home

   # Work machine
   ~/dotfiles/install.sh work
   ```
4. **Finalize**:
   - Copy `.credentials.example` → `.credentials` and fill in real values.
   - Set `$GITHUB_PERSONAL_ACCESS_TOKEN` in your environment for MCP GitHub access.
   - Create `~/.pgpass` if needed (see below).

## Manual Steps
- Create `~/.pgpass` (not version controlled). Set correct permissions:
  ```zsh
  chmod 0600 ~/.pgpass
  ```
  Format:
  ```
  localhost:5432:<dbname>:<user>:<password>
  ```

## Agent Configuration
Gemini CLI and Antigravity are configured via `agents/` and `gemini/settings.json`. See [GEMINI_AGENT_ARCHITECTURE.md](GEMINI_AGENT_ARCHITECTURE.md) for full details.
