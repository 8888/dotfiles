---
name: agent-worktree
description: Create and clean up isolated git worktrees for parallel agent tasks, compatible with spec-kit.
---

# Agent Worktree Skill

Manage isolated git worktrees so multiple agents can work in the same repository without colliding. Uses detached HEAD so external tools like spec-kit can manage their own branches.

## 1. Start a Worktree

From the target repository, create an isolated worktree:

```bash
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
TASK_ID=$(date +%s)  # or use a descriptive slug
DEST="$HOME/.agent-worktrees/${REPO_NAME}-${TASK_ID}"

git worktree add --detach "$DEST"
```

### Symlink shared resources

Avoid duplicating heavy directories and keep env config in sync:

```bash
# node_modules — prevent multi-GB duplication
[ -d "$REPO_ROOT/node_modules" ] && ln -sf "$REPO_ROOT/node_modules" "$DEST/node_modules"

# Environment and config files
for f in .env .env.local .env.development .npmrc .yarnrc; do
  [ -e "$REPO_ROOT/$f" ] && ln -sf "$REPO_ROOT/$f" "$DEST/$f"
done
```

### Switch to the worktree

```bash
cd "$DEST"
```

All subsequent work happens here. The worktree starts at the same commit as HEAD — spec-kit or any other tool can create branches from this point.

## 2. Do Work

Run your task in the worktree directory. Spec-kit, manual branching, or any other workflow will operate in isolation from the main checkout and other worktrees.

## 3. Cleanup

After work is complete (PR merged, changes landed, or task abandoned):

```bash
DEST="$HOME/.agent-worktrees/${REPO_NAME}-${TASK_ID}"

# Remove the worktree
git worktree remove "$DEST" 2>/dev/null || rm -rf "$DEST"

# Prune stale worktree references
git worktree prune
```

If spec-kit created a branch that is no longer needed:

```bash
git branch -d <branch-name>
```

## 4. List Active Worktrees

```bash
git worktree list
```

## Rules

- **Never branch during start.** Use `--detach` so downstream tools control branching.
- **Always clean up.** Don't leave stale worktrees — they hold refs and consume disk.
- **Symlink, don't copy** `node_modules` and env files to keep a single source of truth.
- **Work only inside the worktree directory.** Don't mix operations between the main checkout and the worktree.
