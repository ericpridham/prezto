## Planning ##

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unanswered questions, if any.

## Workflow ##

Follow this develop → validate → review loop for all code changes:

1. Delegate code changes to the `code-developer` subagent
2. After code-developer finishes, run `code-validator` on the changes
3. If validator finds issues, pass details back to `code-developer` to fix
4. Repeat 2-3 until validator reports no issues
5. Before any git commit, suggest running `code-reviewer` on staged changes
