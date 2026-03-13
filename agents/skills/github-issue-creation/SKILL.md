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
- **Tool Selection**: Use the GitHub MCP tools (e.g., `create_issue`).
- **Construct Payload**:
  - `title`: Concise and descriptive (e.g., "Feature: [Summary]" or "Bug: [Summary]").
  - `body`: The full formatted requirement from Step 3.
  - `labels`: Apply relevant labels (e.g., `feature`, `bug`, `enhancement`, `product-ready`).
- **Confirmation**: Present the issue URL to the user.
