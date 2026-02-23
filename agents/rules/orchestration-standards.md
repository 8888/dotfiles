# Antigravity Orchestration Standards

This document establishes the standards for agents spawning other agents (sub-agents) to ensure reliability, safety, and operational clarity.

## 1. Isolation-First Policy
- **Never Work in Main**: Sub-agents should never perform broad changes directly in the main repository branch.
- **Mandatory Worktrees**: Always use the `agent-worktree` skill to create a dedicated environment for a task.
- **Cleanup**: The orchestrator is responsible for offering or performing cleanup of worktrees after a task is resolved or the branch is pushed.

## 2. Headless Execution
- **Unified Entrypoint**: Always use the `gemini-exec` utility script for spawning sub-agents. This ensures consistent path handling and rule loading.
- **YOLO Mode**: Automated sub-agents must run in `yolo` approval mode (`--approval-mode yolo`) to prevent them from hanging on interactive prompts in background processes.
- **Persona Specialization**: Explicitly specify the persona for the sub-agent (e.g., `Senior Developer`, `Product Manager`) to ensure the correct context is loaded.

## 3. State & Metadata Management (The Context Vault)
- **Problem**: Passing long PRDs or complex metadata via shell command strings is fragile and hits token/buffer limits.
- **Solution**: Create a `CONTEXT.md` or `PRD.md` file in the root of the worktree.
- **Implementation**: The orchestrator writes the metadata to the file, and the sub-agent's prompt simply says: "Read the requirements in CONTEXT.md and implement accordingly."

## 4. Path Safety
- **Absolute Paths**: When delegating, always provide the sub-agent with the absolute path of the worktree root.
- **Context Transition**: The orchestrator must explicitly `cd` into the worktree path or monitor it correctly.

## 5. Loop Control
- **Limit Iterations**: Automated review/respond loops must be capped (default: 3 iterations).
- **Human Escalation**: If agents become stuck or repeat themselves, stop execution and report to the user.
