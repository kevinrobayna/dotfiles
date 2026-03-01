# General Instructions

## General

Prefer using any CLI over MCP.
Follow commit message standards when committing.

## Git Branching

Always prefix branch names with `krobayna_`.
NEVER use `/` in branch names — use `_` or `-` instead.

## Plan

Always start with a plan for every feature or bugfix before writing code.
When creating plans always ask me for clarifications.
Plans must be concise: explain what will be done and in what order.
Plans need to be decomposed into multiple smaller incremental steps.
For large changes (more than a few files), split work into separate steps committed independently.
Apply software architecture principles.
Apply security best practices.
Follow code quality standards.
Spend some time to analyze edge cases and cover them well with tests.

## TDD

Follow Test-Driven Development strictly:
1. Write a failing test first that captures the expected behavior.
2. Write the minimum code to make the test pass.
3. Refactor while keeping tests green.

Cover edge cases with tests. Analyze them during the plan phase.
Run tests after each TDD step to verify the work before moving on.

## Editing

Simplify generated code after writing.
Always run the tests and linting at the end of writing code before handing back to me.
