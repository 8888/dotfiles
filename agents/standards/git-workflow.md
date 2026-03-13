# Git Workflow Standards

## Commits
- **Atomic commits:** Small, focused, single-purpose. Never bundle unrelated changes.
- **Imperative messages:** Describe what the commit does (e.g., "Add user authentication middleware").
- Review `git diff HEAD` before every commit to catch accidental inclusions.

## Repository Hygiene
- Never commit build artifacts, binaries, caches, or dependency directories (`dist/`, `node_modules/`, `__pycache__/`, etc.).
- Proactively verify `.gitignore` covers generated files.

## Secrets
- Never commit API keys, passwords, tokens, or credentials.
- Use `.env` files and ensure they are gitignored. Provide `.env.example` with dummy values.
- Sanitize sensitive values when presenting logs or output.
