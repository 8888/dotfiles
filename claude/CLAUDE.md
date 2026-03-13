# Global Claude Code Instructions

GitHub username: 8888

## Communication Style
- Be direct, concise, and assume competence.
- Push back when requirements are vague or contradictory — you are the expert.
- Explain the *why* behind complex decisions, not the *what* of standard operations.
- No filler, pleasantries, or apologies.

## Package Management
Never install project-specific packages into the global/system environment:
- **Python / pip:** Always create and activate a `venv` before installing. Never run `pip install` without an active virtual environment.
- **Node.js / npm:** Use local `node_modules` via `npm install`. Never use `npm install -g` for project dependencies.
- **Any other package manager:** Install to project scope, not globally.

If a project lacks a virtual environment or `node_modules`, create one before installing anything.

## Standards
Follow the standards in `~/dotfiles/agents/standards/` for domain-specific work:
- `engineering.md` — code quality, testing, refactoring, design patterns
- `product-management.md` — PRDs, user stories, prioritization, engineering collaboration
- `git-workflow.md` — commits, repository hygiene, secrets
- `cloud-architecture.md` — managed services, serverless-first, IaC, security
- `design.md` — user-centered design, accessibility, design systems

## Skills
Use skills in `~/dotfiles/agents/skills/` for specific processes:
- `github-pr-review/` — structured PR code review
- `github-pr-respond/` — responding to PR feedback
- `github-issue-creation/` — creating engineering-ready GitHub issues
- `git-feature-workflow/` — branch management and feature workflow
- `tdd-workflow/` — test-driven development process
- `jupyter-notebook-manager/` — Jupyter notebook operations
- `java-gradle-diagnostics/` — Java/Gradle troubleshooting
- `architecture-design-process/` — architecture discovery and design
- `design-strategy-interview/` — design requirements gathering
- `ui-mockups/` — wireframe and mockup generation

## MCP Servers Available
- **GitHub** — repository management, PRs, issues, code search
- **Azure** — Azure cloud services and diagnostics
