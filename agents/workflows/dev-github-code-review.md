---
description: Review PRs with professional feedback
---

# Goal
Your task is to perform a comprehensive code review of a GitHub Pull Request (PR) provided by the user. You must access the PR using the available GitHub tools, analyze the changes, and provide feedback directly on the PR as comments. You will either Request Changes if issues are found, Approve if the code is solid, or Comment if you have non-blocking feedback.

# Workflow

1.  **Get PR Details:**
    - **Determine Target PR:**
        - If the user provides a PR URL, use it and parse the owner, repo, and PR number.
        - **If no PR URL is provided:**
            - Use `run_shell_command` with `git remote get-url origin` to find the repository's origin URL.
            - Parse the `owner` and `repo` name from the URL (handle both `https://github.com/owner/repo.git` and `git@github.com:owner/repo.git` formats).
            - Use `list_pull_requests` (state='open', sort='created', direction='desc') to fetch recent PRs for the identified repo.
            - Take the most recently created open PR (`pullNumber`) from the results.
    - **Identify User:** Use `get_me` to find the username of the authenticated user (the agent).
    - Use `pull_request_read` (method='get') to read the PR description, context, and **author**.
    - Use `pull_request_read` (method='get_diff') to retrieve the file changes.
    - **Fetch Existing Comments & Reviews:**
        - Use `pull_request_read` (method='get_review_comments') to retrieve existing review threads.
        - Use `pull_request_read` (method='get_comments') to retrieve conversation-level comments.
        - Use `pull_request_read` (method='get_reviews') to retrieve existing review summaries.
        - **You MUST read all of these to avoid repeating yourself or others.**

2.  **Review Process:**
    - Analyze the diffs carefully. Look for:
        - **Bugs/Logic Errors:** Does the code do what it claims?
        - **Security:** are there injections, exposed secrets, or unsafe practices?
        - **Performance:** Are there inefficient loops or database calls?
        - **Style/Standards:** Does it follow the project's likely conventions (naming, structure)?
        - **Tests:** Are there sufficient tests for the changes?
    - If you need to see the full file content (context beyond the diff), use `get_file_contents`.

3.  **Submit Feedback:**
    - **Step 3a: Create Pending Review:**
        - Use `pull_request_review_write` with `method='create'`. Omit the `event` parameter to create a pending review.

    - **Step 3b: Post Individual Findings:**
        - **Deduplication Strategy (MANDATORY):**
            - Iterate through every intended finding.
            - Cross-reference with both `review_comments` and `get_comments` from Step 1.
            - **CRITICAL:** If a substantially similar comment exists (regardless of author, but especially if YOU posted it), **DO NOT POST**.
        - For each *new, unique* issue found in Step 2:
            - Use `add_comment_to_pending_review`.
            - **Parameters:**
                - `path`: The relative path to the file.
                - `line`: The line in the diff (the last line of the range for multi-line).
                - `side`: 'RIGHT' (for new changes).
                - `body`: The feedback text.
                - `subjectType`: 'LINE'.

    - **Step 3c: Submit Final Summary and Action:**
        - **Deduplication Strategy (Summary):**
            - Check `get_reviews` from Step 1.
            - If a review summary from the authenticated user already exists for this PR, **DO NOT SUBMIT A NEW REVIEW**. Instead, inform the user that a summary already exists.
        - **Check Author:** Compare the authenticated user (from Step 1) with the PR author (from Step 1).
        - **Action:** Use `pull_request_review_write` with `method='submit_pending'`.
        - **Parameters:** Provide a concise final summary in the `body`.
        - **Event Logic:**
            - **IF User == Author (Self-Review):** You MUST use `event='COMMENT'`.
            - **IF User != Author (Peer Review):**
                - `event='REQUEST_CHANGES'` if there are blocking issues found.
                - `event='APPROVE'` if the code is solid and no blocking issues were identified.
                - `event='COMMENT'` if you have non-blocking feedback but no major concerns.

4.  **Summary:**
    - Provide a brief confirmation to the user that the review and individual line-level comments have been posted.
