---
name: capture-idea
description: Capture a random thought or product idea into the life project's ideas backlog for later review.
---

# Capture Idea Skill

Intake a freeform thought or idea and store it in the ideas backlog at `~/Documents/life/ideas/ideas.md`.

## Process

1. **Parse the idea** from the user's message — clean it up into a coherent title and description. Don't over-structure it, just make it readable.

2. **Categorize it** — use an existing `##` section heading if one fits, or create a new one if the idea is clearly a different domain. Current sections: Product Ideas.

3. **Append the entry** to `~/Documents/life/ideas/ideas.md` using this format:

```markdown
### [Idea Title]
**Added:** YYYY-MM-DD

[1-3 sentence description that captures the core of the idea clearly enough that context won't be lost later.]

---
```

4. **Confirm** with a single line: the idea title and which section it was added to.

## Notes
- Do not reorganize or reformat existing entries.
- If the idea is clearly related to an existing entry, add a brief "**Related:**" line referencing it.
- The date should always be today's actual date.
