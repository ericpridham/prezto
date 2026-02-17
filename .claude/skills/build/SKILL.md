# Implement Plan Skill
1. Read the specified plan document in full
2. Spend MAX 2 minutes on codebase exploration — only look at files directly referenced in the plan
3. Do NOT create a new plan document — execute the existing one
4. Begin implementation immediately, delegating coding tasks to `code-developer`
5. After `code-developer` finishes, run `code-validator` on the changes
6. If validator finds issues, pass details back to `code-developer` to fix
7. When complete, run full test suite and report results
8. Hand off any failures back to the `code-developer` and repeat steps 4-6 until all tests pass
9. Kick off the `code-review` agent to check all staged changes and report results.
10. If issues are identified, ask the users which, if any, we should address.
11. If the user tells us to address issues, go to step 4 and repeat.