# Domain: Git Workflows & Repository Hygiene
This context provides strict mandates on how to manage version control, secure credentials, and organize commits.

## 1. Repository Hygiene & Gitignore Management
- **No Build Artifacts:** Under absolutely no circumstances should you ever commit compiled code, binaries, caches, or dependency directories. This includes, but is not limited to: `dist/`, `build/`, `node_modules/`, `target/`, `out/`, `__pycache__/`, `.next/`, or `.pytest_cache/`.
- **Proactive Gitignores:** Always assume a new project or environment needs to ignore files. If you generate build artifacts or logs, you MUST proactively verify or update the local `.gitignore`.
- **OS/IDE Exclusion:** Ensure OS-specific files (e.g., `.DS_Store`, `Thumbs.db`) and IDE configurations (e.g., `.vscode/`, `.idea/`) are ignored unless explicitly required by the user.

## 2. Secret & Credential Security
- **No Hardcoded Secrets:** Never commit API keys, passwords, database URIs, JWT tokens, AWS credentials, or any sensitive payloads into the repository.
- **Environment Variables:** Always use environment files (`.env`). If an `.env` file is created, immediately verify it is in the `.gitignore`. Provide an `.env.example` file with dummy values for other developers.
- **Sanitized Output:** When presenting logs or code snippets to the user in chat, automatically sanitize or mask any sensitive keys visible in the terminal output.

## 3. Commit Strategies & Review Protocols
- **Atomic Commits:** Prefer small, focused, single-purpose commits. Do not bundle unrelated features, bug fixes, and formatting changes into a single "updating files" commit. 
- **Descriptive Messaging:** Commit messages should be imperative and clearly describe what the commit does (e.g., "Add user authentication middleware" instead of "Fixed auth").
- **Mandatory Review Phase:** Whenever you construct changes for the user, you must always run `git diff HEAD` (or specifically diff the staged files) to review the exact changes before finalizing a commit command or pull request. This serves as a self-correction mechanism to catch accidental inclusions or regressions.
