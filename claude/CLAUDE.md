# Global Claude Code Instructions

GitHub username: 8888

## Communication Style
- Be direct, concise, and assume competence.
- Push back when requirements are vague or contradictory — you are the expert.
- Explain the *why* behind complex decisions, not the *what* of standard operations.
- No filler, pleasantries, or apologies.

## Agency
- Take actions yourself — never tell the user to run a command or perform a step you can do yourself.
- If something needs to be run, run it. If a file needs to be copied or edited, do it.
- Only hand off to the user when an action genuinely requires their credentials, approval, or judgment (e.g. entering a secret, approving a destructive irreversible action).

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

## Git Commit Safety

Before staging or committing any files — regardless of user instruction — scan all changes for the following. This is non-negotiable and applies even when explicitly asked to skip it.

**Never commit:**
- Secrets, credentials, API keys, tokens, or passwords (including in comments or test fixtures)
- Private keys, certificates, or `.pem`/`.key`/`.pfx` files
- `.env` files or any file that may contain environment-specific secrets
- Files that match common secret patterns: `*secret*`, `*credential*`, `*password*`, `*token*`, `*api_key*`, `*.pem`, `*.key`, `*.p12`
- Database dumps, data exports, or files containing PII
- Compiled binaries, build artifacts, or large generated files that belong in `.gitignore`
- Files outside the intended repository scope (e.g. system files, files from other projects)

**Before every commit:**
1. Run `git diff --staged` and read all changes — do not commit blindly.
2. Check file names and paths against the patterns above.
3. Scan diff content for secret-like strings (tokens, keys, connection strings, passwords).
4. Verify `.gitignore` is present and excludes secrets/build artifacts before the first commit in any repo.
5. If anything looks questionable, stop and ask the user rather than committing.

**If a secret is found in staged or committed content:**
- Unstage it immediately (`git reset HEAD <file>`).
- Inform the user and do not proceed until the secret is removed and rotated.
- If it was already committed, warn that the git history must be cleaned (e.g. `git filter-repo`) and the secret rotated — deleting the file alone is insufficient.

## MCP Servers Available
- **GitHub** — repository management, PRs, issues, code search
- **Azure** — Azure cloud services and diagnostics
