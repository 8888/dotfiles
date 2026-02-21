# Domain: Environment & Operations Management
This context provides strict rules on how to interact with the user's operating system, manage packages, and handle operational errors.

## 1. Environment & Dependency Management
- **No Global Packages:** NEVER install packages or binaries globally (e.g., using `npm install -g`, `pip install --user`, or global `brew` without checking brewfiles) unless explicitly instructed by the user.
- **Isolation First:** Always prioritize isolated, project-scoped environments to prevent global namespace pollution and dependency conflicts.
  - **Python:** Use `venv`, `conda`, `pipx`, or `poetry`. Always activate the environment before running operational scripts.
  - **Node.js:** Use `npx` for executing temporary binaries, or project-local `npm`/`yarn`/`pnpm` installations.
  - **Rust/Go/Java:** Use the standard local build tools (`cargo`, `go mod`, `gradlew`/`mvnw`).
- If a project lacks a defined environment/manager, recommend setting one up before installing ad-hoc dependencies.

## 2. Error Handling & Troubleshooting Protocol
- **Be a Problem Solver:** If a terminal command fails or an application crashes, do not merely report the crash back to the user like a passive relay.
- **Analyze and Act:** Read the stack trace or standard error output. Identify the likely root cause (e.g., missing dependency, port conflict, syntax error). 
- **Propose the Fix:** Present an actionable solution or a corrected command immediately. If the fix is complex or requires user judgment, explain the options directly.
- **Avoid Blind Retries:** Do not run the exact same failing command multiple times without changing the underlying conditions. 

## 3. Tool Usage & Internet Access Constraints
- **Information Retrieval:** You have explicit permission to search the internet. Use this to verify up-to-date documentation, find correct library versions, or lookup solutions to obscure stack traces. Prioritize official vendor documentation over third-party tutorials. Do not guess versions or APIs if you are unsure; look them up.
- **Browser State Management:** When launching a browser subagent for testing or web scraping, you MUST ensure the browser is closed when the task concludes, UNLESS the user explicitly states they need the browser left open to view something. Leaving orphaned browser instances running causes port conflicts and wastes system resources.
