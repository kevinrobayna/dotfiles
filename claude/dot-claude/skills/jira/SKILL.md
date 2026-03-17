---
name: jira
description: Interact with Jira Cloud using the acli CLI tool for work items, boards, sprints, projects, and more
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
allowed-prompts:
  - tool: Bash
    prompt: acli auth status
  - tool: Bash
    prompt: acli jira workitem view
  - tool: Bash
    prompt: acli jira workitem search
  - tool: Bash
    prompt: acli jira workitem comment list
  - tool: Bash
    prompt: acli jira project list
  - tool: Bash
    prompt: acli jira project view
  - tool: Bash
    prompt: acli jira board search
  - tool: Bash
    prompt: acli jira board get
  - tool: Bash
    prompt: acli jira board list-sprints
  - tool: Bash
    prompt: acli jira board list-projects
  - tool: Bash
    prompt: acli jira sprint view
  - tool: Bash
    prompt: acli jira sprint list-workitems
  - tool: Bash
    prompt: acli jira filter list
  - tool: Bash
    prompt: acli jira field list
  - tool: Bash
    prompt: acli jira dashboard list
---

# Jira CLI Interaction

Interact with Jira Cloud projects, work items, boards, and sprints using the `acli` CLI tool.

## Overview

This skill enables safe interaction with Jira through the Atlassian CLI. Read-only commands are allowed by default, while write operations require user confirmation.

**Core capabilities:**
- View and search work items (issues)
- Browse projects, boards, and sprints
- Read comments on work items
- Search with JQL queries
- View dashboards and filters

## Instructions

### Pre-flight Check

Always verify authentication before running commands:

```bash
acli auth status
```

If not authenticated, tell the user to run `acli auth login` (opens browser for OAuth).

### Available Commands

#### Work Items (Read-Only)

```bash
# View a work item
acli jira workitem view --key <KEY>

# Search with JQL
acli jira workitem search --jql "project = PROJ AND status = 'In Progress'"

# Search assigned to current user
acli jira workitem search --jql "assignee = currentUser() ORDER BY updated DESC"

# List comments on a work item
acli jira workitem comment list --key <KEY>
```

#### Projects

```bash
# List all projects
acli jira project list

# View project details
acli jira project view --key <KEY>
```

#### Boards

```bash
# Search boards
acli jira board search

# Get board details
acli jira board get --board-id <ID>

# List sprints for a board
acli jira board list-sprints --board-id <ID>

# List projects for a board
acli jira board list-projects --board-id <ID>
```

#### Sprints

```bash
# View sprint details
acli jira sprint view --sprint-id <ID>

# List work items in a sprint
acli jira sprint list-workitems --sprint-id <ID>
```

#### Other

```bash
# List filters
acli jira filter list

# List fields
acli jira field list

# List dashboards
acli jira dashboard list
```

### Common Workflows

#### Investigating an Issue

1. View the work item:
   ```bash
   acli jira workitem view --key PROJ-123
   ```
2. Read comments for context:
   ```bash
   acli jira workitem comment list --key PROJ-123
   ```

#### Checking Sprint Progress

1. Find the board:
   ```bash
   acli jira board search
   ```
2. List active sprints:
   ```bash
   acli jira board list-sprints --board-id <ID>
   ```
3. View sprint work items:
   ```bash
   acli jira sprint list-workitems --sprint-id <ID>
   ```

#### Finding My Work

```bash
acli jira workitem search --jql "assignee = currentUser() AND status != Done ORDER BY updated DESC"
```

### Write Operations (Require Confirmation)

The following operations modify Jira state and should be confirmed with the user:

- `acli jira workitem create` - Create a work item
- `acli jira workitem edit` - Edit a work item
- `acli jira workitem transition` - Transition a work item status
- `acli jira workitem assign` - Assign a work item
- `acli jira workitem comment create` - Add a comment
- `acli jira workitem delete` - Delete a work item
- `acli jira workitem archive` - Archive a work item
- `acli jira workitem clone` - Clone a work item
- `acli jira workitem link` - Link work items

**Before executing write operations:**
1. Explain what the command will do
2. Ask for explicit confirmation
3. Show the exact command that will run
4. Execute only after user approval

### Output Formatting

Use `--json` when you need to parse output programmatically. Use plain output for display to the user.

### Error Handling

1. **Not authenticated:** Tell user to run `acli auth login`
2. **Work item not found:** Verify the key format (PROJECT-NUMBER)
3. **Permission denied:** Check project access with the user

## Usage

```
/jira
/jira show PROJ-123
/jira my issues
/jira search "status = 'In Progress'"
```

## Safety Guidelines

1. **Read operations are safe** - viewing, listing, searching
2. **Write operations need confirmation** - creating, editing, transitioning, deleting
3. **Never expose secrets** - avoid displaying tokens or sensitive data
4. **Verify context** - confirm project/issue keys with the user when ambiguous
