# Research Policy

Research is evidence gathering for a decision, not an open-ended inventory.

## Search order

1. Read active ticket notes and prior task artifacts.
2. Open exact paths, symbols, commands, errors, or documents named by the user.
3. Read nearby repository instructions, documentation, configuration, tests,
   history, and existing implementation patterns.
4. Run narrow searches using specific filenames, identifiers, or error text.
5. Broaden to subsystem or repository scans only when targeted evidence is
   insufficient.
6. Use external sources when local evidence cannot answer the question or when
   the fact is current, unstable, high-stakes, or explicitly requested.

## Efficiency

- Batch independent related reads and searches.
- Prefer exact local paths over broad recursive scans.
- Reuse existing task notes, docs, prior outputs, and cached artifacts.
- Follow references only when they can change the next decision.
- Record useful negative evidence, such as a symbol absent from the expected
  configuration, rather than repeatedly searching for it.

## Stop condition

Stop researching when there is enough evidence to select a safe action, explain
the relevant tradeoff, and define a useful verification. Do not keep searching
merely to maximize confidence or collect background information.

If evidence conflicts, identify the authoritative source or run the smallest
discriminating check. If uncertainty still changes behavior materially, ask the
user under `rules/decision-matrix.md`.
