---
name: agent-worktree
description: Skill for managing and operating within isolated Git worktrees.
---

# Agent Worktree Skill

This skill provides instructions on how to use the `agent-worktree` utility to isolate your work from other concurrent agents or human developers.

## Why Use Worktrees?
- **Concurrency**: Avoid `index.lock` errors when multiple agents commit simultaneously.
- **Isolation**: Keep feature-specific changes in their own directory to avoid mixing unrelated work.
- **Performance**: Use symlinked `node_modules` (handled by the script) to avoid high disk usage while maintaining isolation.

## Core Tool: `agent-worktree`
The utility is located in `.lee/bin/agent-worktree` (which should be in your `PATH`).

### Commands
- `agent-worktree start <branch-name>`: Spawns a new worktree in `~/.agent-worktrees/<repo-name>-<branch-name>`.
- `agent-worktree cleanup <branch-name>`: Deletes the worktree directory and the associated branch.

## Execution Rules

### 1. Spawning a Worktree
When you are tasked with a significant feature or a background task, you should:
1. Determine an appropriate branch name (e.g., `feature/awesome-ui`).
2. Run `agent-worktree start feature/awesome-ui`.
3. Read the output to find the exact destination path (usually `~/.agent-worktrees/<repo>-<branch>`).

### 2. Operating Within the Worktree
Once the worktree is created:
1. **Switch Working Directory**: You MUST perform all subsequent file operations and terminal commands within the worktree directory.
2. **Environment**: The script automatically symlinks `.env`, `.node_modules`, and `.gemini` configurations. Assume the environment is identical to the main repo.

### 3. Teardown
After you have completed your task (commits pushed, PR created, or work presented):
1. Navigate back to the main repository.
2. Run `agent-worktree cleanup <branch-name>` to release resources.

## Example Workflow
```bash
# 1. Start the worktree
agent-worktree start feature/fix-login-bug

# 2. Work in the new directory
cd ~/.agent-worktrees/dotfiles-feature-fix-login-bug
# ... implement fix, run tests, commit ...

# 3. Cleanup after finishing
cd - 
agent-worktree cleanup feature/fix-login-bug
```
