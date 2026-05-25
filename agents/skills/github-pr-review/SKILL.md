---
name: github-pr-review
description: Detailed technical steps for performing a GitHub Pull Request review using the gh CLI.
---

# GitHub PR Review Skill

This skill provides the exact sequence of `gh` CLI calls and logic required to perform a professional code review on GitHub.

## 1. Gather Context

### Identify Target PR
- If no PR number/URL is provided:
  - Run `gh pr view --json number,headRefName` to detect the PR for the current branch.
  - If that fails (no PR for the branch), run `gh pr list --state open --sort created --limit 10 --json number,title,headRefName,author` and pick the intended one.
- Identify your authenticated username: `gh api user --jq .login`.

### Read Documentation & History
- Description and metadata: `gh pr view <num> --json title,body,author,baseRefName,headRefName,state,labels`.
- The actual code changes: `gh pr diff <num>`.
- Existing feedback (read **all** of it to avoid repeating comments):
  - Line comments: `gh api repos/{owner}/{repo}/pulls/<num>/comments --paginate`
  - Issue-level comments: `gh api repos/{owner}/{repo}/issues/<num>/comments --paginate`
  - Prior reviews: `gh api repos/{owner}/{repo}/pulls/<num>/reviews --paginate`
  - **CRITICAL**: Cross-reference before posting so you never duplicate an existing comment.

## 2. Technical Analysis
Review the diff for:
- **Bugs/Logic**: Correctness and edge cases.
- **Security**: Secret exposure, injections, unsafe patterns.
- **Performance**: Inefficiency, leak potential, expensive operations.
- **Standards**: Adherence to project conventions and `engineering.md`.
- **Context**: Read the file directly (or `gh api repos/{owner}/{repo}/contents/<path>?ref=<headRef>`) if you need more context around a diff hunk.

## 3. Submit Feedback

Build a **single review** with all line-level comments in one request — the REST API accepts a `comments` array, so there is no pending-review dance.

### Construct the payload
Write the review to a JSON file (or pipe via `--input -`):

```json
{
  "body": "<overall summary>",
  "event": "<COMMENT | APPROVE | REQUEST_CHANGES>",
  "comments": [
    { "path": "src/foo.js", "line": 42, "side": "RIGHT", "body": "<finding>" }
  ]
}
```

- `side`: `RIGHT` for new/changed code; `LEFT` for removed lines.
- For a multi-line comment, add `"start_line"` alongside `"line"`.
- **Check for existence**: skip any finding that matches an existing comment from Step 1.

### Choose the event
- `APPROVE`: code is solid and you are **not** the author.
- `REQUEST_CHANGES`: blocking issues exist and you are **not** the author.
- `COMMENT`: you are the author (self-review) or feedback is non-blocking.

(Confirm authorship by comparing `gh api user --jq .login` against the PR author from Step 1.)

### Submit
```bash
gh api --method POST repos/{owner}/{repo}/pulls/<num>/reviews --input review.json
```

If you only have an overall comment and no line-level notes, `gh pr review <num> --comment|--approve|--request-changes --body "..."` is sufficient.
