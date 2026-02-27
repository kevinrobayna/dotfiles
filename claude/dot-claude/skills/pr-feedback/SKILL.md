---
name: pr-feedback
description: Resolve unresolved issues from a GitHub PR review
allowed-tools:
  - Bash
  - Read
  - Edit
  - AskUserQuestion
  - Skill
---

# PR Feedback Handler

Handle feedback from GitHub Pull Request reviews by analyzing unresolved comments, organizing them into actionable items, and implementing fixes with individual commits.

## Overview

This skill helps process PR review feedback efficiently by:
1. Fetching and analyzing unresolved PR comments only
2. Summarizing issues that need changes
3. Allowing selective issue resolution
4. Creating focused commits for each resolved issue

**Important:** This skill only works on unresolved review threads. Resolved comments are automatically filtered out.

## Instructions

When this skill is invoked, follow these steps:

### Step 1: Get PR Information

If no PR number is provided in the skill arguments:
- Ask the user which PR to work on
- Accept either a PR number or a full GitHub PR URL

Once you have the PR identifier:
- Parse the PR number from the input
- Use `gh pr view <number>` to get basic PR information
- Confirm with the user that this is the correct PR

### Step 2: Fetch and Analyze Unresolved Comments

Use the GitHub CLI with GraphQL to fetch ONLY unresolved PR review threads:

```bash
# Resolve the owner and repo from the current git remote
gh repo view --json owner,name -q '"owner=" + .owner.login + " repo=" + .name'
```

Then use those values in the GraphQL query:

```bash
# Get unresolved review threads using GraphQL
gh api graphql -f query='
{
  repository(owner: "{owner}", name: "{repo}") {
    pullRequest(number: {pr_number}) {
      reviewThreads(first: 100) {
        nodes {
          id
          isResolved
          isOutdated
          comments(first: 10) {
            nodes {
              id
              body
              path
              line
              author {
                login
              }
            }
          }
        }
      }
    }
  }
}'
```

Then filter the results to extract only unresolved threads:

```bash
# Extract unresolved threads and their comments
gh api graphql -f query='...' | jq '.data.repository.pullRequest.reviewThreads.nodes[] | select(.isResolved == false)'
```

**Important:** Filter to only include review threads where:
- `.isResolved == false` - The thread has NOT been marked as resolved
- The comment is actionable (not just "looks good" or approval)
- Focus on the first comment in each thread (the one that started the conversation)

Analyze the unresolved comments to identify:
- Actionable feedback requiring code changes
- Questions or discussions (not requiring immediate changes)
- The file and location each comment refers to
- Group related comments by theme or file

### Step 3: Present Summary

Create a clear summary of all unresolved, actionable issues:

```
Found X unresolved issues requiring changes:

1. [Author] File: path/to/file.ext (Line Y)
   Issue: Brief description of the problem
   Comment: "Original comment text"

2. [Author] File: another/file.ext
   Issue: Brief description
   Comment: "Original comment text"

...
```

Group related issues together if they share a common theme (e.g., "naming conventions", "error handling", "test coverage").

If no unresolved comments are found, inform the user:
```
✓ All review comments have been resolved! No outstanding issues found.
```

### Step 4: Get User Input

Use the AskUserQuestion tool to ask the user which issues to resolve:

Present each issue (or group of issues) and ask:
- "Resolve with Claude" - You will implement the fix
- "Skip (manual)" - User will handle it manually

For efficiency, if there are many issues, group them by theme and ask about groups rather than individual items.

### Step 5: Implement Fixes

For each issue or group of issues the user wants resolved:

1. **Read the relevant files** using the Read tool
2. **Understand the context** around the commented code
3. **Implement the fix** following the feedback
4. **Stage the changes**:
   ```bash
   git add <changed-files>
   ```
5. **Create a focused commit** using the `/commit` skill:
   - Use the Skill tool to invoke the commit skill
   - The commit skill will analyze the changes and create an appropriate commit message
   - The commit type will typically be `fix` for addressing PR feedback
   - Examples of generated commits:
     - `fix(pr-feedback): refactor variable naming per review`
     - `fix(pr-feedback): add error handling as requested`
     - `fix(pr-feedback): improve test coverage for edge cases`

### Step 6: Summary

After resolving all selected issues:
- List all commits created
- Mention any skipped issues that require manual attention
- Suggest pushing the changes: `git push`
- Do NOT automatically push unless explicitly requested

## Important Guidelines

### Working with GitHub CLI
- Always use `gh` commands for PR interactions
- Authenticate if needed: `gh auth status`
- **Use GraphQL API** for fetching review threads with resolved status: `gh api graphql`
- **Only fetch unresolved threads** - Filter by `.isResolved == false` in GraphQL response
- The REST API (`gh api repos/.../pulls/.../comments`) does NOT include resolved status
- Skip threads that are already marked as resolved by reviewers

### Code Changes
- Read files before modifying them
- Make focused changes that directly address the feedback
- Don't over-engineer or add unrequested improvements
- Maintain existing code style and conventions
- Run tests if relevant: `./gradlew test` or similar

### Commit Strategy
- One commit per theme/issue (or small group of related issues)
- Use the `/commit` skill to create commits (invoked via Skill tool)
- The commit skill will handle message formatting and Co-Authored-By line
- Stage changes before invoking the commit skill

### Error Handling
- If a comment is unclear, note it and ask the user for clarification
- If you can't locate the code mentioned, ask the user for help
- If a fix would require significant refactoring, discuss with the user first

### Multi-tenancy and Security
- Be careful with changes affecting security (auth, validation, etc.)
- Preserve multi-tenancy patterns when present
- Don't introduce security vulnerabilities

## Examples

### Example 1: Simple Naming Change
```
Comment: "Please rename `getData` to `fetchUserPreferences` for clarity"
Action: Rename function, update all call sites, commit with message:
"fix(pr-feedback): rename getData to fetchUserPreferences"
```

### Example 2: Add Error Handling
```
Comment: "This should handle the case when the user is not found"
Action: Add null check and error handling, commit with message:
"fix(pr-feedback): add error handling for missing user"
```

### Example 3: Multiple Related Issues
```
Comments about test coverage in 3 different files
Action: Add tests for all 3 files, commit with message:
"fix(pr-feedback): add test coverage for edge cases"
```

### Example 4: No Unresolved Issues
```
User: /pr-feedback 123
Status: PR has 5 comments, all marked as resolved

Output:
✓ All review comments have been resolved! No outstanding issues found.
```

## Usage

Invoke this skill with:
```
/pr-feedback
/pr-feedback 123
/pr-feedback https://github.com/owner/repo/pull/123
```

**Note:** Only unresolved review threads will be processed. If all comments are resolved, the skill will inform you and exit gracefully.
