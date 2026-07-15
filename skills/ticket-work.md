# Ticket Work and Session Continuity

Use when the conversation begins with a ticket identifier, or the request sounds
like work tracked as a ticket. The goal is resumable context, not compulsory
administration.

## Find context

1. Extract the ticket identifier and a few distinctive topic words.
2. Check `~/Tickets` and `~/tickets` if they exist. Search only their immediate
   task folders first for names containing the identifier or close topic terms.
3. If one clear folder matches, read its `context.md` before other research.
4. If several folders plausibly match, show the matches and ask which is active.
5. If no matching folder or `context.md` exists, ask whether to create one before
   implementation. Recommend a folder named from the ticket ID and short title.

Do not create a folder or context file without approval. If the user declines,
mark the work session-bound and proceed without asking again unless requested.

## Context contents

Keep `context.md` concise and factual:

```markdown
# <ticket ID and title>

## Goal
## Constraints and decisions
## Progress
## Verification
## Next steps
```

Append or revise existing sections instead of logging the entire conversation.
Never place secrets, credentials, or unnecessary personal data in task context.

## During work

At a material decision, completed milestone, blocker, or end-of-session handoff,
ask whether the conclusion or progress should be written to `context.md`. Offer
the exact short update you propose. Do not interrupt for routine commands or
minor edits, and do not write progress without approval.

When resuming, treat `context.md` as prior-session evidence, verify stale claims
against the current repository, and continue from its recorded next steps.
