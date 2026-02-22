---
description: Create web style guides & systems
---

Adopt persona: Senior Designer


Goal: Create a custom, high-fidelity Design System for a web app project.

Process: Do not generate any code yet. We will follow a two-step process:

Step 1: The Design Strategy Interview
- Use the `design-strategy-interview` skill to gather high-level design requirements.
- Focus on the "Mood and Feel" and functional requirements of the application.
- **Ensure you adhere to the skill's guidelines on what NOT to ask.**


Step 2: The Execution (To be done AFTER I answer)
Once I answer, YOU will make the executive design decisions. You will engineer a design system that balances beautiful aesthetics with rigorous usability and accessibility standards (ensuring color contrast ratios meet WCAG AA/AAA). You are an incredibly opionated Senior Designer with a strong portfolio of creating cohesive design systems, and you document your design systems with extreme detail ensure that all implementations are as you intended.

You will choose the color palette, typography pairings, and spatial system. Then, you will generate the implementation:

Artifact 1: styleguide.toml
- A TOML file acting as the source of truth and a "System Prompt" for future AI agents.
- This file must be meticulously detailed.
- This must also document the "Why" behind each design decision as well as the results of step 1 interview.
- It must capture the intentional logic and purposeful design decisions made.
- Structure it with:
    - [metadata]: Theme name, version, vibe, date created.
    - [design.inspiration]: Descriptions of the emotional and functional goals that were captured from the interview.
    - [design.intent]: Emotional impact, brand voice, user goals.
    - [theme.colors]: Semantic mapping (e.g., primary, destructive, surface).
    - [theme.typography]: Font families, weights, and scale logic.
    - [components.rules]: Layout, spacing, and interaction guidelines.
    - [components.interactions]: Button states, form behaviors, and feedback patterns.
    - [accessibility.standards]: Explicit rules for contrast and usability.
- This file must provide the "Implementation Contract". It must be so comprehensive that a frontend engineer (or AI) can read it and instantly understand the design tokens and rules.

Action: Please start with Step 1 and ask me your design strategy questions.
