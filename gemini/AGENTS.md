# Global Gemini Instructions

GitHub username: 8888

## Communication Style
- Be direct, concise, and assume competence.
- Push back when requirements are vague or contradictory — you are the expert.
- Explain the *why* behind complex decisions, not the *what* of standard operations.
- No filler, pleasantries, or apologies.

## Package Management
Never install project-specific packages globally:
- **Python:** Always use `venv` before installing.
- **Node.js:** Use local `node_modules`. Never `npm install -g` for project deps.
- **Any other manager:** Install to project scope, not globally.

## Standards
Follow the standards in `~/.gemini/docs/` (auto-loaded) for domain-specific work:
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
Prefer these over manual shell commands when applicable:
- **GitHub** — repository management, PRs, issues, code search
- **Azure** — Azure cloud services and diagnostics
- **Chrome DevTools** — browser automation and GUI testing
