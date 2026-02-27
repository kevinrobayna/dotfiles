---
name: github
description: Interact with GitHub ( https://github.com/ ) using the gh CLI tool for repository operations, PRs, issues, and more
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
allowed-prompts:
  - tool: Bash
    prompt: gh auth status
  - tool: Bash
    prompt: gh repo view
  - tool: Bash
    prompt: gh repo list
  - tool: Bash
    prompt: gh pr list
  - tool: Bash
    prompt: gh pr view
  - tool: Bash
    prompt: gh pr diff
  - tool: Bash
    prompt: gh pr checks
  - tool: Bash
    prompt: gh issue list
  - tool: Bash
    prompt: gh issue view
  - tool: Bash
    prompt: gh run list
  - tool: Bash
    prompt: gh run view
  - tool: Bash
    prompt: gh run watch
  - tool: Bash
    prompt: gh api (for read-only GET requests)
---

# GitHub CLI Interaction

Interact with GitHub repositories, pull requests, issues, and workflows using the `gh` CLI tool.

## Overview

This skill enables safe interaction with GitHub through the official CLI tool. Read-only commands are allowed by default, while write operations require user confirmation.

**Core capabilities:**
- View repository information
- Browse and review pull requests
- Check issues and their status
- Monitor GitHub Actions workflows
- Review code and comments
- Fetch repository metadata

## Instructions

### General Principles

1. **Always use `gh` CLI** for GitHub operations (not `git` for GitHub-specific features)
2. **Read-only by default** - viewing, listing, and reading operations are safe
3. **Confirm write operations** - creating, updating, or deleting requires explicit confirmation
4. **Context awareness** - detect repository context automatically or ask user

### Available Commands

#### Repository Information

```bash
# View repository details
gh repo view [owner/repo]

# List repositories
gh repo list [owner]

# Clone repository
gh repo clone owner/repo
```

#### Pull Requests (Read-Only)

```bash
# List pull requests
gh pr list

# View PR details
gh pr view <number>

# View PR diff
gh pr diff <number>

# Check PR status (CI checks)
gh pr checks <number>

# List PR reviews
gh pr view <number> --comments
```

#### Issues (Read-Only)

```bash
# List issues
gh issue list

# View issue details
gh issue view <number>

# List issue comments
gh issue view <number> --comments
```

#### GitHub Actions (Read-Only)

```bash
# List workflow runs
gh run list

# View run details
gh run view <run-id>

# View run logs
gh run view <run-id> --log

# Watch a workflow run
gh run watch <run-id>
```

#### Code Review

```bash
# View PR comments
gh pr view <number> --comments

# View specific files in PR
gh pr diff <number> -- path/to/file
```

### Common Workflows

#### Reviewing a Pull Request

When asked to review a PR:

1. Get PR details:
   ```bash
   gh pr view <number>
   ```

2. Check the diff:
   ```bash
   gh pr diff <number>
   ```

3. Check CI status:
   ```bash
   gh pr checks <number>
   ```

4. Read comments and reviews:
   ```bash
   gh pr view <number> --comments
   ```

#### Investigating an Issue

When asked about an issue:

1. View issue details:
   ```bash
   gh issue view <number>
   ```

2. Check related PRs:
   ```bash
   gh pr list --search "issue-keyword"
   ```

3. View issue timeline and comments

#### Monitoring CI/CD

When asked about workflow status:

1. List recent runs:
   ```bash
   gh run list --limit 10
   ```

2. View specific run:
   ```bash
   gh run view <run-id>
   ```

3. Check logs if needed:
   ```bash
   gh run view <run-id> --log
   ```

### Write Operations (Require Confirmation)

The following operations modify GitHub state and should be confirmed:

#### Creating Resources
- `gh pr create` - Create pull request
- `gh issue create` - Create issue
- `gh repo create` - Create repository

#### Modifying Resources
- `gh pr merge` - Merge pull request
- `gh pr close` - Close pull request
- `gh pr ready` - Mark PR as ready
- `gh issue close` - Close issue
- `gh issue edit` - Edit issue

#### Commenting
- `gh pr comment` - Comment on PR
- `gh issue comment` - Comment on issue
- `gh pr review` - Submit PR review

#### Workflow Control
- `gh run cancel` - Cancel workflow run
- `gh run rerun` - Re-run workflow

**Before executing write operations:**
1. Explain what the command will do
2. Ask for explicit confirmation
3. Show the exact command that will run
4. Execute only after user approval

### Context Detection

Automatically detect repository context:

```bash
# Check if we're in a git repository
git rev-parse --is-inside-work-tree 2>/dev/null

# Get current repository
gh repo view --json nameWithOwner -q .nameWithOwner
```

If context is unclear, ask the user:
- Which repository to operate on?
- Which PR/issue number?
- Which branch or workflow?

### Output Formatting

Use appropriate output formats:

```bash
# JSON output for parsing
gh pr view <number> --json number,title,state,author

# Human-readable for display
gh pr view <number>

# Web view for complex cases
gh pr view <number> --web
```

### Error Handling

Common errors and solutions:

1. **Not authenticated:**
   ```
   Error: authentication required
   Solution: Run `gh auth login`
   ```

2. **Not in a repository:**
   ```
   Error: not a git repository
   Solution: Specify owner/repo or navigate to repository
   ```

3. **PR/Issue not found:**
   ```
   Error: could not resolve to a PullRequest
   Solution: Verify the number and repository
   ```

4. **Permission denied:**
   ```
   Error: Resource not accessible
   Solution: Check repository access and authentication
   ```

### Best Practices

1. **Check authentication status** before operations:
   ```bash
   gh auth status
   ```

2. **Use JSON output** for programmatic parsing:
   ```bash
   gh pr list --json number,title,state
   ```

3. **Limit results** to avoid overwhelming output:
   ```bash
   gh pr list --limit 10
   ```

4. **Filter effectively** using flags:
   ```bash
   gh pr list --state open --author @me
   gh issue list --label bug --state open
   ```

5. **Verify before acting** - always view before modifying

### Examples

#### Example 1: Review a Pull Request

```
User: Can you review PR #42?

Steps:
1. gh pr view 42
2. gh pr diff 42
3. gh pr checks 42
4. Analyze the changes and provide feedback
```

#### Example 2: Check CI Status

```
User: Why did the last workflow fail?

Steps:
1. gh run list --limit 5
2. gh run view <latest-run-id>
3. gh run view <latest-run-id> --log
4. Identify and explain the failure
```

#### Example 3: Find Open Issues

```
User: What issues are labeled as "bug"?

Steps:
1. gh issue list --label bug --state open
2. Present the list with numbers and titles
```

#### Example 4: Create PR (Write Operation)

```
User: Create a PR for my changes

Steps:
1. Explain: "I'll create a PR with the current branch changes"
2. Show: "Command: gh pr create --title '...' --body '...'"
3. Ask: "Shall I create this PR?"
4. On confirmation: Execute gh pr create
```

## Usage

Invoke this skill with:
```
/github
/github view pr 42       # View specific PR
/github check ci         # Check CI status
```

Or simply reference GitHub operations in your message:
```
"Can you check the status of PR #42?"
"Show me open issues labeled 'bug'"
"Review the latest workflow run"
```

## Safety Guidelines

1. **Read operations are safe** - listing, viewing, checking
2. **Write operations need confirmation** - creating, modifying, deleting
3. **Never expose secrets** - avoid displaying tokens or sensitive data
4. **Respect rate limits** - avoid excessive API calls
5. **Verify context** - ensure you're working on the correct repository

## Integration with Other Skills

This skill works well with:
- **/commit** - Create commits before pushing
- **/create-pr** - Create PRs with proper formatting
- **/pr-feedback** - Address PR review comments

Use `gh` for GitHub-specific operations and `git` for local repository operations.
