---
name: create-pr
description: Create draft PRs with review request. Activates when creating pull requests, pushing branches for review, or submitting code changes.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
  - Skill
---

# PR Creation

Create pull requests as drafts 

## When This Skill Activates

- User asks to create a PR
- User asks to submit changes for review
- User asks to push and open a PR

## Process

### Step 1: Prepare the Commit

Apply the `commit` skill for all commits. Ensure all changes are committed before creating the PR.

### Step 2: Push the Branch

```bash
git push -u origin <branch-name>
```

If there is no branch yet, create one with the pattern `krobayna_...`.
Ask for a ticket if unsure. If the user does not provide a ticket, skip adding the ticket reference completely.

### Step 3: Draft the PR Title and Description

**Title rules:**
- Under 72 characters
- Imperative mood ("Add feature" not "Added feature")
- Create a PR title following conventional commits format: `<type>(<scope>): <description>`

**Description template:**

```markdown
## Summary

<1-3 sentences explaining WHY this change is needed and the context>

<Optional: Trade-offs or important decisions>

## Test plan

- [ ] <How to verify the changes work>

---
🤖 Generated with [Claude Code](https://claude.com/claude-code)
```


### Step 4: Create the PR as Draft

Always use the `--draft` flag. No exceptions.

```bash
gh pr create --draft --title "<title>" --body "<description>"
```

### Step 5: Report Back

Return the PR URL and branch of the PR and target branch back to the user so they can see it.

## Rules

- **Always draft**: Never create a non-draft PR.
- **Commit standards**: Defer to the `commit` skill for all commit messages.

## Output Format

```
PR created: <URL>
            <PR_BRANCH> --> <TARGET_BRANCH>
```
