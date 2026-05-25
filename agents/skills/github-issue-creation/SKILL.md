---
name: github-issue-creation
description: End-to-end process for creating engineering-ready GitHub issues from high-level inputs.
---

# GitHub Issue Creation Skill

This skill defines the complete process of transforming a high-level feature request or bug report into an engineering-ready GitHub issue.

> [!IMPORTANT]
> This is a documentation-only workflow. Only create the GitHub issue. Do NOT implement fixes, modify code, or make repository changes beyond creating the issue.

## 1. Context Synchronization
- Identify the current repository and any relevant existing documentation or code.
- If input is too vague, ask clarifying questions to ensure the "Definition of Ready" can be met.

## 2. Information Gathering & Analysis
- **Analyze Input**: Evaluate the user's high-level request (feature or bug).
- **Determine Type**: Classify as Feature Enhancement, Bug Report, or Technical Debt.
- **Identify Repository**: Ensure you are targeting the correct repository (defaulting to the current one).

## 3. Requirement Formatting
Structure the issue to meet the "Definition of Ready" in the product management standards (`agents/standards/product-management.md`):

### For Features
- **User Story**: Format as "As a [user], I want [action], so that [benefit]."
- **Acceptance Criteria (AC)**: Clear, numbered list of conditions including edge cases.
- **Technical Notes**: Specific technical constraints, code references, or architectural considerations.

### For Bugs
- **Problem Statement**: Clear description of the unexpected behavior.
- **Steps to Reproduce**: Numbered steps to trigger the bug.
- **Expected vs. Actual Behavior**: Contrast what should happen vs. what is happening.
- **Environment Context**: OS, browser, branch/environment if applicable.

## 4. GitHub Execution
- **Tool Selection**: Use the `gh` CLI (`gh issue create`).
- **Construct the command**:
  - `--title`: Concise and descriptive (e.g., "Feature: [Summary]" or "Bug: [Summary]").
  - `--body`: The full formatted requirement from Step 3 (use `--body-file` for long multiline bodies).
  - `--label`: Apply relevant labels (repeat the flag, e.g. `--label feature --label product-ready`).
  - `--repo <owner>/<repo>`: Only if targeting a repo other than the current one.
- **Confirmation**: `gh issue create` prints the issue URL — present it to the user.
