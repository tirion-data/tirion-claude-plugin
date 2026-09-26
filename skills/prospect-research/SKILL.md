---
name: prospect-research
description: >-
  The research loop for one person, couple, family or organization as a
  philanthropic prospect. Use it for "research this prospect", "tell me about
  X before my meeting", "is X a major-gift prospect", "who is X and what could
  they give", "qualify this name", or a bare name with "prospect?". It
  confirms identity, gathers facts from Tirion and then public records, weighs
  capacity, inclination and affinity separately, runs a QC check, and delivers
  a sourced answer or document. It routes to capacity-research (gift-capacity
  estimate and ask range), bio-writing (sourced biography), briefing-writing
  (one-page brief, full profile, event packet),
  market-and-liquidity-intelligence (stock sales, deals, liquidity events),
  finding-prospects and prioritizing-prospects (lists, places, rankings), and
  trip-and-event-planning (who to see on a trip). Ethics: ethics-and-privacy.
---

# Prospect research

This skill is the hub. It runs the research loop for one subject and decides
which specialist skill does each part of the work. The goal is a conclusion a
gift officer can act on: who this is, what they could give, what they care
about, who can open the door, and what to do next. Every fact carries its
public source and date.

Ethics apply to every step. Read [ethics-and-privacy](../ethics-and-privacy/SKILL.md)
once per session before you research a person.

## When to use

- One named subject: a person, a couple, a family, a private foundation, or a
  company whose owners are the real prospects.
- The user asks "who is this", "are they a prospect", "what could they give",
  "what should I know before I see them", or gives a bare name.

Hand off instead when the request is mainly:

| The user wants | Use |
|---|---|
| A capacity rating, an ask range, or "how much could they give" | [capacity-research](../capacity-research/SKILL.md) |
| A written biography (short, standard or long) | [bio-writing](../bio-writing/SKILL.md) |
| A meeting brief, a full prospect research profile, or an event packet | [briefing-writing](../briefing-writing/SKILL.md) |
| What a stock sale, merger, IPO or other liquidity event means | market-and-liquidity-intelligence |
| A close reading of SEC filings (Form 4, proxy, 13D/G) | sec-filing-analysis |
| Real estate: holdings, values, ownership vehicles | property-analysis |
| Form 990 or 990-PF: boards, foundation assets, grants | nonprofit-990-analysis |
| FEC contributions and what they signal | political-giving-analysis |
| New names from a place, a cause, an employer or a list | finding-prospects |
| Rank or triage a portfolio or a screened list | prioritizing-prospects |
| Plan who to see on a trip or at an event | trip-and-event-planning |

Most real requests use this loop plus one or two specialists. Run the loop,
then call the specialist for its part.

## What good looks like

- The subject's identity is settled, with the facts that prove it, before any
  wealth or giving fact is attached.
- The answer leads with the conclusion: capacity range and its drivers, recent
  liquidity or life events with dates, interests, warm paths, and a next step.
- Capacity, inclination and affinity are stated separately. None is folded into
  another.
- Every material fact names its record and date, for example "SEC Form 4, filed
  2026-08-24" or "IRS Form 990-PF, FY2023, Part XIV".
- Gaps are named, with what would close each one.
- The deliverable passes the QC checklist below before it goes out.

## Method

### 1. Scope the job

Decide the depth before you touch data. Match the output to who will read it and
what they will do with it.

- A quick question ("is she worth a visit?") gets a short answer: 5 to 10 lines.
- A meeting next week gets a one-page brief (briefing-writing).
- A new top prospect gets a full prospect research profile (briefing-writing).
- A list of names is a screening job. Send it to prioritizing-prospects or use
  `bulk_enrich`, not this loop row by row.

Do not write a full profile when a paragraph answers the question.

### 2. Establish identity first

Wealth attached to the wrong person is worse than no answer.

1. Start with `ask_tirion`, using the user's own words. It returns a sourced
   summary and refuses to guess between namesakes.
2. Use `search_people` with a state or city to see the candidates. Use
   `enrich_prospect` when you have a name plus an address or employer; it
   reports how strong the match is.
3. Collect at least two independent identity anchors: middle name or initial,
   city, employer, spouse, age range, a board seat, a degree.
4. If two or more people fit, stop. Show the facts that separate them and ask the
   user which one. Never merge them.
5. If one profile holds facts that do not fit one life (roles in many states,
   ages that conflict, careers that cannot overlap), treat it as a possible mix
   of namesakes. Say so. Use only the facts you can tie to the anchors.
6. For a couple or family, identify each person separately. Link them only with
   evidence: a shared deed, a joint gift, a wedding announcement, a proxy
   statement that names the spouse.

### 3. Gather: Tirion first, then public sources

Pull what Tirion holds, then fill gaps from public records. Tag every fact as
confirmed (a filing or record shows it) or inferred (your reasoning from other
facts), and date it.

| Question | Tirion tools | Public sources when Tirion is silent |
|---|---|---|
| Who they are, career, education | `get_profile`, `get_bio`, `get_entity_facts` | Company proxy, university and firm bios, press releases |
| Real estate | `get_property_portfolio`, `search_properties`, `search_by_address`, `get_owner_footprint` | County assessor and recorder sites |
| Public-company stock and pay | `get_sec_filings` | SEC EDGAR full-text search: Forms 3, 4, 5, 144, DEF 14A, 13D/G |
| Nonprofit boards and foundations | `get_nonprofit_connections`, `search_foundations`, `get_board_roster` | ProPublica Nonprofit Explorer, IRS TEOS |
| Political giving | `get_political_giving`, `get_fec_committee` | FEC.gov individual contributions |
| Recognition and news | `get_recognitions`, `get_news_mentions` | Donor rolls, annual reports, local business press |
| People around them | `get_relationships`, `find_connections` | Proxy bios, 990 officer lists, deeds |
| Capacity rating | `assess_wealth`, `get_capacity` | Build from assets (capacity-research) |

Rules for this step:

- A news mention is only about your subject when the article shows it: same
  employer, city, or role. Many name matches are about a namesake.
- A property the assessor lists under the name is not the subject's until the
  address, a co-owner, or a mailing address ties it to them.
- No result from a tool means Tirion has not linked it. It does not mean the fact
  is false. Check the public source.
- If Tirion is thin and the user wants deeper work, `propose_research` says what
  research would add and what it costs.

### 4. Assess the four dimensions separately

- **Capacity**: what they could give over 3 to 5 years if they chose to.
  Hand off to [capacity-research](../capacity-research/SKILL.md). It returns a
  range, the drivers, the exclusions and a confidence.
- **Inclination**: evidence that they give at all. Named gifts, donor rolls,
  foundation grants (990-PF Part XIV, Supplementary Information), nonprofit board service, pledges reported
  in the press.
- **Affinity**: evidence of a tie to the user's organization or its mission.
  Degrees, past gifts, volunteer roles, event attendance, cause giving that
  matches the mission.
- **Linkage**: who can open the door. Board members, co-investors, co-trustees,
  neighbors, classmates. Use `get_relationships` and `find_connections`, and the
  board rosters of organizations they serve.

A person with high capacity and no affinity is a long-term cultivation idea, not
a solicitation. Say so plainly. Combine the dimensions only in the recommendation.

### 5. Look for what changed

Recent events drive timing. Check the last 12 to 24 months for:

- Stock sales or option exercises (Form 4), a merger or sale of their company,
  an IPO, a large real-estate sale (recorder), a new role or retirement.
- A new foundation or a large contribution into an existing one (990-PF).
- Honors, board appointments, a named gift elsewhere.
- A death in the family or a divorce, only when public and relevant, and handled
  with care under ethics-and-privacy.

For stock and deal events, use market-and-liquidity-intelligence.

### 6. Run QC

Run the checklist below. Fix what fails, then deliver. Expect the first draft to
fail at least one item. The full list with the fix for each item is in
[references/qc-checklist.md](references/qc-checklist.md).

### 7. Deliver

Lead with the conclusion. Then the evidence. Then gaps and the next step.

For a chat answer, use this order:

1. One-paragraph summary: who they are, capacity range and drivers, the
   strongest interest and tie, the recommended next step.
2. Capacity (range, drivers, what is excluded, confidence).
3. Recent events, with dates.
4. Philanthropy and interests.
5. Relationships and warm paths.
6. Gaps and how to close them.
7. Sources (numbered: record, date, URL).

For a document, use the templates in briefing-writing. Every document has a title,
date, "Prepared by", a statement of what it is for, a summary at the top, and a
numbered Sources list. Offer a Word or PDF version when the environment supports
it.

## QC checklist (every deliverable)

**Identity**
- Two or more independent anchors tie every fact to this person.
- Namesakes are named and excluded, or the user was asked.
- Family links rest on a record, not a shared surname.

**Sourcing**
- Every material fact names its record and date. URLs where a tool returned one.
- Inferences are labeled as inferences, with their basis.
- No fact comes from a single unverified news match.

**Capacity reasoning**
- Capacity is a range with drivers, exclusions and confidence, never one number.
- Assessed value is not called market value. Stock awards are not called cash.
  Sale proceeds are not called net worth.
- Capacity is kept apart from inclination and affinity. The ask range says how
  inclination changed it.

**Recency**
- Each figure carries its as-of date. Holdings reported by someone who has left a
  company are marked "last reported on (date)".
- Nothing older than about 3 years is presented as current without saying so.

**Ethics**
- Public and properly sourced information only.
- No private contact details, health, religion by inference, sexual orientation,
  immigration status, or facts about minors.
- A reader could learn how every fact was found and not be uncomfortable.

## Pitfalls

- **Researching before identifying.** A common name plus a rich profile invites a
  merge of two people. Fix: anchors first, facts second.
- **Reading silence as absence.** No linked property or filing is not proof the
  person has none. Fix: say what is unknown and name the record that would settle it.
- **Describing the tool instead of the person.** Do not write about what Tirion
  holds or lacks. Write about the prospect and cite public records.
- **Visible wealth taken as total wealth.** The wealthiest people often show the
  least: assets sit in private companies, partnerships and trusts. Fix: treat
  visible assets as a floor, and say what could sit above it.
- **Capacity mistaken for the ask.** Capacity is the ceiling. The ask depends on
  inclination and affinity. Fix: give both, separately.
- **Stale facts presented as current.** Titles, board seats and holdings change.
  Fix: date everything, and recheck anything older than a year.
- **Over-building.** A full profile for a quick question wastes the officer's
  time. Fix: scope first (step 1).

## Hand-off notes

When you call a specialist, pass it the settled identity (name, city, employer,
anchors) and the facts you already gathered, so it does not repeat the lookups.
