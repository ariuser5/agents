# Ask or Proceed Decision Matrix

Use this matrix before interrupting the user. Ask one focused question that
surfaces the actual decision; do not transfer routine investigation to the user.

## Ask first

| Condition | Required behavior |
| --- | --- |
| Destructive, irreversible, or difficult-to-undo action | Describe the exact action and consequence; wait for approval. |
| Requested scope must expand | Explain the added scope and why it is needed; wait for alignment. |
| Multiple valid paths have materially different behavior, cost, compatibility, or maintenance impact | Present the smallest useful set of options and recommend one. |
| Security, authentication, secrets, trust, or permissions change | State the boundary being changed and obtain explicit approval. |
| Delete, rename, move, or overwrite user data | Name the affected paths and recovery implications; wait for approval. |
| A required product, policy, interface, or acceptance decision is missing | Ask for that requirement; do not invent it. |
| Ticket-like work has no usable task context | Follow `skills/ticket-work.md` and ask whether to create context. |

## Proceed

Proceed without asking when all relevant conditions hold:

- The work is bounded, reversible, and within the requested scope.
- The next step is a normal read, targeted search, edit, or verification step.
- Existing code or documentation provides a clear convention.
- A safe default exists and does not materially affect external behavior.
- A failed attempt can be diagnosed or reverted without losing user work.

## Escalation shape

When asking, include: the decision, why it matters now, the recommended option,
and at most two meaningful alternatives. Continue safe read-only work while
waiting when it can reduce uncertainty without pre-committing the decision.
