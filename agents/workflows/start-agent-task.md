---
description: Start an isolated agent task using Git Worktrees
---

# Start Agent Task

Use this workflow to kick off a complex development task in an isolated Git worktree. This prevents file contention and ensures a clean environment for the agent.

## User Persona: Orchestrator / Project Manager

## Steps

1. **Task Analysis**: 
   - Analyze the user's task request.
   - Determine an appropriate feature branch name (e.g., `feat/add-login-api`).

2. **Worktree Spawning**:
   // turbo
   - Execute the following command to create the worktree:
     ```bash
     agent-worktree start <branch-name>
     ```
   - Note the destination path returned by the command (usually `~/.agent-worktrees/<repo>-<branch>`).

3. **Workspace Transition**:
   - Inform the user that you are moving the task to the isolated worktree.
   - Shift your own operational context to the new directory. Every subsequent tool call MUST use this new path as the base.

4. **Agent Delegation**:
   - Invoke a specialized agent (like `@dev-task` or `@dev-ticket`) to perform the actual work.
   - **CRITICAL**: Explicitly instruct the delegated agent to ONLY work within the new worktree path.

5. **Completion & Cleanup**:
   - Once the delegated agent finishes, review the work.
   - Instruct the user on how to review and merge the branch.
   - Optional: Offer to run `agent-worktree cleanup <branch-name>` once the PR is merged.
