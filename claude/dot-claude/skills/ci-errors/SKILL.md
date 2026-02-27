---
name: ci-failure-analysis
description: Analyze GitHub Actions CI failures, fetch logs, identify root causes, and propose fixes
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash(gh pr view)
  - Bash(gh pr view:*)
  - Bash(gh pr diff)
  - Bash(gh pr diff:*)
  - Bash(gh pr checks)
  - Bash(gh pr checks:*)
  - Bash(gh run list)
  - Bash(gh run list:*)
  - Bash(gh run view)
  - Bash(gh run view:*)
---

# CI Failure Analysis

Analyze GitHub Actions workflow failures for a PR, identify root causes, and propose specific fixes.

## Inputs

- **PR Number**: The pull request number to analyze (provided as context)
- **Repository**: Inferred from current git remote

## Process

### Step 1: Fetch Failing Checks

```bash
# Get all checks for the PR
gh pr checks <PR_NUMBER>

# List recent workflow runs
gh run list --limit 10
```

Identify which checks have failed (status: failure or error).

### Step 2: Fetch Workflow Logs

For each failing workflow run:

```bash
# Get detailed run info including job IDs
gh run view <RUN_ID>

# Get failed job logs
gh run view <RUN_ID> --log-failed
```

### Step 3: Analyze Failure Patterns

Parse the logs looking for:

1. **Test failures**: Look for patterns like `FAIL`, `Error:`, `AssertionError`, test framework output
2. **Build errors**: Compilation errors, type errors, missing dependencies
3. **Lint/format errors**: ESLint, Prettier, style violations
4. **Infrastructure errors**: Timeout, OOM, network failures, flaky tests

### Step 4: Correlate with PR Changes

```bash
# Get the PR diff to understand what changed
gh pr diff <PR_NUMBER>
```

Cross-reference failures with changed files:
- If a test file failed, check if it was modified in the PR
- If a source file error, check if that file or its dependencies were modified
- Identify if failures are likely caused by PR changes vs pre-existing issues

### Step 5: Generate Diagnosis

For each failure, produce:

```markdown
### Failure: [Job Name] - [Step Name]

**Error Type**: [test/build/lint/infrastructure]
**Root Cause**: [Specific explanation]
**File**: `path/to/file.ts:line`
**Error Message**:
```
[Relevant error excerpt]
```

**Proposed Fix**:
[Specific code change or action needed]

**Confidence**: [High/Medium/Low]
```

## Output Format

```markdown
## CI Failure Analysis for PR #<NUMBER>

**Total Failures**: X
**Categories**: Y test failures, Z build errors

---

[Individual failure analyses as above]

---

## Summary of Required Fixes

1. `file.ts:42` - [Brief description]
2. `other.ts:15` - [Brief description]

```

## Edge Cases

- **Flaky tests**: If the same test passes in some runs but fails in others, note it as potentially flaky
- **Infrastructure issues**: If failure is clearly not code-related (timeout, runner issue), note that re-running may fix it
- **Multiple root causes**: List all distinct issues, don't assume all failures have the same cause
