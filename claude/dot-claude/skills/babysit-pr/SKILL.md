---
name: babysit-pr
description: Monitor CI status on a PR, polling until checks complete. Reports success or invokes ci-errors to diagnose and fix failures. Use when asked to watch CI, babysit a PR, or monitor checks.
allowed-tools:
  - Bash(gh pr checks:*)
  - Bash(gh pr view:*)
  - Bash(gh run list:*)
  - Bash(gh run view:*)
  - Bash(git push:*)
  - Read
  - Edit
  - Write
  - Grep
  - Glob
  - Skill
  - ScheduleWakeup
---

# Babysit PR

Monitor CI checks on a pull request. Poll until all checks complete, then report success or diagnose and fix failures.

## When This Skill Activates

- User asks to watch, babysit, or monitor a PR
- User asks to check CI status and wait for it
- Invoked automatically after `/create-pr`

## Inputs

- **PR Number**: passed as argument, or auto-detected from current branch
- **Poll count**: tracks how many times we've polled (default: 1)

## Process

### Step 1: Determine the PR

If a PR number was provided as argument, use it. Otherwise auto-detect:

```bash
gh pr view --json number -q .number
```

If no PR is found, report the error and exit.

Note: If the remote is `@github.com-work`, use `@github.com` instead.

### Step 2: Poll CI Status

```bash
gh pr checks <PR_NUMBER>
```

Categorize each check:

| Status | Category |
|--------|----------|
| `SUCCESS`, `NEUTRAL`, `SKIPPED` | Passed |
| `FAILURE`, `ACTION_REQUIRED`, `TIMED_OUT`, `CANCELLED`, `STARTUP_FAILURE` | Failed |
| `QUEUED`, `IN_PROGRESS`, `WAITING`, `PENDING`, `REQUESTED` | Pending |

### Step 3: Decide

**All checks passed (0 pending, 0 failed):**
- Report a success summary table (check name + status)
- Do NOT call ScheduleWakeup — the loop ends here

**Some checks still pending:**
- Report current status (X passed, Y pending, Z failed so far)
- Call ScheduleWakeup with `delaySeconds: 270` to re-poll (stays within prompt cache TTL)
- Pass the prompt: `/babysit-pr <PR_NUMBER> --poll <N+1>`
- Set reason to something specific, e.g. `"CI poll #3 for PR #142 — 4 of 7 checks pending"`

**Checks failed (none pending):**
- Invoke the `ci-errors` skill to diagnose the failures
- Apply the proposed fixes
- Invoke the `commit` skill to commit the fixes
- Push with `git push`
- Call ScheduleWakeup with `delaySeconds: 270` to re-monitor the new CI run
- Pass the prompt: `/babysit-pr <PR_NUMBER> --poll 1` (reset poll count for new run)
- Set reason to `"Re-monitoring CI after pushing fixes for PR #<NUMBER>"`

**No checks found (first poll):**
- Call ScheduleWakeup with `delaySeconds: 120` (checks may not be registered yet)
- Pass the prompt: `/babysit-pr <PR_NUMBER> --poll <N+1>`

**No checks found (poll 2+):**
- Report "No CI checks configured for this repository"
- Do NOT call ScheduleWakeup — the loop ends here

### Step 4: Timeout

Cap at **12 polls** (~54 minutes). If checks are still pending after 12 polls:
- Report the current state of all checks
- Do NOT call ScheduleWakeup — the loop ends here

## Rules

- Always wait for ALL checks to complete before invoking `ci-errors` — do not analyze partial results
- If a check was failing but is now pending (re-run), continue polling
- If `gh` commands fail (network error), retry on the next poll — do not treat CLI errors as CI failures
- Use the `commit` skill for all fix commits
- After pushing fixes, reset the poll count since it's a new CI run

## Output Format

**Success:**
```
All CI checks passed for PR #<NUMBER>

| Check | Status |
|-------|--------|
| build | pass   |
| test  | pass   |
| lint  | pass   |
```

**Pending:**
```
CI checks in progress for PR #<NUMBER> (poll #<N>)
Passed: X | Pending: Y | Failed: Z
Next check in ~4.5 minutes...
```

**Timeout:**
```
CI monitoring timed out for PR #<NUMBER> after ~54 minutes.
Current state: X passed, Y pending, Z failed
```
