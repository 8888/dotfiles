---
name: google-workspace
description: Interface for interacting with Google Workspace via the gws CLI. Use this skill whenever the user asks about Gmail, Calendar, Drive, Docs, Sheets, Slides, Tasks, Chat, Forms, Meet, or cross-service workflows.
---

# Google Workspace (gws CLI)

Use the `gws` CLI to interact with Google Workspace services on behalf of the user.

## Before Executing Any Command

1. Read `~/dotfiles/.claude/skills/gws-shared/SKILL.md` for auth setup, global flags, security rules, and shell quoting gotchas.
2. Read the relevant sub-skill(s) listed below for the exact CLI syntax.

## Auth Check

```bash
gws auth status
```

If `token_valid` is false, run `gws auth login` and pause for the user to complete browser auth.

## Skills by Service

### Email
| Skill | Capability |
|-------|------------|
| `gws-gmail` | Core Gmail API — messages, threads, labels, drafts |
| `gws-gmail-triage` | Summarise unread inbox by sender/subject |
| `gws-gmail-send` | Send a new email |
| `gws-gmail-reply` / `gws-gmail-reply-all` | Reply to a thread |
| `gws-gmail-forward` | Forward a message |
| `gws-gmail-watch` | Stream new emails as NDJSON |

### Calendar & Scheduling
| Skill | Capability |
|-------|------------|
| `gws-calendar` | Core Calendar API — calendars, events |
| `gws-calendar-agenda` | List upcoming events |
| `gws-calendar-insert` | Create a new event |
| `gws-meet` | Create and manage Meet spaces |

### Drive & Documents
| Skill | Capability |
|-------|------------|
| `gws-drive` | Core Drive API — files, folders, permissions |
| `gws-drive-upload` | Upload a file to Drive |
| `gws-docs` | Core Docs API — read and edit documents |
| `gws-docs-write` | Write content to a Doc |
| `gws-sheets` | Core Sheets API |
| `gws-sheets-read` | Read data from a spreadsheet |
| `gws-sheets-append` | Append rows to a spreadsheet |
| `gws-slides` | Core Slides API — presentations |
| `gws-forms` | Create and manage Forms |

### Tasks & Productivity
| Skill | Capability |
|-------|------------|
| `gws-tasks` | Manage Google Tasks — lists and items |
| `gws-keep` | Google Keep notes |
| `gws-people` | Contacts and directory |
| `gws-chat` | Google Chat spaces and messages |
| `gws-chat-send` | Send a message to a Chat space |

### Cross-Service Workflows
| Skill | Capability |
|-------|------------|
| `gws-workflow` | Orchestrated multi-service workflows |
| `gws-workflow-standup-report` | Today's meetings + open tasks |
| `gws-workflow-meeting-prep` | Agenda, attendees, and linked docs for next meeting |
| `gws-workflow-email-to-task` | Convert a Gmail thread into a Task |
| `gws-workflow-weekly-digest` | Weekly meetings + unread email summary |
| `gws-workflow-file-announce` | Announce a Drive file in a Chat space |

### Admin
| Skill | Capability |
|-------|------------|
| `gws-admin-reports` | Audit and usage reports |
| `gws-classroom` | Google Classroom courses and rosters |
| `gws-events` | Pub/Sub event subscriptions |

## Recipes

Pre-built multi-step operations. Read the sub-skill before executing.

| Recipe | What it does |
|--------|-------------|
| `recipe-label-and-archive-emails` | Bulk label and archive by filter |
| `recipe-create-gmail-filter` | Create an inbox filter rule |
| `recipe-find-free-time` | Find open slots across calendars |
| `recipe-block-focus-time` | Block focus time on calendar |
| `recipe-reschedule-meeting` | Move a meeting and notify attendees |
| `recipe-create-doc-from-template` | Clone a Doc template |
| `recipe-draft-email-from-doc` | Turn a Doc into a Gmail draft |
| `recipe-save-email-attachments` | Save attachments from a thread to Drive |
| `recipe-save-email-to-doc` | Archive an email as a Google Doc |
| `recipe-generate-report-from-sheet` | Generate a report from sheet data |
| `recipe-organize-drive-folder` | Reorganise files in a Drive folder |
| `recipe-plan-weekly-schedule` | Draft weekly schedule from calendar |
| `recipe-review-overdue-tasks` | List and triage overdue Tasks |
| `recipe-create-shared-drive` | Set up a shared Drive with permissions |
| `recipe-share-doc-and-notify` | Share a Doc and email the recipients |
| `recipe-post-mortem-setup` | Create a post-mortem Doc and calendar invite |
| `recipe-send-team-announcement` | Send a formatted team announcement |

## How to Use a Sub-Skill

When the user's request maps to a skill above, read the SKILL.md before running any command:

```
~/dotfiles/.claude/skills/<skill-name>/SKILL.md
```

Example — triage inbox:
1. Read `~/dotfiles/.claude/skills/gws-shared/SKILL.md`
2. Read `~/dotfiles/.claude/skills/gws-gmail-triage/SKILL.md`
3. Run the appropriate `gws` command
