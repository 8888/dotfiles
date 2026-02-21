---
description: Create React/Storybook design systems
---

Goal: Create a custom, high-fidelity Design System for a web app project. Tech Stack: React, TypeScript, Tailwind CSS, and Storybook.

Process: Do not generate any code yet. We will follow a two-step process:

Step 1: The Design Strategy Interview
Ask me 3-5 pointed, high-level questions to determine the "Mood and Feel" and functional requirements of the application.
- Do not ask for hex codes or specific font names.
- Ask about the desired emotional impact and brand voice (e.g., "Minimalist and Sophisticated" vs. "Energetic and Bold").
- Ask about information density and user flow (e.g., "Data-dense analytics platform" vs. "Clean, conversion-focused landing page").
- Ask about the target audience and their primary goals.
- Inquire about specific accessibility needs or environmental constraints (e.g., "Used in high-glare environments" or "Focus on elder usability").

Step 2: The Execution (To be done AFTER I answer)
Once I answer, YOU will make the executive design decisions. You will engineer a design system that balances beautiful aesthetics with rigorous usability and accessibility standards (ensuring color contrast ratios meet WCAG AA/AAA).

You will choose the color palette, typography pairings, and spatial system. Then, you will generate the implementation:

Artifact 1: Project Implementation
- You are responsible for setting up or adding to the project structure.
- Implementation details:
    - **React Components**: Create atomic components (e.g., `Button.tsx`, `Input.tsx`, `Card.tsx`) in `src/components/design-system`.
    - **Styling**: Use Tailwind CSS for styling. Ensure `tailwind.config.js` is updated with your semantic color/font choices.
    - **Storybook**: Create stories (e.g., `Button.stories.tsx`) for each component to demonstrate states (hover, focus, disabled, variants).
    - **Accessibility**: Ensure proper ARIA attributes and keyboard navigation are built into the React components.

Artifact 2: styleguide.toml
- A TOML file acting as a "System Prompt" for future AI agents.
- It must capture the intentional logic and purposeful design decisions made.
- Structure it with:
    - [theme.colors]: Semantic mapping (e.g., primary, destructive, surface).
    - [theme.typography]: Font families, weights, and scale logic.
    - [components.rules]: Layout, spacing, and interaction guidelines.
    - [accessibility.standards]: Explicit rules for contrast and usability.
- This file must provide the "Implementation Contract". It must be so comprehensive that a frontend engineer (or AI) can read it and instantly understand the design tokens and rules.

Action: Please start with Step 1 and ask me your design strategy questions.
