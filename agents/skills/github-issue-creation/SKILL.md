---
name: github-issue-creation
description: Steps for transforming high-level inputs into detailed, engineering-ready GitHub issues using product standards.
---

# GitHub Issue Creation Skill

This skill defines the process of creating a high-quality GitHub issue that provides all the context an engineer needs to design and implement a solution.

## 1. Information Gathering & Analysis
- **Analyze Input**: Evaluate the user's high-level request (feature or bug).
- **Determine Type**: Classify the issue as a Feature Enhancement, Bug Report, or Technical Debt.
- **Identify Repository**: Ensure you are targeting the correct repository (defaulting to the current one).

## 2. Requirement Formatting
All issues must be structured to meet the "Definition of Ready" in `product-management-standards.md`:

### For Features
- **User Story**: Format as "As a [user], I want [action], so that [benefit]."
- **Acceptance Criteria (AC)**: Provide a clear, numbered list of conditions that must be met. Include edge cases.
- **Technical Notes**: Detail specific technical constraints, existing code references, or architectural considerations.

### For Bugs
- **Problem Statement**: Clear description of the unexpected behavior.
- **Steps to Reproduce**: Numbered list of steps to trigger the bug.
- **Expected vs. Actual Behavior**: Contrast what should happen vs. what is happening.
- **Environment Context**: If applicable, specify OS, browser, or specific branch/environment.

## 3. GitHub Execution
- **Tool Selection**: Use the `github:` MCP tool (e.g., `create_issue`).
- **Construct Payload**:
  - `title`: Concise and descriptive (e.g., "Feature: [Summary]" or "Bug: [Summary]").
  - `body`: The full formatted requirement from Step 2.
  - `labels`: Apply relevant labels (e.g., `feature`, `bug`, `enhancement`, `product-ready`).
- **Confirmation**: Once created, provide the link to the new issue to the user.
