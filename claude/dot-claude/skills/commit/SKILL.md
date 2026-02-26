---
name: commit
description: Create a git commit with a well-structured message following conventional commits
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
model: haiku
---

# Git Commit Creator

Create well-structured git commits by analyzing the current changeset and generating a commit message following conventional commits format.

## Overview

This skill:

1. Analyzes the current git changeset (staged and unstaged changes)
2. Generates a commit message following conventional commits
3. Focuses on WHY the changes were made (not what - that's in the diff) and trade-offs
4. Creates the commit with proper formatting

## Instructions

When this skill is invoked, follow these steps:

### Step 1: Analyze the Changeset

Use git commands to understand what has changed:

```bash
# Check current status
git status

# Show staged changes (if any)
git diff --cached --stat
git diff --cached

# Show unstaged changes (if none staged)
git diff --stat
git diff
```

Analyze:

- Which files were modified, added, or deleted
- What kind of changes were made (feature, fix, refactor, docs, etc.)
- The scope of the changes (which component/module)
- The context and purpose of the changes

### Step 2: Determine Commit Type

Based on the changes, determine the conventional commit type:

- **feat**: New feature or functionality
- **fix**: Bug fix
- **refactor**: Code refactoring without changing behavior
- **docs**: Documentation changes
- **test**: Adding or updating tests
- **chore**: Build, dependencies, tooling, or other maintenance
- **perf**: Performance improvements
- **style**: Code style/formatting changes
- **ci**: CI/CD pipeline changes
- **revert**: Reverting a previous commit

If multiple types apply, use the most significant one.

### Step 3: Determine Scope (Optional)

Identify the scope - the component, module, or area affected:

- Examples: `api`, `auth`, `email-service`, `task-service`, `database`, `grpc`
- Keep it concise and lowercase
- Omit if changes span multiple areas or scope isn't clear

### Step 5: Generate Commit Message

Create a commit message with this structure:

```
<type>(<scope>): <short summary>

<body explaining WHY, not WHAT>

```

Use my gitmessage template found in ~/.config/git/gitmessage

**Title (first line):**

- Format: `type(scope): description` or `type: description`
- Keep under 72 characters
- Use imperative mood: "add feature" not "added feature"
- Don't end with a period
- Be specific but concise

**Body (optional, skip if changes are self-explanatory):**

- Explain WHY the change was needed
- Explain the context or problem being solved
- Keep it concise - 1-3 sentences
- Leave a blank line after the title

**Examples:**

```
feat(email-service): add retry logic for failed email sends

Improves reliability by automatically retrying transient failures
with exponential backoff instead of immediately failing.
```

```
fix(auth): handle missing company_id in JWT token

Prevents NullPointerException when tokens are missing required claims.
```

```
refactor: align task-management-service with email-service patterns

Improves consistency across services and makes the codebase easier to maintain.
```

```
chore(deps): upgrade Spring Boot to 3.2.1
```

### Step 6: Stage Changes (if needed)

If there are unstaged changes:

- Ask the user if they want to stage all changes or select specific files
- Use `git add .` for all changes or `git add <files>` for specific files

If changes are already staged, proceed to commit.

### Step 7: Create the Commit

Use git commit with a heredoc to preserve formatting:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <short summary>

<body>

Co-Authored-By: Claude Code <noreply@anthropic.com>
EOF
)"
```

Always include the `Co-Authored-By` line.

### Step 8: Confirm

After creating the commit:

- Show the commit message
- Show the commit hash
- Suggest next steps (e.g., continue working, push changes)

## Important Guidelines

### Commit Message Quality

- Focus on WHY, not WHAT (the diff shows what changed)
- Be concise but informative
- Use present tense, imperative mood: "add" not "added" or "adds"
- Omit obvious details that are clear from the diff

### Conventional Commits

- Always follow the conventional commits format strictly
- Type and description are required
- Scope is optional but helpful
- Keep the title under 72 characters

### Staging Strategy

- Ask before staging if there are many files
- Allow selective staging for focused commits
- Don't commit everything if changes are unrelated

### Safety

- Never commit secrets, credentials, or sensitive data
- If you detect potential secrets in the diff, warn the user
- Review the changeset before committing

### Edge Cases

- If no changes are staged/unstaged, inform the user
- If changes are too large or complex, break them down
- If commit type is unclear, ask the user for clarification

## Examples

### Example 1: Feature Addition

```
User: /commit
Changes: Added new email notification preference endpoint

Generated message:
feat(email-service): add endpoint for notification preferences

Allows users to manage their email notification settings through
a new REST API endpoint with validation and persistence.
```

### Example 2: Bug Fix

```
User: /commit
Changes: Fixed null pointer exception in task assignment

Generated message:
fix(task-service): handle null assignee in task creation

Prevents NPE when tasks are created without an explicit assignee
by defaulting to the task creator.
```

### Example 3: Refactoring

```
User: /commit
Changes: Extracted common validation logic into utility class

Generated message:
refactor: extract validation logic to shared utility

Reduces code duplication and improves maintainability by
centralizing validation rules.
```

### Example 4: Chore (No Body Needed)

```
User: /commit
Changes: Updated dependencies in gradle files

Generated message:
chore(deps): upgrade gradle dependencies
```

## Usage

Invoke this skill with:

```
/commit
```
