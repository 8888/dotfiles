---
name: atlassian
description: Search and read Confluence pages and Jira issues via Atlassian REST API using curl. Work profile only — requires ATLASSIAN_EMAIL, ATLASSIAN_API_TOKEN, and ATLASSIAN_URL env vars.
---

# Atlassian (Confluence & Jira)

Interact with Confluence and Jira via their REST APIs using curl. **Work profile only** — requires credentials from `.claude_credentials.work`.

## Prerequisites

Before any API call, verify credentials are available:

```bash
[[ -z "$ATLASSIAN_EMAIL" || -z "$ATLASSIAN_API_TOKEN" || -z "$ATLASSIAN_URL" ]] && echo "ERROR: Atlassian credentials not set. Are you on the work profile?" && exit 1
```

If credentials are missing, tell the user to switch to the work profile or check `.claude_credentials.work`.

## Authentication

All requests use HTTP Basic Auth with the API token:

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  "${ATLASSIAN_URL}/rest/api/..."
```

## Confluence

Base path: `${ATLASSIAN_URL}/wiki/api/v2`

### Search pages

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/wiki/api/v2/pages?title=<title>&space-id=<space-id>&limit=25"
```

Use CQL for advanced search:

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -G --data-urlencode "cql=type=page AND text ~ \"search term\"" \
  "${ATLASSIAN_URL}/wiki/rest/api/content/search"
```

### Get page content

```bash
# Get page body in storage format (HTML)
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/wiki/api/v2/pages/<page-id>?body-format=storage"
```

### List spaces

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/wiki/api/v2/spaces?limit=50"
```

### Create page

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -X POST "${ATLASSIAN_URL}/wiki/api/v2/pages" \
  -d '{
    "spaceId": "<space-id>",
    "status": "current",
    "title": "Page Title",
    "body": {
      "representation": "storage",
      "value": "<p>Page content in Confluence storage format (XHTML)</p>"
    }
  }'
```

### Update page

```bash
# First GET the page to obtain the current version number, then:
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -X PUT "${ATLASSIAN_URL}/wiki/api/v2/pages/<page-id>" \
  -d '{
    "id": "<page-id>",
    "status": "current",
    "title": "Updated Title",
    "body": {
      "representation": "storage",
      "value": "<p>Updated content</p>"
    },
    "version": {
      "number": <current-version + 1>,
      "message": "Updated by agent"
    }
  }'
```

## Jira

Base path: `${ATLASSIAN_URL}/rest/api/3`

### Search issues (JQL)

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -G --data-urlencode "jql=project = PROJ AND status = 'In Progress' ORDER BY updated DESC" \
  --data-urlencode "fields=summary,status,assignee,priority,updated" \
  --data-urlencode "maxResults=25" \
  "${ATLASSIAN_URL}/rest/api/3/search"
```

### Get issue

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/rest/api/3/issue/<issue-key>?fields=summary,description,status,assignee,priority,comment"
```

### Get issue comments

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/rest/api/3/issue/<issue-key>/comment"
```

### Create issue

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -X POST "${ATLASSIAN_URL}/rest/api/3/issue" \
  -d '{
    "fields": {
      "project": { "key": "PROJ" },
      "summary": "Issue title",
      "description": {
        "type": "doc",
        "version": 1,
        "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "Description" }] }]
      },
      "issuetype": { "name": "Task" }
    }
  }'
```

### Add comment

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -X POST "${ATLASSIAN_URL}/rest/api/3/issue/<issue-key>/comment" \
  -d '{
    "body": {
      "type": "doc",
      "version": 1,
      "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "Comment text" }] }]
    }
  }'
```

### Transition issue (change status)

```bash
# List available transitions
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/rest/api/3/issue/<issue-key>/transitions"

# Apply transition
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -X POST "${ATLASSIAN_URL}/rest/api/3/issue/<issue-key>/transitions" \
  -d '{ "transition": { "id": "<transition-id>" } }'
```

### List projects

```bash
curl -s --fail-with-body \
  -u "${ATLASSIAN_EMAIL}:${ATLASSIAN_API_TOKEN}" \
  "${ATLASSIAN_URL}/rest/api/3/project/search?maxResults=50"
```

## Tips

- Always pipe JSON responses through `jq` for readability.
- Jira description and comment bodies use **Atlassian Document Format (ADF)**, not plain text or markdown.
- Confluence storage format is XHTML — not markdown.
- Pagination: check for `_links.next` (Confluence v2) or `startAt`/`total` (Jira) in responses.
- Use `--fail-with-body` to get error details on non-2xx responses.
- `ATLASSIAN_URL` should be the base domain (e.g. `https://mycompany.atlassian.net`) with no trailing slash.
