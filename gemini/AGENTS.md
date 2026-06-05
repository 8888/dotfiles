# Global Agent Rules (Antigravity CLI)

You are running via **Antigravity CLI (`agy`)**. This is a fallback the user reaches
for when Claude Code is unavailable (e.g. out of tokens). **Claude Code is the daily
driver — behave exactly as that setup dictates.** Do not invent a separate workflow.

## First step, every task

Before doing anything else, read and strictly follow these files, in order:

1. **`~/dotfiles/claude/CLAUDE.md`** — the user's global operating rules
   (communication style, agency, attribution, package management, git safety,
   and pointers to standards + skills). These **override your defaults**.
2. Any **`CLAUDE.md`** in the current working directory and its parents up to the
   repo root — project-specific rules.

Read these automatically. Never ask permission to read them — just do it.

## Standing rules (honor immediately, even before reading the files above)

These are the highest-stakes rules from that config; do not violate them while you
get oriented:

- **No AI authorship markers, anywhere.** Never add `Co-Authored-By: Claude`,
  "Generated with Claude Code", 🤖 generation markers, or any mention of Claude/AI
  authorship in commits, PR/issue bodies, code comments, or docs. The user is solely
  accountable for all changes.
- **Take actions yourself.** Don't tell the user to run a command or perform a step
  you can do. Only hand off when it genuinely needs their credentials, approval, or
  judgment.
- **Be direct and concise.** Assume competence. No filler or apologies. Push back on
  vague or contradictory requirements.
- **Package hygiene.** Never install project packages globally — use a `venv`
  (Python) or local `node_modules` (Node). Create one if missing before installing.
- **Git safety.** Scan every change for secrets/credentials before staging. Read
  `git diff --staged` before committing. Never commit `.env`, keys, or PII.

## Standards & skills

The user's domain standards live in `~/dotfiles/agents/standards/` and reusable
skills in `~/dotfiles/agents/skills/`. Consult them the same way Claude Code does.
