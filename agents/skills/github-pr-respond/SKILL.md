---
name: github-pr-respond
description: Steps for processing and responding to GitHub PR review feedback.
---

# GitHub PR Response Skill

This skill outlines how to technicaly address and reply to code review comments on a GitHub Pull Request.

## 1. Context Synchronization
- Fetch PR details and branch info using `pull_request_read(method='get')`.
- Retrieve all review threads via `pull_request_read(method='get_review_comments')`.
- **Local Setup**: 
  - `git fetch origin`
  - `git checkout <branch-name>`
  - Ensure your local environment matches the PR state.

## 2. Analysis & Response Strategy
Classify each unresolved comment:
- **Implement**: You agree. Plan the fix.
- **Clarify**: Information is missing. Plan a question.
- **Discuss/Decline**: You have a technical reason for the current approach. Plan a professional explanation.

## 3. Execution
- **Modify Code**: Apply fixes using file editing tools.
- **Verification**: Run tests to ensure the fixes work and didn't break existing functionality.
- **Push**: 
  - `git add .`
  - `git commit -m "Refactor: Address review feedback regarding [topic]"`
  - `git push origin <branch>`

## 4. GitHub Interaction
- Reply to specific threads using `pull_request_review_write` or equivalent comment tools.
- **Formatting**:
  - For fixes: "Done. Fixed in [short-hash]."
  - For declines: Provide a technical "Why" (referencing performance, security, or project rules).
  - Use a collaborative and grateful tone.
