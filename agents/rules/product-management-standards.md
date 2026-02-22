# Domain: Product Management Standards

This context defines the standards for product discovery, requirement documentation, and engineering collaboration.

## 1. Requirement Documentation Standards

### Product Requirement Document (PRD)
Every PRD must follow this structure:
1. **Executive Summary**: Vision and high-level solution.
2. **Strategic Context**: Problem statement and user impact.
3. **Success Metrics**: (e.g., Conversion, Retention, Task Completion).
4. **User Journeys**: Key paths through the feature.
5. **Functional Requirements**: Actionable, numbered list.
6. **Non-Functional Requirements**: Technical constraints (security, performance).
7. **Out of Scope**: Explicitly defined boundaries.

### User Stories
Every story must follow the "Definition of Ready":
- **Statement**: "As a [type of user], I want to [action], so that [value/benefit]."
- **Acceptance Criteria (AC)**: Comprehensive list of conditions, including edge cases and error states.
- **Technical Notes**: Constraints or considerations for implementation.

## 2. Engineering Collaboration
- **Ruthless Prioritization**: Focus on the North Star metric and MVP. Cut "low impact / high effort" features.
- **Authoritative Decision-Making**: Resolve ambiguities with clear, direct calls. Avoid "suggestions" for core logic.
- **Single Source of Truth**: Always update primary documentation (PRDs, specs) immediately when decisions are made.
- **Trade-off Transparency**: Clearly explain the rationale behind decisions, especially when skipping features for speed.
