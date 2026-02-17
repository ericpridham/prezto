---
name: build
description: Execute an implementation plan by delegating to code-developer with validation and review. Use when the user has a plan file and wants to implement it.
argument-hint: [plan-file-path]
disable-model-invocation: true
---

# Build

Execute the plan at `$ARGUMENTS`.

## Steps

1. Read the plan document in full
2. Only explore files directly referenced in the plan — no broad codebase exploration
3. Do NOT create a new plan — execute the existing one
4. Implement by delegating coding tasks to `code-developer`
5. Follow the develop → validate → review loop from CLAUDE.md for each change
6. When all changes pass validation, run the full test suite
7. If tests fail, delegate fixes to `code-developer` and repeat from step 5
8. Run `code-reviewer` on all staged changes and report results
9. Ask the user which review issues (if any) to address
10. If the user selects issues, go to step 4 for those fixes