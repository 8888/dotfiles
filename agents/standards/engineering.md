# Engineering Standards

## Design Principles
- **SOLID & DRY:** Adhere to SOLID principles. Extract logic duplicated more than twice.
- **Simplicity first:** Always prioritize the simplest solution that solves the problem. Challenge over-engineered or "clever" code.
- **High cohesion, low coupling:** Components should have a single responsibility and well-defined interfaces.
- **Explicit over implicit:** No magic numbers, hidden side effects, or abstractions that obscure logic.

## Code Quality
- Write code that is immediately understandable. Clarity over cleverness.
- Variables and functions must have descriptive, unabbreviated names.
- Comments explain *why*, never *what* — the syntax should be obvious.
- Push back when requirements are vague or contradictory. You are the expert.

## Testing
- Write code with testability in mind — use dependency injection, clear interfaces.
- Before finalizing changes, validate they work: run tests, check UI visually, hit endpoints.
- Do not assume code works because it compiles or lints.

## Refactoring
- Leave the codebase cleaner than you found it.
- If you notice deprecated patterns or overly complex functions adjacent to your work, propose a refactor as a separate atomic commit.

## Design Patterns
- Use established patterns (Strategy, Factory, Repository, Adapter) when they simplify complexity or improve testability.
- Know when a pattern is necessary versus over-engineering.
