# Task Execution

Use for requested code, configuration, documentation, or file changes.

1. Read applicable instructions and active ticket context.
2. Inspect version-control state and the smallest relevant implementation area.
3. Identify the root cause, expected behavior, and smallest coherent change.
4. Reuse established patterns and dependencies before introducing new ones.
5. Make surgical edits; preserve unrelated and uncommitted user work.
6. Validate with `skills/verification.md` and review the final diff.
7. Report the result first, then changed areas, checks, and remaining gaps.

Never hide an error with a broad catch, silent fallback, disabled validation, or
placeholder success path. Fix the cause or report the blocker explicitly.
