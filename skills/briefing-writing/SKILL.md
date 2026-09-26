---
name: briefing-writing
description: >-
  Write print-ready briefings on prospects. Use it for "brief me before my
  meeting with X", "one-pager on X for the president", "write a prospect
  research profile", "full PRP on X", "briefing book for the gala", "who is in
  the room at Thursday's dinner", "trip briefing for our New York visits", or
  "cards for each attendee". It produces (a) a one-page pre-meeting briefing,
  (b) an in-depth individual briefing or prospect research profile (PRP), or
  (c) an event or trip packet with one card per attendee and an overview of
  who is in the room and why it matters. Attendees who cannot be identified
  with confidence are listed as unconfirmed, with the question that would
  settle each. It uses prospect-research for the research loop,
  capacity-research for the capacity section, bio-writing for the biography,
  and trip-and-event-planning for choosing whom to see. Ethics:
  ethics-and-privacy.
---

# Briefing writing

A briefing prepares a specific person for a specific conversation. It is not a
data dump. It answers: who is this, why do they matter to us, what could they
give, what do they care about, who connects us, and what should happen in the
room. Every fact carries its source and date.

Follow [ethics-and-privacy](../ethics-and-privacy/SKILL.md). A briefing may be
forwarded; write it so the prospect could read it without embarrassment.

## When to use

| Request | Deliverable | Template |
|---|---|---|
| A meeting, call or visit with one person soon | One-page pre-meeting briefing | [references/one-page-briefing.md](references/one-page-briefing.md) |
| A new top prospect, a portfolio review, a solicitation plan | In-depth briefing / prospect research profile (PRP) | [references/prp-template.md](references/prp-template.md) |
| A gala, dinner, reception, board retreat, or a multi-stop trip | Event or trip packet: overview plus one card per attendee | [references/event-packet.md](references/event-packet.md) |

Hand off:

- The research itself (identity, facts, the four dimensions): run
  [prospect-research](../prospect-research/SKILL.md) for each subject.
- The capacity section: [capacity-research](../capacity-research/SKILL.md).
- The biography section: [bio-writing](../bio-writing/SKILL.md).
- Choosing whom to visit on a trip or whom to seat together:
  trip-and-event-planning. This skill writes the packet once the list exists.
- Screening a long guest list: use `bulk_enrich`, then brief the people who matter.

## What good looks like

- Fits the reader. A president gets one page with the ask and the talking
  points. A gift officer gets the full profile. A volunteer gets a short, plain
  card with no wealth detail.
- Opens with a summary paragraph that states the conclusion: who, why they
  matter, capacity range, the purpose of the meeting, the recommended ask or
  next step.
- Is action-oriented: objectives, talking points, topics to avoid, and a next
  step with an owner and a date.
- Every material fact is cited: record and date in a numbered Sources list.
- States what is unknown and what would settle it.
- Header on every document: title, date, "Prepared by", "Prepared for", purpose,
  and "Confidential: for internal use".

## Method

### 1. Scope the brief

Ask, or infer from the request:

- Who reads it (president, dean, gift officer, board volunteer)?
- What is the meeting or event, when, and where?
- What is the goal (introduction, cultivation, ask, thank-you, stewardship)?
- What does the organization already know (past gifts, contact history, the
  officer's notes)? Ask the user; Tirion holds public records, not the
  organization's own donor records.

Then pick the deliverable from the table above and keep to its length.

### 2. Research each subject

For each person, run the prospect-research loop at the depth the deliverable
needs:

- One-page brief: `ask_tirion` for the summary; `get_profile` and `get_bio` for
  role and background; `assess_wealth` for the capacity rating; `get_news_mentions`
  for the last 12 months; `get_nonprofit_connections` for boards and causes;
  `get_relationships` and `find_connections` for links to the host, the
  organization's board, or other guests.
- PRP: all of the above, plus `get_entity_facts` for full career, education and
  affiliations; `get_sec_filings` for pay, holdings and Form 4 activity;
  `get_property_portfolio` and `get_owner_footprint` for real estate;
  `search_foundations` for a family foundation; `get_political_giving`;
  `get_recognitions`. Then fill gaps from public sources (SEC EDGAR, county
  assessor and recorder sites, ProPublica Nonprofit Explorer, FEC.gov, donor
  rolls and annual reports).
- Event packet: the one-page depth for the key guests, a short card depth for the
  rest. Use `bulk_enrich` to screen a long guest list first.

### 3. Write the summary first

Write the summary paragraph before the sections. If you cannot state the
conclusion in four or five sentences, the research is not done.

The summary answers, in order:

1. Who they are, in one line.
2. Capacity range and its main driver (from capacity-research).
3. Their strongest tie to us and their main philanthropic interests.
4. Anything sensitive, and the main unknowns.
5. The recommended ask or next step.

### 4. Build the sections

Use the template for the deliverable. Keep each section to what serves the
meeting. Put detail in tables. Leave out any section with nothing sourced to say,
rather than filling it with guesses.

### 5. Handle people you cannot identify with confidence

Event lists and trip lists often carry a name with no other detail. Do not guess.

- List the person under **Unconfirmed** on the overview and on a short card.
- Show the candidates you found and the facts that separate them (city,
  employer, age range).
- Write the one question that would settle it, for example "Is this the Jane Doe
  who chairs the Acme board, or the Jane Doe at Columbus Children's?" and who
  can answer it (the event host, the registration record, the officer).
- Give no capacity, wealth or giving facts for an unconfirmed person.
- For a guest who is a spouse or plus-one known only by first name, list them as
  "guest of (name)", unconfirmed.

### 6. QC and deliver

Run the QC checklist in
[prospect-research](../prospect-research/references/qc-checklist.md): identity,
sourcing, capacity reasoning, recency, ethics, and form. Then check that the
brief fits its length. Offer a Word or PDF version when the environment supports
it.

## Pitfalls

- **Biography instead of strategy.** A CV does not prepare anyone for a
  conversation. Fix: objectives, talking points and the ask come first.
- **Too long for the reader.** A president will read one page. Fix: one page, with
  a link to the full profile.
- **Wealth detail in a volunteer's card.** Fix: volunteers get role, interests,
  ties and talking points, not asset figures.
- **Guessing an attendee's identity.** Fix: list as unconfirmed with the settling
  question.
- **Stale news as current.** Fix: date each event and check the last 12 months.
- **Forgetting sensitivities.** A recent death, a lawsuit, a failed past ask, a
  gift to a rival. Fix: a "Handle with care" line, stated neutrally and sourced.
- **Contact history from Tirion.** Tirion holds public records, not the
  organization's own contact reports and gift records. Fix: ask the user for
  those, or leave a marked placeholder.
- **Internal database language.** Fix: write about the person and cite public
  records; never mention IDs, fields, or what a database holds.
