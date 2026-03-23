# Plan

## 1. What this plan is based on

- Work type: [new project / new feature / major change / migration]
- Assumptions:
  - [Assumption]
  - ...
- Design limits to keep:
  - [Limit]
  - ...
- Existing system limits (brownfield only):
  - [Limit from current code, data, APIs, runtime, or architecture]
  - ...
- Gaps in the input design:
  - [Gap]
  - ...

---

## 2. Decisions this plan treats as fixed

_Only list decisions this plan depends on and is not likely to revisit soon._

### Fixed decision: [Name]

- Decision: [clear statement]
- Why fixed for now: [reason]
- How hard to change later: [easy / medium / hard]
- Planning impact:
  - [Impact]
  - ...

### Fixed decision: [Next Name]

- ...

---

## 3. How we will do the work

- Smallest useful first slice: [the first thin piece worth building]
- Main risks to test early:
  - [Risk]
  - ...
- Why this order:
  1. [Reason]
  2. ...
- Default done checklist for each slice:
  - [ ] Code works locally
  - [ ] Tests added or updated at the right level
  - [ ] Main path can be shown
  - [ ] Contracts, schema, or notes updated if needed

---

## 4. Slice breakdown

_A slice is one thin vertical piece of work that starts somewhere real, finishes with a visible result and helps prove the next step._

### Slice [N]: [Slice Name]

- Goal: [what this slice gets done]
- Why now: [why this slice comes here]
- Owning context: [the part of the business/domain that owns the main decision]
- Start signal: [user action, command, or event that starts this slice]
- Success signal: [visible result or domain event that shows this slice worked]
- Covers:
  - Flows: [list]
  - Contexts touched: [list]
  - Contracts / integrations: [list]
- Key rules that must stay true:
  - [Rule]
  - ...
- In scope:
  - [Included item]
  - ...
- Out of scope:
  - [Excluded item]
  - ...
- Depends on:
  - [Earlier slice / existing code / external dependency / none]
  - ...
- Start condition:
  - [What must already be true]
- End condition:
  - [What must be true for this slice to count as done]
- How we will check it:
  - [unit / integration / e2e / manual demo / research result]
- What this proves:
  - [Proof]
  - ...
- What this makes possible next:
  - [Next slice, decision, or capability]
  - ...
- Main risks reduced:
  - [Risk]
  - ...
- Acceptance criteria:
  - [ ] [Criterion]
  - ...

### Slice [N+1]: [Next Slice Name]

- ...

---

## 5. Delivery order summary

_Use this only if there is more than one real slice._

| Order | Slice   | Why now  | Depends on     | Proves  | Enables next |
| ----- | ------- | -------- | -------------- | ------- | ------------ |
| 1     | [Slice] | [Reason] | [Dependencies] | [Proof] | [Next]       |
| ...   | ...     | ...      | ...            | ...     | ...          |

---

## 6. Feedback back into design

- Design assumptions that held up:
  - [Item]
  - ...
- Design assumptions challenged during planning:
  - [Item]
  - ...
- Changes needed back in the design map:
  - [Change]
  - ...
- None: [Yes / No]

---

## 7. Risks, unknowns, and research tasks

_A research task is a short piece of work done to answer an important question._

| Item | Why it matters | How to resolve it | Earliest slice |
| ---- | -------------- | ----------------- | -------------- |
| [Item] | [Reason]     | [Action]          | [Slice]        |
| ...    | ...          | ...               | ...            |