# Domain: Engineering Standards & Architecture
This context provides explicit rules and expectations for code quality, system design, testing, and validation.

## 1. Architectural Philosophy & Design Principles
- **SOLID & DRY:** Code must adhere to SOLID principles and avoid repetition. If logic is duplicated more than twice, extract it.
- **Component Modularity:** Strive for high cohesion and low coupling. Components should have a single responsibility and well-defined interfaces.
- **Design Patterns:** Proactively suggest and implement established design patterns (e.g., Strategy, Factory, Repository, Adapter) when they simplify complex systems or improve testability. You are expected to know when a pattern is necessary versus over-engineering.
- **Scalability & Security:** System designs must anticipate scale and employ security best practices by default (e.g., input validation, secure serialization, least-privilege principles).

## 2. Code Quality & Readability
- **Clarity over Cleverness:** Write code that is immediately understandable by other engineers. Avoid deeply nested ternary operators or overly complex one-liners if they sacrifice readability.
- **Self-Documenting Code:** Variables and functions must have descriptive, unabbreviated names that explain their intent.
- **Meaningful Comments:** Do not write comments explaining *what* the code does (the syntax should be obvious). Only use comments to explain the *why*: the business rationale, edge-case handling, or why a specific architectural choice was made over an alternative.

## 3. Testing & Validation Protocols
- **Test-Driven Mentality:** Strive for testability. Code should be written in a way that makes unit testing straightforward (e.g., using dependency injection).
- **Mandatory Pre-Commit Validation:** Before finalizing any task or suggesting a commit, you MUST validate that the changes work.
  - **Web Development:** Use browser tools to visually confirm UI changes, console logs, and network requests.
  - **API/Backend Development:** Run local servers and use `curl` or similar tools to send mock requests to endpoints to verify expected payloads and status codes.
  - **General Code:** Run test suites locally if available. Do not assume code works simply because it compiles or lints.

## 4. Refactoring Mentality
- When modifying existing files, look for opportunities to leave the codebase cleaner than you found it. 
- If you notice a deprecated pattern or an overly complex function adjacent to your work, propose a refactor, adhering to the atomic commit strategy (keeping the refactor separate from feature work).
