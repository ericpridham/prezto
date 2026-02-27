---
name: review
description: Review code changes for bugs, security issues, quality, and test coverage gaps. Use when the user wants a code review of their branch, staged changes, or a specific diff.
argument-hint: [branch-or-ref]
disable-model-invocation: true
---

# Review

Review code changes and report findings.

## Determine the diff

- If `$ARGUMENTS` is provided, use it as the base ref: `git diff $ARGUMENTS...HEAD`
- If no arguments, diff current branch against main: `git diff main...HEAD`

## Analyze

For all changed files, check for:
- Bugs and logic errors
- Security vulnerabilities
- Code quality and maintainability issues
- Test coverage gaps
- Dead or unreachable code

## Report

Write findings as a numbered list with severity levels:
- **critical** — bugs, security issues, data loss risks
- **medium** — quality issues, missing edge cases, poor naming
- **low** — style, minor improvements, suggestions

## Next steps

Ask the user which findings (if any) to fix. If the user selects findings, delegate fixes to `code-developer` and follow the develop → validate → review loop from CLAUDE.md.