---
name: tdd-workflow
description: Formalized steps for Test-Driven Development (TDD).
---

# TDD Workflow Skill

This skill provides a structured approach to implementing features using Test-Driven Development.

## 1. Test Planning
- Brainstorm a comprehensive list of test cases based on the design requirements.
- Aim for high coverage (e.g., 85%+).
- Present the list to the user for approval.

## 2. Red: Write Failing Tests
- Implement the test cases in the appropriate test directory (mirroring `src`).
- Use mocks for external dependencies (files, APIs, databases) where appropriate.
- **Verification**: Run the tests and ensure they fail as expected (since the feature code doesn't exist yet).

## 3. Green: Make Tests Pass
- Formulate a step-by-step implementation plan.
- Implement the feature code to satisfy the tests.
- **Verification**: Run the tests. Fix the implementation until all tests (new and existing) pass.

## 4. Refactor
- Review the code for clarity, modularity, and adherence to `engineering-standards.md`.
- Ensure all tests still pass after refactoring.
