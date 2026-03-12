---
name: review-prs
description: Discover all PRs assigned to you for review, create worktrees for each, and run parallel code reviews. Use when asked to review pending PRs, check review queue, or batch-review assigned pull requests.
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Agent
  - Skill
  - AskUserQuestion
---

# Review PRs

Autonomously discover all PRs requesting your review, create isolated worktrees, run parallel code reviews, and present a consolidated summary.

## When This Skill Activates

- User asks to review their pending PRs
- User asks to check their review queue
- User asks to batch-review assigned pull requests

## Process

### Step 1: PR Discovery

Must be inside a git repo. Fetch the current repo and user, then query GitHub for open PRs requesting review.

```bash
# Get repo and user
repo=$(gh repo view --json nameWithOwner -q '.nameWithOwner')
current_user=$(gh api user -q '.login')

# IMPORTANT: Use a heredoc with single-quoted 'EOF' delimiter to prevent
# shell expansion of $sq inside the GraphQL query.
read -r -d '' gql_query << 'EOF' || true
query($sq: String!) {
  search(query: $sq, type: ISSUE, first: 100) {
    nodes {
      ... on PullRequest {
        number
        title
        author { login }
        headRefName
        baseRefName
        url
        reviewRequests(first: 100) {
          nodes {
            requestedReviewer {
              ... on User { login }
              ... on Team { name }
            }
          }
        }
      }
    }
  }
}
EOF

# Only PRs created in the last 7 days, directly requesting the user (not via team)
week_ago=$(date -v-7d +%Y-%m-%d 2>/dev/null || date -d '7 days ago' +%Y-%m-%d)
search_query="repo:${repo} is:pr is:open review-requested:${current_user} created:>=${week_ago} -author:app/dependabot -author:app/renovate"
raw=$(gh api graphql -F sq="$search_query" -f query="$gql_query")
```

Filter out bot authors and keep only PRs where the user is directly requested (not via team):

```bash
echo "$raw" | jq --arg user "$current_user" '[.data.search.nodes[]
  | select(.author.login | test("(dependabot|renovate|greenkeeper)"; "i") | not)
  | select([.reviewRequests.nodes[].requestedReviewer | select(.login == $user)] | length > 0)
  | {number, title, author: .author.login, headRefName, baseRefName, url}]'
```

This excludes PRs where review was requested only via a team. Deduplicate by PR number. If zero PRs found, report "No PRs requesting your review" and stop.

For each PR, record: `number`, `title`, `author.login`, `headRefName`, `baseRefName`, `url`.

### Step 2: Create Worktrees (sequential)

Fetch latest remote refs first:

```bash
git fetch origin
```

For each PR, create a worktree using the `gwt` convention:

```bash
git_root=$(git rev-parse --show-toplevel)
repo_name=$(basename "$git_root")
branch_name="<headRefName>"
worktree_path="$(dirname "$git_root")/${repo_name}_wt_${branch_name}"
```

Create the worktree:

```bash
# Try with tracking branch first, fall back to direct checkout
git worktree add --track -b "$branch_name" "$worktree_path" "origin/$branch_name" 2>/dev/null \
  || git worktree add "$worktree_path" "origin/$branch_name" 2>/dev/null
```

**Edge cases:**
- If worktree already exists at path, reuse it — do not fail
- If `origin/<branch>` doesn't exist (fork PRs), use `gh pr checkout <number>` as fallback inside the worktree
- Track all worktree paths for cleanup in Step 5

### Step 3: Parallel Reviews

Launch one Agent per PR in the background (`run_in_background: true`). All agents launch in a single turn for maximum parallelism.

Each agent receives:
- The worktree path to `cd` into
- The PR number, title, author, and URL
- The base branch name

Each agent should:
1. `cd` into the worktree path
2. Run `gh pr diff <number>` to understand changed files
3. Read key changed files for context
4. Invoke the `pr-review-toolkit:review-pr` skill via the Skill tool to perform the review
5. Return the structured review findings (critical/important/suggestion counts and details)

### Step 4: Post Review Comments & Present

After all agents complete, for each PR post the review as a GitHub PR review comment:

```bash
# Use gh pr review to post findings
# Choose the event based on severity:
#   --request-changes  if any critical issues found
#   --comment          if only important/suggestions or no issues
gh pr review <number> --repo <repo> --body "<review body>" --event <COMMENT|REQUEST_CHANGES>
```

The review body should be formatted as markdown:

```markdown
## Code Review

### Critical Issues
- <file:line> — description

### Important
- <file:line> — description

### Suggestions
- <file:line> — description

---
🤖 Reviewed with [Claude Code](https://claude.com/claude-code)
```

If there are no findings at all, post a simple approval:

```bash
gh pr review <number> --repo <repo> --approve --body "Looks good! No issues found. 🤖"
```

Then present a consolidated summary to the user:

```
## PR Review Summary

| PR | Title | Author | Critical | Important | Suggestions | Recommendation |
|----|-------|--------|----------|-----------|-------------|----------------|
| #42 | Fix auth bug | alice | 0 | 2 | 3 | Approve with comments |
| #87 | Add caching | bob | 1 | 1 | 0 | Request changes |

### Details

#### PR #42: Fix auth bug (by alice)
<agent review summary>

#### PR #87: Add caching (by bob)
<agent review summary>
```

### Step 5: Cleanup

Remove all worktrees created in Step 2:

```bash
git worktree remove --force "<worktree_path>"
```

After removing all worktrees:

```bash
git worktree prune
```

Do NOT remove worktrees that existed before the skill ran.

## Rules

- **Posts reviews**: After reviewing, post findings as a GitHub PR review comment using `gh pr review`.
- **Cleanup always**: Even if reviews fail, always attempt to clean up worktrees.
- **No bots**: Always filter out dependabot, renovate, and greenkeeper PRs.
- **Direct requests only**: Only review PRs where the user is directly requested as reviewer, not via team membership.
- **Recent PRs only**: Only review PRs created within the last 7 days.
- **Parallel**: Launch all review agents in a single turn for maximum speed.
- **Reuse worktrees**: If a worktree already exists, reuse it instead of failing.

## Output Format

Present the summary table first, then detailed findings per PR. End with confirmation that all worktrees have been cleaned up.
