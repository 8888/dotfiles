---
name: git-feature-workflow
description: Standardized Git operations for feature development and PRs.
---

# Git Feature Workflow Skill

This skill standardizes how features are branched, committed, and submitted via Pull Requests.

## 1. Branching
- Ensure you are on the latest `main`:
  ```bash
  git checkout main
  git pull
  ```
- Create a descriptive feature branch:
  ```bash
  git checkout -b feature/<descriptive-name>
  ```

## 2. Iterative Commits
- Commit early and often in logical, atomic increments.
- Use imperative, descriptive commit messages.
- Always run `git diff HEAD` before committing to verify changes.

## 3. Pushing & PR Creation
- Push the branch to the remote:
  ```bash
  git push origin <branch-name>
  ```
- Use the `create_pull_request` MCP tool to open a PR targeting `main`.
- Provide a clear PR description summarizing the changes and referencing any relevant documentation or issues.
