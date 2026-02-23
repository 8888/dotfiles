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

## AI & Agent Infrastructure

This repository features a unified, Markdown-first agent architecture that integrates seamlessly with both the **Gemini CLI** and **Antigravity**.

### Core Architecture
- **Markdown-First**: Personas, rules, and workflows are authored as standard Markdown files in `agents/`.
- **Unified Configuration**: A single source of truth for all tools. `install.sh` automatically compiles and symlinks these configurations into the appropriate local directories (`~/.gemini/`).
- **MCP Integration**: Uses the Model Context Protocol (MCP) to provide agents with powerful tools like GitHub repository management, Azure cloud integration, and Chrome browser automation.

### Gemini CLI
Run specialized agent tasks directly from your terminal.
- **Usage**: `gemini <namespace>:<command>` (e.g., `gemini dev:task "fix the bug"`).
- **Compilation**: Workflows in `agents/workflows/` are automatically mapped to CLI namespaces. A file named `pm-prd.md` becomes the `pm:prd` command.

### Antigravity
The high-performance agent platform used within this workspace.
- **Slash Commands**: Trigger workflows using `/` commands (e.g., `/dev-ticket`).
- **Skills**: Specialized modules in `agents/skills/` extend Antigravity's capabilities (e.g., `tdd-workflow`).
- **Task View**: Uses `task_boundary` and `task.md` to provide transparent, multi-step progress tracking.

### MCP Servers
- **GitHub (`github`)**: Full repository management, PR creation, and code search. Requires `$GITHUB_PERSONAL_ACCESS_TOKEN`.
- **Azure (`azure`)**: Integration with Azure cloud services.
- **Chrome DevTools (`chrome-devtools`)**: Browser automation and GUI testing.

### Extending the System
1. **Rules**: Add `.md` files to `agents/rules/` to define new personas or engineering standards.
2. **Workflows**: Add `.md` files with YAML frontmatter to `agents/workflows/`.
3. **Skills**: Create new directories in `agents/skills/` with a `SKILL.md` file.
4. **Sync**: Run `./install.sh [home|work]` to apply your changes.

---

For a full catalog of available rules, workflows, and skills, see [GEMINI_AGENT_ARCHITECTURE.md](GEMINI_AGENT_ARCHITECTURE.md).
