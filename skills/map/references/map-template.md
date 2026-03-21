# Map

## 1. Ubiquitous Language

### 1.1 Shared Terms

_List terms that must mean the same thing everywhere._

- [Term]: [exact domain meaning]
- ...

### 1.2 Context-Specific Meanings

_Only include terms whose meaning changes on purpose by bounded context. Do not allow accidental ambiguity._

- [Term] in [Context A]: [meaning]
- [Term] in [Context B]: [meaning]
- Example / result of the difference: [example]
- ...

### 1.3 Renamed / Rejected Terms

_Replace vague, overloaded, or technical terms with better domain language._

- Original: [old term] → New: [domain term]
  Reason: [why the old term was weak and the new one is better]
- ...

### 1.4 Terminology Rules

- Terms that must never be used as if they mean the same thing: [list]
- Terms still not settled: [list]

---

## 2. Strategic Design

### 2.1 Subdomains

_A subdomain is a meaningful part of the problem space._

| Subdomain   | Classification (Core / Supporting / Generic) | Why it belongs here | Value / Risk   |
| ----------- | --------------------------------------------- | ------------------- | -------------- |
| [Subdomain] | [Classification]                              | [Reason]            | [Value / risk] |
| ...         | ...                                           | ...                 | ...            |

### 2.2 Bounded Contexts

_A bounded context is a clear boundary around one model, its language, and what it owns._

#### Context: [Bounded Context Name]

- Purpose: [one-sentence domain purpose]
- Responsibilities:
  - [Responsibility]
  - ...
- Owns: [data, rules, workflows, events, concepts fully controlled here]
- Does not own: [what belongs elsewhere]
- Serves subdomain: [Subdomain]
- Upstream contexts: [list]
- Downstream contexts: [list]

#### Context: [Next Bounded Context Name]

- ...

### 2.3 Context Map

_List relationships between contexts clearly._

| From        | To          | Integration pattern                                                                 | What is exchanged                                | Why this pattern fits |
| ----------- | ----------- | ----------------------------------------------------------------------------------- | ------------------------------------------------ | --------------------- |
| [Context A] | [Context B] | [Customer-Supplier / Conformist / ACL / Published Language / Shared Kernel / Other] | [API / events / files / messages / shared model] | [Reason]              |
| ...         | ...         | ...                                                                                 | ...                                              | ...                   |

### 2.4 Boundary Health Check

- Weak boundaries found: [none or list]
- Overly technical or anemic boundaries found: [none or list]
- Revisions made: [what changed]
- Remaining uncertainty: [list]

---

## 3. Key Domain Flows

### 3.1 Flow Priority List

_List major end-to-end flows in priority order. Say how value and risk were balanced._

| Flow   | Value                 | Risk                  | Priority | Reason   |
| ------ | --------------------- | --------------------- | -------- | -------- |
| [Flow] | [High / Medium / Low] | [High / Medium / Low] | [1]      | [Reason] |
| ...    | ...                   | ...                   | ...      | ...      |

### 3.2 Flow Detail

_Repeat for each priority flow._

#### Flow: [Flow Name]

- Outcome: [what value this flow delivers]
- Primary bounded context: [the one context that owns the main decision in this flow]
- Trigger: [user action / event / schedule / command]
- Success signal: [visible result or domain event that shows this flow worked]
- Preconditions: [what must already be true]
- Key rules touched:
  - [Rule]
  - ...
- Smallest useful version: [the first thin version worth building]

Steps across contexts

| Step | Context   | Action   | Command / API / Message / Event | State change   | Failure / retry / compensation |
| ---- | --------- | -------- | ------------------------------- | -------------- | ------------------------------ |
| 1    | [Context] | [Action] | [Name]                          | [What changes] | [How failure is handled]       |
| ...  | ...       | ...      | ...                             | ...            | ...                            |

Flow stress test

- Hidden coupling exposed: [Yes / No + details]
- Broken or fuzzy boundaries exposed: [Yes / No + details]
- Design changes made because of this flow: [details]
- Remaining operational risks: [list]
- Required observability: [logs / metrics / tracing / alerts]

#### Flow: [Next Flow Name]

- ...

---

## 4. Bounded Context Designs

_Repeat this full section for each bounded context. Stay at planning level. Only include implementation detail when it changes sequencing, rules, or contracts._

### Context: [Bounded Context Name]

- Purpose: [one-sentence domain purpose]
- Responsibilities:
  - [Responsibility]
  - ...

#### Owned Data

_What this context is the source of truth for._

- [Data / concept] — [why it is owned here]
- ...

#### Aggregate Roots

_The main objects that protect important rules and consistency._

- [Aggregate Root] — Purpose: [purpose]; Rules enforced: [rules]
- ...

#### Entities

_Objects with identity that matter over time._

- [Entity] — Identity: [identifier]; Responsibility: [role]
- ...

#### Value Objects

_Objects defined by meaning, not identity._

- [Value Object] — Meaning: [meaning]; Why no identity: [reason]
- ...

#### Domain Services

_Domain logic that does not fit naturally on one entity or value object._

- [Service] — [stateless domain responsibility]
- ...

#### Repositories

_How aggregates are loaded and saved._

- [Repository] — [what aggregate(s) it loads / persists]
- ...

#### Domain Events

_Important things that happened in the domain._

- [Event Name] — Raised when: [condition]; Payload: [key fields]; Consumers: [who uses it]
- ...

#### Rules and Consistency Boundaries

_Which rules must hold immediately, and which can settle later._

- Rules that must always hold inside this context:
  - [Rule]
  - ...
- Cross-aggregate or cross-context rules that may be eventually consistent:
  - [Rule]
  - ...
- Consistency model used here: [strong / eventual / mixed]
- Why this is acceptable: [reason]

#### External Dependencies

- [Dependency] — Type: [vendor / legacy / other context / external system]; Why needed: [reason]; Isolation strategy: [ACL / adapter / direct / published language]
- ...

#### Interfaces / Contracts

- Inbound contracts: [commands, APIs, messages accepted]
- Outbound contracts: [events, APIs, messages emitted]
- Published language or schema limits: [details]

### Context: [Next Bounded Context Name]

- ...

---

## 5. Global Architecture Decisions

_Only include decisions that affect multiple contexts or create real delivery trade-offs._

### 5.1 Decision Records

_Use one block per decision._

#### Decision: [Decision Name]

- Decision: [clear statement]
- Problem addressed: [what forced the choice]
- Applies across: [contexts / system areas]
- Reasoning: [why this option was chosen]
- Trade-offs:
  - Gain: [benefit]
  - Cost: [cost]
  - Risk: [risk]
- Alternatives considered: [brief list]
- Reversibility: [easy / moderate / hard / effectively irreversible]
- Why: [why reversible or hard to unwind]
- Follow-on consequences: [what this means for later design / delivery]

#### Decision: [Next Decision Name]

- ...

### 5.2 Cross-Cutting Decision Checklist

_Fill only the items that matter._

- Sync vs async interaction: [decision + reason]
- Event vs API integration: [decision + reason]
- Transaction and consistency boundaries: [decision + reason]
- Legacy isolation / anti-corruption layers: [decision + reason]
- Build vs buy for generic subdomains: [decision + reason]
- Read / write separation: [decision + reason]
- Other cross-context decisions: [list]