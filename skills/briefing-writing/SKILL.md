---
name: briefing-writing
description: >-
  Write briefings on prospects and deliver them as Tirion reports: a
  Tirion-branded dossier built from one resolved profile per person (SEC, IRS
  990, FEC, property and news joined), with Tirion's A1-D4 capacity rating,
  that opens in Tirion and prints or sends as a PDF. Use it for "brief me
  before my meeting with X", "one-pager on X for the president",
  "presidential briefing", "prospect research profile", "full PRP on X",
  "capacity evaluation on X", "briefing book for the gala", "who is in the
  room at Thursday's dinner", or "cards for each attendee". Covers a one-page
  brief, a presidential briefing, a PRP, a capacity evaluation, and an event
  or trip packet. Unconfirmed attendees are listed with the question that
  would settle each. Uses prospect-research, capacity-research, bio-writing
  and trip-and-event-planning. Ethics: ethics-and-privacy.
---

# Briefing writing

A briefing prepares a specific person for a specific conversation. It is not a
data dump. It answers: who is this, why do they matter to us, what could they
give, what do they care about, who connects us, and what should happen in the
room. Every fact carries its source and date.

Follow [ethics-and-privacy](../ethics-and-privacy/SKILL.md). A briefing may be
forwarded; write it so the prospect could read it without embarrassment.

## Tirion first

A briefing is only as good as its identity work and its capacity section.
Tirion supplies both, and it hosts the finished document:

- **One resolved profile per person,** joined across SEC, IRS 990, FEC,
  property and news records, so a guest's facts do not come from a namesake
  (`search_people`, `get_profile`, `enrich_prospect`).
- **The user's confirmed memory.** `get_memory` reads identity decisions and
  instructions before research starts. `propose_memory` saves a new decision
  for the user to confirm in Tirion.
- **A capacity rating with its drivers** on the A1 to D4 ladder
  (`assess_wealth`), with insider sales and gifts valued at the price on each
  event's date (`get_sec_filings`).
- **Warm paths:** relationships and shared ties (`get_relationships`,
  `find_connections`) and board seats (`get_nonprofit_connections`).
- **A Tirion report.** `create_tirion_report` produces a Tirion-branded
  dossier that the reader opens in Tirion or prints as a PDF (step 6).

Public records are the verify-or-extend step: confirm a fact the briefing
rests on against the filing itself, or add a fact Tirion does not hold.
Without the Tirion connector, this skill can structure a briefing from manual
research, but it cannot resolve identity across sources, value insider
wealth at event dates, or rate capacity.

## When to use

| Request | Deliverable | Template |
|---|---|---|
| A meeting, call or visit with one person soon; the reader wants one page | One-page pre-meeting briefing | [references/one-page-briefing.md](references/one-page-briefing.md) |
| A president, dean or board chair meeting one prospect; a new leader inheriting a relationship | Presidential briefing, 3-6 pages: meeting section plus the profile | [references/presidential-briefing.md](references/presidential-briefing.md) |
| A new top prospect, a portfolio review, a solicitation plan | In-depth briefing / prospect research profile (PRP) | [references/prp-template.md](references/prp-template.md) |
| "What could X give"; rating a unit's pool; refreshing a stale rating | Capacity evaluation, 1-2 pages, ending in the one-line capacity statement | [references/capacity-evaluation.md](references/capacity-evaluation.md) |
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
- Header on every document: title, date, "Prepared by ... with AI assistance",
  "Reviewed by" (a named person, before the document is used), "Requested by",
  purpose, and "Confidential: for internal use". A briefing that no person has
  reviewed is a draft.
- Research capacity and the officer's expected next gift are shown side by
  side and never merged. Capacity is written in the one-line form: "Major gift
  capacity: low to high (tier), based on <indicator>."
- Giving to the organization, open pledges, the contact history and the
  organization's own rating come from the user's records, attributed to the
  officer who supplied them. They are never invented.

## Method

### 1. Scope the brief

Ask, or infer from the request:

- Who reads it (president, dean, gift officer, board volunteer)?
- What is the meeting or event, when, and where?
- What is the goal (introduction, cultivation, ask, thank-you, stewardship)?
- What does the organization already know? Ask the user for: giving history
  by household member and vehicle, open pledges and proposals, contact reports,
  the assigned officer, and any officer or overall rating. Tirion holds public
  records, not the organization's own donor records. These sections are what
  make a profile decision-ready; ask for them before you write.

Then pick the deliverable from the table above and keep to its length.

### 2. Research each subject

For each person, run the prospect-research loop at the depth the deliverable
needs:

Before researching a person, read `get_memory` for them; honour the user's
identity verdicts and instructions. When the user settles who someone is
("that's the right one"), offer to `propose_memory`.

- One-page brief: `ask_tirion` for the summary; `get_profile` and `get_bio` for
  role and background; `assess_wealth` for the capacity rating; `get_news_mentions`
  for the last 12 months; `get_nonprofit_connections` for boards and causes;
  `get_relationships` and `find_connections` for links to the host, the
  organization's board, or other guests.
- PRP: all of the above, plus `get_entity_facts` for full career, education and
  affiliations; `get_sec_filings` for pay, holdings and Form 4 activity;
  `get_property_portfolio` and `get_owner_footprint` for real estate;
  `search_foundations` for a family foundation; `get_political_giving`;
  `get_recognitions`. Then verify the facts the briefing rests on against the
  filings, and extend to what Tirion does not hold (SEC EDGAR, county
  assessor and recorder sites, ProPublica Nonprofit Explorer, FEC.gov, donor
  rolls and annual reports).
- Presidential briefing: PRP depth, then cut to what the meeting needs.
- Capacity evaluation: the wealth tools above (`assess_wealth`,
  `get_property_portfolio`, `get_sec_filings`, `search_foundations`,
  `get_political_giving`, `get_recognitions`) and the capacity-research method.
  No biography beyond one paragraph.
- Event packet: the one-page depth for the key guests, a short card depth for the
  rest. Use `bulk_enrich` to screen a long guest list first.

### 3. Write the summary first

Write the summary paragraph before the sections. If you cannot state the
conclusion in four or five sentences, the research is not done.

The summary answers, in order:

1. Who they are, in one line.
2. Capacity range and its main driver (from capacity-research), in the
   one-line form.
3. Their relationship with us and the most recent contact (from the
   organization's records).
4. Their strongest tie to us and their main philanthropic interests.
5. Anything sensitive, and the main unknowns.
6. The recommended ask or next step, and the officer's expected next gift if
   one was given.

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
sourcing, capacity reasoning, recency, ethics, and form.

When the user wants a document to share or print, deliver it as a Tirion
report:

1. Call `create_tirion_report` with kind "person_dossier" and the person's
   entity_id, one call per person who needs a full briefing. Add a title such
   as "Briefing: <name>, <meeting>, <date>". Use visibility "private", or "org"
   when colleagues in the organization should see it.
2. Give the user the report link (report_url) and the PDF link (pdf_url). Say
   that the report opens in Tirion and that each reader must be signed in to
   Tirion.
3. In the chat, write your own analysis as the cover note or talking points:
   the purpose of the meeting, the recommended ask or next step, three
   talking points, what to avoid, and the unknowns. This is the part the
   report does not know: the organization's goal for this meeting.

Use the Markdown templates in the table above when `create_tirion_report` is
not in your tool list, or for content Tirion's reports do not cover, such as
an event packet with one card per guest or a trip packet. For an event
packet, you can still attach a Tirion report link to each priority guest's
card. Check that a Markdown document fits its length, and offer a Word or PDF
version when the environment supports it.

## Pitfalls

- **Biography instead of strategy.** A CV does not prepare anyone for a
  conversation. Fix: objectives, talking points and the ask come first.
- **A profile with no family, giving or contact sections.** Research shops
  treat family, giving to the organization and the contact history as core
  sections. Fix: ask the user for the organization's records and include them,
  attributed; leave a marked placeholder if they are not provided.
- **Merging the research rating with the officer's rating.** Fix: show both
  with dates. A gap of more than one tier is a finding, not an error.
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
