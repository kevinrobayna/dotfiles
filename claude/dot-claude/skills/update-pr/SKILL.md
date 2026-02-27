---
name: update-pr
description: Update an existing GitHub PR with a better title and description focusing on "why" and trade-offs
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
  - Skill
allowed-prompts:
  - tool: Bash
    prompt: gh pr edit
---

# Pull Request Updater

Update an existing GitHub Pull Request with an improved title following conventional commits and a concise description focusing on "why" and trade-offs.

## Overview

This skill:
1. Identifies the PR to update (from argument or current branch)
2. Views the current PR state
3. Analyzes the changes and commits in the PR
4. Generates an improved title following conventional commits
5. Creates a focused description emphasizing "why" and trade-offs
6. Updates the PR using `gh pr edit`

## Instructions

When this skill is invoked, follow these steps:

### Step 1: Identify the PR

Determine which PR to update:

**Option A: PR number provided by user**
```bash
# User provides PR number as argument
# Example: /update-pr 123
```

**Option B: Auto-detect from current branch**
```bash
# Get PR associated with current branch
gh pr view --json number,url,title -q ".number"
```

If no PR can be found:
- Use AskUserQuestion to ask for the PR number
- Provide option to enter the PR number or cancel

### Step 2: View Current PR State

Get the current PR details:

```bash
# Get current PR details including URL
gh pr view <number> --json number,title,body,headRefName,baseRefName,url
```

**Note:** You can use `gh pr view` directly - no need to use the `/github` skill for this.

Display to user:
- Current title
- Current description (summarize if very long)
- Base and head branches

Then proceed directly to analysis and generate the improved title and description. Only ask for confirmation before actually updating the PR (in Step 7).

### Step 3: Analyze PR Changes

Analyze the changes to understand the context:

```bash
# Get list of changed files (lightweight overview)
gh pr diff <number> --name-only

# Get commits in the PR (may be empty if commits aren't loaded)
gh pr view <number> --json commits -q ".commits[].commit.message"

# If needed, view the full diff (use sparingly for large PRs)
# gh pr diff <number>
```

**Important Notes:**
- `gh pr diff` supports: `--name-only`, `--patch`, `--color`, `--web`
- The `--stat` flag does NOT exist (will cause an error)
- The commits query may return empty output - this is normal, use the file list instead

Determine:
- The primary type of change (feat, fix, refactor, chore, etc.)
- The scope/component affected
- The purpose and motivation
- Any trade-offs or important decisions

### Step 4: Generate New PR Title

Create a PR title following conventional commits format:

**Format:** `<type>(<scope>): <description>`

- **Type**: feat, fix, refactor, chore, docs, test, perf, ci, etc.
- **Scope** (optional): Component or area (e.g., `ci`, `auth`, `email-service`, `api`)
- **Description**: Concise summary (imperative mood, no period, under 72 chars)

**Examples:**
- `feat(auth): implement OAuth2 token refresh logic`
- `fix(email-service): handle null recipient addresses`
- `chore(ci): add GitHub Actions performance test workflow`
- `refactor: align task-management-service with email-service patterns`

**Guidelines:**
- Use imperative mood: "add" not "added" or "adds"
- Keep under 72 characters
- No period at the end
- Be specific but concise

### Step 5: Generate New PR Description

Create a PR description that focuses on the "why", trade-offs, and context:

**Structure:**
```
<Explain WHY this change is needed and the context>

<Optional: Trade-offs or important decisions section>

---
🤖 Updated with [Claude Code](https://claude.com/claude-code)
```

**Guidelines:**
- Focus intensely on **why**, not what (code shows the what)
- Explain the problem being solved, the motivation, or the improvement being made
- Always mention trade-offs, alternatives considered, or important decisions when they exist
- Provide enough context for reviewers to understand the reasoning
- Keep it concise but complete - don't sacrifice clarity for brevity
- Use clear, straightforward language
- Include Claude Code attribution at the end

**Examples:**

```
Adds automated performance testing for the email-service to catch regressions early in the development cycle. Uses GitHub Actions to run tests on every PR.

Trade-off: Tests add ~5 minutes to CI runtime but provide valuable performance insights.

---
🤖 Updated with [Claude Code](https://claude.com/claude-code)
```

```
Improves service consistency by aligning the task-management-service architecture with the patterns used in email-service. Makes the codebase easier to maintain and onboard new developers.

---
🤖 Updated with [Claude Code](https://claude.com/claude-code)
```

```
Fixes a NullPointerException that occurs when JWT tokens are missing the company_id claim. Adds defensive null checks and proper error handling.

---
🤖 Updated with [Claude Code](https://claude.com/claude-code)
```

### Step 6: Preview Changes

Before updating, show the user:

**Current:**
```
Title: <old title>
Description: <old description>
```

**Proposed:**
```
Title: <new title>
Description: <new description>
```

Ask for confirmation: "Would you like to update the PR with these changes?"

### Step 7: Update the PR

Use `gh pr edit` to update the PR:

```bash
gh pr edit <number> \
  --title "<new title>" \
  --body "$(cat <<'EOF'
<new description>

---
🤖 Updated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

### Step 8: Confirm Update

After updating, verify and display:

```bash
# View updated PR
gh pr view <number> --json url,title,body
```

Display to user:
```
✓ Pull Request updated successfully!

PR #<number>: <new title>
URL: <pr-url>

The title and description have been updated.
```

## Important Guidelines

### GitHub CLI Usage

- Use `gh pr view` directly for viewing PR information
- Use `gh pr diff --name-only` to get list of changed files (NOT `--stat`)
- Use `gh pr edit` to update the PR title and body
- The `/github` skill is NOT required for this workflow

### Title Quality

- Always follow conventional commits format strictly
- Type and description are required
- Scope is optional but helpful when clear
- Use imperative mood consistently
- Keep under 72 characters

### Description Quality

- Focus intensely on **WHY** the change is needed
- Explain the problem, context, or motivation
- Always mention trade-offs, alternatives, or important decisions when they exist
- Avoid describing WHAT changed (that's in the diff)
- Provide enough detail for reviewers to understand the reasoning
- Keep it concise but complete - clarity over brevity

### Safety

- Always preview changes before updating
- Ask for user confirmation
- Don't modify PR state (draft/ready) - only title and description
- Don't add/remove reviewers or labels

### Error Handling

- If `gh` CLI is not authenticated: guide user to `gh auth login`
- If PR not found: verify number and repository
- If update fails: show error and suggest manual edit via web

## Examples

### Example 1: Improve Vague PR

```
User: /update-pr 42

Current PR:
Title: Update code
Description: Made some changes to the authentication

Actions:
1. View PR #42 using gh pr view
2. Get list of changed files using gh pr diff --name-only
3. Analyze changes: OAuth2 implementation
4. Generate new title: feat(auth): add OAuth2 authentication flow
5. Generate description:
   Implements OAuth2 authentication to replace the legacy auth system.
   Improves security and enables SSO integration.

   ---
   🤖 Updated with [Claude Code](https://claude.com/claude-code)
6. Preview and ask for confirmation
7. Update using gh pr edit
8. Confirm success
```

### Example 2: Add Missing Context

```
User: /update-pr

Current branch: krobayna/add-ci-tests
Current PR #123:
Title: Add tests
Description: (empty)

Actions:
1. Auto-detect PR from current branch
2. Analyze changes: GitHub Actions workflow for performance tests
3. Generate title: chore(ci): add GitHub Actions performance test workflow
4. Generate description:
   Enables automated performance testing on PRs to catch regressions early.
   Trade-off: Adds ~5 minutes to CI but provides valuable performance insights.

   ---
   🤖 Updated with [Claude Code](https://claude.com/claude-code)
5. Update PR
```

### Example 3: Improve Title Format

```
User: /update-pr 85

Current PR:
Title: Fixed the bug with emails
Description: The email service was throwing NPE

Actions:
1. View PR details
2. Analyze: Null pointer fix in email recipient validation
3. Generate title: fix(email-service): handle null recipient addresses
4. Generate description:
   Prevents NullPointerException when email recipients are null or empty.
   Adds validation and proper error messages.

   ---
   🤖 Updated with [Claude Code](https://claude.com/claude-code)
5. Update PR
```

## Usage

Invoke this skill with:
```
/update-pr                # Auto-detect PR from current branch
/update-pr 123           # Update specific PR by number
```

## Related Skills

- **/create-pr**: Create new PRs with proper formatting
- **/commit**: Create well-formatted commits
- **/pr-feedback**: Address PR review comments
- **/github**: General GitHub operations
