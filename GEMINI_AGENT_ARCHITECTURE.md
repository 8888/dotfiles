# Gemini & Antigravity Unified Agent Architecture

This repository uses a single, unified Markdown-first approach for configuring both the **Gemini CLI** and the **Antigravity** agent platform. 

By writing context docs (personas/rules) and commands (workflows) once as Markdown, we eliminate duplicate files and simplify source control.

## Directory Structure (`~/dotfiles/agents/`)

The `agents/` directory is the single source of truth for all agentic configurations:

- `rules/`: Global context files and persona definitions.
  - **Antigravity**: Symlinked to `~/.gemini/antigravity/rules`. These act as global rules.
  - **Gemini CLI**: Symlinked to `~/.gemini/docs/` for context. `GLOBAL_RULES.md` is also linked to `~/.gemini/GEMINI.md` to establish global behavior.
  - Current rules: `GLOBAL_RULES.md`, `engineering-standards.md`, `environment-and-ops.md`, `git-workflow-rules.md`
  - Current personas: `senior-developer-persona.md`, `senior-designer-persona.md`, `senior-product-manager-persona.md`, `principal-architect-persona.md`
- `workflows/`: Markdown files containing reproducible agent tasks.
  - **Antigravity**: Symlinked to `~/.gemini/antigravity/global_workflows`.
  - **Gemini CLI**: Compiled automatically into `~/.gemini/commands/` TOML files during installation.
- `skills/`: Complex tool sets and modular agent capabilities.
  - **Antigravity**: Symlinked to `~/.gemini/antigravity/global_skills`.
  - **Gemini CLI**: Accessible via the shared symlink.

## Rules Catalog
Located in `agents/rules/`, these files establish the persona and operational standards.

| File | Description |
|---|---|
| [GLOBAL_RULES.md](file:///Users/leecostello/dotfiles/agents/rules/GLOBAL_RULES.md) | Universal directives for efficiency, tone, and safety. |
| [engineering-standards.md](file:///Users/leecostello/dotfiles/agents/rules/engineering-standards.md) | Explicit rules for code quality, system design, and testing. |
| [environment-and-ops.md](file:///Users/leecostello/dotfiles/agents/rules/environment-and-ops.md) | Rules for OS interaction, package management, and error handling. |
| [git-workflow-rules.md](file:///Users/leecostello/dotfiles/agents/rules/git-workflow-rules.md) | Mandates for version control hygiene and commit organization. |
| [product-management-standards.md](file:///Users/leecostello/dotfiles/agents/rules/product-management-standards.md) | Standards for requirement gathering and ticket refinement. |
| [orchestration-standards.md](file:///Users/leecostello/dotfiles/agents/rules/orchestration-standards.md) | Standards for sub-agent spawning and headless execution. |
| [principal-architect-persona.md](file:///Users/leecostello/dotfiles/agents/rules/principal-architect-persona.md) | Focuses on high-level cloud architecture and system design. |
| [senior-developer-persona.md](file:///Users/leecostello/dotfiles/agents/rules/senior-developer-persona.md) | Expert coding, debugging, and implementation focus. |
| [senior-designer-persona.md](file:///Users/leecostello/dotfiles/agents/rules/senior-designer-persona.md) | Focuses on UI/UX, design systems, and visual excellence. |
| [senior-product-manager-persona.md](file:///Users/leecostello/dotfiles/agents/rules/senior-product-manager-persona.md) | Focuses on PRDs, user stories, and feature prioritization. |

## Workflows Catalog
Located in `agents/workflows/`. These are reproducible multi-step tasks.

| Command | Description |
|---|---|
| `architect:cloud-architect` | Cloud architecture design & implementation. |
| `dev:task` | Flexible developer for ad-hoc tasks. |
| `dev:ticket` | Structured feature implementation (SDLC). |
| `dev:github-code-review` | Review PRs with professional feedback. |
| `dev:github-respond-to-review` | Address PR feedback & manage reviews. |
| `pm:prd` | Generate PRDs from ideas or problems. |
| `pm:github-issue` | Create a highly-detailed GitHub issue. |
| `pm:prioritize` | Analyze and prioritize feature roadmaps. |
| `pm:refine` | Resolve PM questions & doc updates. |
| `pm:stories` | Break requirements into User Stories. |
| `pm:task` | Flexible PM for ad-hoc tasks. |
| `designer:feature-design` | Create and refine new feature designs. |
| `designer:create-design-system` | Create React/Storybook design systems. |
| `designer:update-design-system` | Expand and iterate existing design systems. |
| `designer:create-style-guide` | Create web style guides & systems. |
| `product:delivery-orchestrator` | End-to-end delivery management from intake to PR. |
| `start-agent-task` | Start an isolated agent task using Git Worktrees. |

## Skills Catalog
Located in `agents/skills/`. Specialized toolsets that extend agent capabilities.

| Skill | Description |
|---|---|
| `agent-worktree` | Managing and operating within isolated Git worktrees. |
| `architecture-design-process` | Guidelines for cloud architecture design & documentation. |
| `design-strategy-interview` | Guidelines for conducting design discovery interviews. |
| `git-feature-workflow` | Standardized Git operations for feature development. |
| `github-issue-creation` | Transforming inputs into engineering-ready GitHub issues. |
| `github-pr-respond` | Processing and responding to GitHub PR feedback. |
| `github-pr-review` | Performing technical PR reviews using MCP tools. |
| `java-gradle-diagnostics` | Diagnosing and repairing Java/Gradle environment issues. |
| `jupyter-notebook-manager` | Programmatic manipulation of Jupyter Notebook (.ipynb) files. |
| `mood-board-capture` | Capture text, images, or links into the local Mood Board. |
| `tdd-workflow` | Formalized steps for Test-Driven Development (TDD). |
| `ui-mockups` | Guidance on producing UI wireframes and concept mockups. |

## Gemini Settings (`~/dotfiles/gemini/settings.json`)

`gemini/settings.json` is symlinked to `~/.gemini/settings.json`. It defines:

- **MCP Servers**: Available to both the Gemini CLI and Antigravity.
  - `github`: Remote MCP via GitHub Copilot API. Requires `$GITHUB_PERSONAL_ACCESS_TOKEN`. Provides full repo management, PRs, issues, and code search.
  - `azure`: Runs via `npx @azure/mcp`. Provides Azure cloud service integration (AppLens, resource management).
  - `chrome-devtools`: Runs via `npx chrome-devtools-mcp`. Provides browser automation and inspection.
- **Tool Permissions**: Allowlist for `run_shell_command` and shell auto-accept behavior.
- **Experimental Features**: `enableAgents` and `skills` flags for Antigravity discovery.

## How It Works

### The Markdown-First Workflow
Historically, the Gemini CLI required custom commands to be written in TOML format, often injecting long persona markdown files via macro `@{...}` syntax. This bloated the prompts and led to high token usage. 

Now, we write everything in Markdown:
1. **Define a Rule/Persona**: Create `agents/rules/senior-developer-persona.md`. Agent systems load this context implicitly via their native rules/docs engines.
2. **Define a Workflow**: Create `agents/workflows/dev-task.md`. Use YAML frontmatter to give it a description, followed by the specific markdown prompt for the workflow. 
3. **Compile**: When you run `./install.sh`, the python script `.lee/bin/compile_cli_commands.py` iterates over `agents/workflows/*.md`. It generates clean `.toml` files (e.g., `dev/task.toml`) inside `~/.gemini/commands/` for the CLI.

### Symlink Map
| Source | Target | Used By |
|---|---|---|
| `agents/rules/GLOBAL_RULES.md` | `~/.gemini/GEMINI.md` | Gemini CLI (global rules) |
| `agents/rules/` | `~/.gemini/docs/` | Gemini CLI (context docs) |
| `agents/rules/` | `~/.gemini/antigravity/rules` | Antigravity (global rules) |
| `agents/workflows/` | `~/.gemini/antigravity/global_workflows` | Antigravity |
| `agents/skills/` | `~/.gemini/antigravity/global_skills` | Antigravity |
| `gemini/settings.json` | `~/.gemini/settings.json` | CLI & Antigravity |

### Pros
- **Single Source of Truth**: Edit a workflow once; it updates everywhere.
- **Idempotent Installation**: The installer cleans its own compiled artifacts so the system stays in sync with your dotfiles.
- **Token Efficiency**: Personas are no longer textually injected into every workflow prompt. By leaning on native rules systems, you save tokens on every request.
- **No Git Path Filters**: We rely on relative paths or implicit tool behaviors, meaning the complex smudge/clean Git filters for `__HOME__` replacements are retired.

## Authoring Guide

### 1. Creating a New Rule or Persona
Create a Markdown file in `agents/rules/` (e.g., `agents/rules/qa-engineer.md`). Describe the role, constraints, and operational mode. The agent tools will load this into context.

### 2. Creating a New Workflow
Create a Markdown file in `agents/workflows/` (e.g., `agents/workflows/pm-write-prd.md`). 
*Note: To ensure the Gemini CLI organizes this into a subfolder, use a single hyphen in the basename. `pm-write-prd.md` will become `~/.gemini/commands/pm/write-prd.toml`.*

```markdown
---
description: Assistant for writing exhaustive Product Requirements Documents
---
Your goal is to write a PRD...
```

### 3. Creating a New Skill
Create a folder in `agents/skills/` (e.g., `agents/skills/my-new-skill/`). Inside, include at minimum a `SKILL.md` file using YAML frontmatter (for `name` and `description`) followed by markdown instructions for the skill.

## Installation & Updates
Whenever you author or modify workflows, simply re-run your profile setup:

```bash
cd ~/dotfiles
./install.sh home  # or work
```
This will rebuild the symlinks (linking `agents/` components to `~/.gemini/antigravity/` and `~/.gemini/`) and regenerate the CLI's `.toml` command files from your `.md` workflows.
