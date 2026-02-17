# Code Review Skill
1. Get the current branch diff against main: `git diff main...HEAD`
2. Analyze all changed files for: bugs, security issues, code quality, test coverage gaps, dead code
3. Write findings as a numbered list with severity (critical/medium/low)
4. Ask user which findings to implement
5. Implement selected fixes, run full test suite, confirm all pass
6. Stage ONLY changed files (verify with `git diff --cached --name-only`), commit with descriptive message
