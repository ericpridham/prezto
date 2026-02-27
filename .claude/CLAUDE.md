## Planning ##

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unanswered questions, if any.

## Workflows ##

### Planning ###

Follow this workflow when planning a change:

1. Analyze the initial prompt and ask the user any decisions or clarifying questions. Do not make your own assumptions.
2. Break down the plan into reasonable phases.
3. For each phase, write out a detailed implementation plan into a reasonably named subdirectory of `docs/plans/`
4. When asked to implement a phase, break the plan into discrete tasks to be implemented by subagents, parallelizing them as you can.
5. Follow the Implementation plan below for the coding phase.

### Implementation ###

Follow this develop → validate → review loop for all code changes:

1. Delegate code changes to the `code-developer` subagent
2. After code-developer finishes, run `code-validator` on the changes
3. If validator finds issues, pass details back to `code-developer` to fix
4. Repeat 2-3 until validator reports no issues
5. Before any git commit, suggest running `code-reviewer` on staged changes
