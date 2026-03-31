---
name: review-permissions
description: Audit the current conversation for every permission prompt Claude generated, explain how to suppress each one in settings.json, and recommend whether to do so.
---

# Review Permissions Skill

Scan the current conversation for every instance where Claude asked the user to approve a tool call, then produce a structured audit with suppression instructions and a recommendation for each.

## 1. Identify Permission Prompts

Go through the full conversation from the beginning. For each tool call that required user approval, record:

- **Tool name** — the exact tool (e.g. `Bash`, `Write`, `mcp__github__push_files`)
- **Command / arguments** — the specific invocation that triggered the prompt (e.g. `brew install foo`, `git push --force`)
- **Why it was prompted** — was it missing from the `allow` list, or does it match a pattern in `deny`?

Group duplicates (same tool + same command pattern) as a single entry. Do not list tool calls that were auto-approved.

## 2. Explain the Suppression Config

For each identified permission prompt, show the exact JSON snippet to add to the `permissions.allow` array in `~/.claude/settings.json` (source: `~/dotfiles/claude/settings.json`) that would suppress it in future.

Use the correct pattern syntax:
- Bash commands: `"Bash(command subcommand:*)"` — include subcommands if needed for precision, use `*` wildcard for arguments
- Specific tools: `"ToolName"` (e.g. `"Write"`, `"Agent"`)
- MCP tools: `"mcp__server__tool_name"` or `"mcp__server__*"` for all tools on a server
- Named tool variants: use the most specific pattern that covers the use case without over-permitting

Show both the minimal (precise) pattern and the broader wildcard pattern where they differ, so the user can choose the scope.

## 3. Recommend: Add or Keep Prompt

For each entry, make a clear recommendation: **Add to allow** or **Keep as prompt**, with a one-sentence rationale.

Use this heuristic:
- **Add to allow** if: the operation is low-risk, reversible, idempotent, read-only, or routine for this type of project
- **Keep as prompt** if: the operation is destructive, irreversible, affects shared state (remote pushes, external services), involves credentials, or should always require conscious intent

Be direct — err toward fewer prompts for clearly safe operations and toward keeping prompts for anything with real blast radius.

## 4. Present the Audit Table

Output a markdown table with these columns:

| # | Tool / Command | Why Prompted | Config Snippet | Recommendation |
|---|---------------|-------------|----------------|----------------|

Follow the table with a summary count: X of Y prompts recommended for suppression.

## 5. Await User Decision

After the table, ask the user which entries (by number, range, or "all recommended") they want to add to the allow list.

Do not modify `settings.json` until the user responds.

## 6. Apply Selected Changes

For each entry the user approves:

1. Read `~/dotfiles/claude/settings.json`.
2. Add the config snippet to the `permissions.allow` array (maintaining alphabetical or logical grouping where possible).
3. Do not add duplicates — check if an equivalent pattern already exists.

After all edits, run:

```zsh
~/dotfiles/install.sh $(cat ~/.dotfiles_profile)
```

Confirm which entries were added and which (if any) were skipped as duplicates.
