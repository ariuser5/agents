# Verification

Choose the smallest check that can fail for the behavior changed.

1. Start with a focused test, parser, compiler, linter, or direct reproduction.
2. Expand to broader suites only when the change crosses boundaries or focused
   checks expose integration risk.
3. Review the diff for accidental edits, secrets, debug output, generated files,
   and scope creep.
4. Distinguish checks that passed, failed, or could not run.
5. Never describe unrun checks as passing and never suppress a failure to produce
   a clean result.

Documentation-only changes still require relevant link, structure, rendering, or
consistency checks when available.
