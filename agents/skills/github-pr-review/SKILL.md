---
name: github-pr-review
description: Detailed technical steps for performing a GitHub Pull Request review using MCP tools.
---

# GitHub PR Review Skill

This skill provides the exact sequence of MCP tool calls and logic required to perform a professional code review on GitHub.

## 1. Gather Context

### Identify Target PR
- If no URL is provided:
  - Run `git remote get-url origin` to find the repo.
  - Parse `owner` and `repo` from the URL.
  - Use `list_pull_requests(state='open', sort='created', direction='desc')` to find the most recent PR.
- Use `get_me` to identify your authenticated username.

### Read Documentation & History
- Use `pull_request_read(method='get')` for description and metadata.
- Use `pull_request_read(method='get_diff')` for the actual code changes.
- **Deduplication Check**: Use `pull_request_read` with methods `get_review_comments`, `get_comments`, and `get_reviews`. 
  - **CRITICAL**: Read all existing feedback to avoid repeating comments.

## 2. Technical Analysis
Review the diff for:
- **Bugs/Logic**: Correctness and edge cases.
- **Security**: Secret exposure, injections, unsafe patterns.
- **Performance**: Inefficiency, leak potential, expensive operations.
- **Standards**: Adherence to project conventions and `engineering-standards.md`.
- **Context**: Use `get_file_contents` if you need more context around a diff.

## 3. Submit Feedback

### Initialize Review
- Use `pull_request_review_write(method='create')` without an `event` to create a pending review.

### Post Findings
- Iterate through unique findings.
- **Check for existence**: If a similar comment already exists in the PR history, skip it.
- For new findings, use `add_comment_to_pending_review`:
  - `side`: 'RIGHT' for new code.
  - `subjectType`: 'LINE'.

### Finalize
- Check if you are the author of the PR.
- Use `pull_request_review_write(method='submit_pending')`.
- **Events**:
  - `APPROVE`: If code is solid and you are NOT the author.
  - `REQUEST_CHANGES`: If blocking issues exist and you are NOT the author.
  - `COMMENT`: If you are the author (self-review) or have non-blocking feedback.
