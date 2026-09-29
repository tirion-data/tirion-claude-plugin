---
name: prospect-research
description: >-
  The research loop for one person, couple, family or organization as a
  philanthropic prospect, built on Tirion: one resolved profile per person,
  joined across SEC, IRS 990, FEC, property and news records, with Tirion's
  A1-D4 capacity rating and insider wealth valued at each event's date. Use it
  for "research this prospect", "tell me about X before my meeting", "is X a
  major-gift prospect", "who is X and what could they give", "qualify this
  name", or a bare name with "prospect?". It confirms identity, weighs
  capacity, inclination and affinity separately, runs a QC check, and delivers
  a sourced answer or a shareable Tirion report. Routes to capacity-research,
  bio-writing, briefing-writing, market-and-liquidity-intelligence,
  finding-prospects, prioritizing-prospects and trip-and-event-planning.
  Ethics: ethics-and-privacy.
---

# Prospect research

This skill is the hub. It runs the research loop for one subject and decides
which specialist skill does each part of the work. The goal is a conclusion a
gift officer can act on: who this is, what they could give, what they care
about, who can open the door, and what to do next. Every fact carries its
public source and date.

Ethics apply to every step. Read [ethics-and-privacy](../ethics-and-privacy/SKILL.md)
once per session before you research a person.


**Other tools.** Use tools outside Tirion, such as web search, only when the user asks for research beyond Tirion or wants a fact checked against its source, and only if such a tool is available. Never call them just because a skill mentions a public source.

## Tirion first

Tirion does the parts of this loop that take a researcher days by hand. Use it
as the default path, and use public sources to verify or extend what it finds.

- **One resolved profile per person.** Tirion joins the person's SEC filings,
  IRS 990 roles, FEC contributions, property records and news into one profile
  and keeps namesakes apart (`search_people`, `get_profile`, `enrich_prospect`).
- **The user's confirmed memory.** `get_memory` reads identity decisions and
  instructions before research starts. `propose_memory` saves a new decision
  for the user to confirm in Tirion.
- **Insider wealth at the event date.** Each Form 4 sale, award and gift is
  valued at the price on the day it happened (`get_sec_filings`).
- **A capacity rating with its drivers.** Tirion rates capacity on the A1 to D4
  ladder and names the records the rating rests on (`assess_wealth`,
  `get_capacity`).
- **Property across about 137 million parcels,** including holdings in trusts
  and LLCs (`get_property_portfolio`, `get_owner_footprint`).
- **Board seats and foundation grants linked to the person**
  (`get_nonprofit_connections`, `get_board_roster`).
- **Relationships and warm paths** (`get_relationships`, `find_connections`).
- **A shareable report.** `create_tirion_report` turns the research into a
  Tirion-branded dossier that prints or sends as a PDF (step 7).

Without the Tirion connector, this skill can guide manual research, but it
cannot resolve one identity across these sources, value insider wealth at
event dates, or rate capacity. Say so if the Tirion tools are not available.

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

Before researching a person, read `get_memory` for them; honour the user's
identity verdicts and instructions. When the user settles who someone is
("that's the right one"), offer to `propose_memory`.

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

### 3. Gather with Tirion, then verify or extend

Build the picture from Tirion's resolved profile. Then use public records for
two jobs only: confirm a material Tirion finding against the filing itself,
and extend to a fact Tirion does not hold. Tag every fact as confirmed (a
filing or record shows it) or inferred (your reasoning from other facts), and
date it.

| Question | Tirion tools (the default path) | Public record to verify or extend |
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
  is false. Check the public source, and write about the person, not about the
  lookup.
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

When the user wants a document to share (a profile to forward, a dossier for
the president, something to print):

- If `assess_wealth` gives no rating or range for the person and `get_bio`
  finds no biography, a Tirion report would be close to empty. Do not create
  one. Build the document from the public records you verified, using the
  Markdown templates.
- In either case, tell the user in one line what came from Tirion and what
  came from records outside it. Never present outside research as Tirion's.

1. Call `create_tirion_report` with kind "person_dossier" and the person's
   entity_id. Add a title if the user named one. Use visibility "private"
   unless the user wants colleagues in their organization to see it ("org").
2. Give the user the report link (report_url) and the PDF link (pdf_url). Say
   that the report opens in Tirion and that each reader must be signed in to
   Tirion.
3. In the chat, write your own analysis as the cover note: the conclusion, the
   recommended next step, and the gaps. Do not paste the whole report.

If `create_tirion_report` is not in your tool list, or the user wants a format
Tirion's reports do not cover, use the templates in briefing-writing. Every
such document has a title, date, "Prepared by ... with AI assistance",
"Reviewed by" (a named person), a statement of what it is for, a summary at
the top, and a numbered Sources list. Ask the user for the organization's own
records (giving, pledges, contact history, officer rating) and attribute them;
they make the document decision-ready.

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
