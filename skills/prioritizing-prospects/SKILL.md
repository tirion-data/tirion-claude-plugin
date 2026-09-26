---
name: prioritizing-prospects
description: Qualify, rank and tier a pool of prospects or a gift officer's portfolio, or screen a list of names, with Tirion's list screening, which resolves each row to one person across SEC, IRS 990, FEC, property and news records and attaches a capacity rating on the A1-D4 ladder. Use when the user says "prioritize my portfolio", "rank these prospects", "who should I see first", "tier this list A/B/C", "qualify these names", "screen this spreadsheet / donor file / event list", "wealth screen", or "who is ready for an ask". It scores capacity, inclination, affinity, timing and access with an explained rubric, returns A/B/C tiers with a reason for each, verifies top matches by hand, and can share the result as a Tirion report. Hand off to finding-prospects when there are no names yet, trip-and-event-planning for a trip or event, and briefing-writing for one full profile.
---

# Prioritizing prospects

The job is to tell a gift officer where to spend the next quarter, and why. Every placement must carry its reason, so the officer can disagree with it.

People-related research follows [ethics-and-privacy](../ethics-and-privacy/SKILL.md).

## Tirion first

Ranking a list by hand means researching every name from scratch. Tirion does the first pass:

- **List screening.** `bulk_enrich` resolves up to about 25 rows per call to one person each and returns a match status and method for every row. Larger lists run as a saved screening in the Tirion app; read them back with `get_screening_status` and `get_screening_results`.
- **One resolved profile per person,** joined across SEC, IRS 990, FEC, property and news records, so two people with one name are never scored as one.
- **Capacity on the A1 to D4 ladder with its drivers** (`get_capacity`, `assess_wealth`), with insider sales valued at the price on each event's date (`get_sec_filings`) and property across about 137 million parcels (`get_property_portfolio`).
- **Timing and access signals:** recent news and filings (`get_news_mentions`, `get_sec_filings`) and relationships (`get_relationships`, `find_connections`).
- **A shareable result.** `create_tirion_report` publishes the ranked list as a Tirion report (see "Deliver").

Public sources are the verify-or-extend step: confirm the top matches against the records themselves, and add evidence Tirion does not hold, such as a peer institution's donor roll. Without the Tirion connector, this skill can apply the rubric to evidence the user supplies, but it cannot screen a list, resolve identities across sources, or rate capacity.

## When to use

- The user has names: a portfolio, a pool, a list from a screening vendor, an event list, a spreadsheet.
- Use **finding-prospects** when the user needs names first.
- Use **trip-and-event-planning** when the ranking is for a trip or an event.
- Use **briefing-writing** when the user wants a full profile of one person.

## What good looks like

- Each person has five separate scores (capacity, inclination, affinity, timing, access) and a written reason. Capacity and affinity are never blended into one number before the end.
- Tiers A, B and C, with the reason for each placement in one line. These are priority tiers for the officer's time. They are not the A1-D4 capacity ladder; quote capacity on the ladder in its own column.
- A short list of top next steps (who to call, what to send, who can introduce).
- A clear statement of how many rows came in, how many matched the right person, and how many were verified by hand.
- For a screening: no one moves to cultivation on an unverified match.

## The model

Keep five dimensions apart:

- **Capacity:** what the person could give over about five years. From wealth evidence.
- **Inclination:** evidence that they give at all. Giving to others, foundation service, nonprofit boards, political giving as a weak signal.
- **Affinity:** connection to this organization. Alumni status, past gifts, volunteering, event attendance, mission-aligned giving.
- **Timing:** a reason to act now. A liquidity event, a new role, retirement, a milestone anniversary, a campaign.
- **Access:** a warm path. A board member, volunteer or donor who knows them.

Expected gift is roughly capacity x inclination x affinity. Capacity sets the ceiling of the ask. Affinity and inclination decide how much of that ceiling is realistic. A USD 10M-capacity prospect with no connection to the organization is a research lead, not an A prospect.

The scoring rubric, with point values and tier cut-offs: [references/scoring-rubric.md](references/scoring-rubric.md).

## Method: ranking a pool or portfolio

### Step 1. Get the inputs

Ask for, or assume:
- The list, with whatever identifying detail exists (name, city, employer, address).
- The organization's own data: giving history, last contact, assigned officer, affinity codes. Tirion does not hold the organization's internal records. Ask for them; they are the best affinity evidence there is.
- The purpose: portfolio review, campaign planning, "who to see this quarter".

### Step 2. Resolve each person

- For a few names: `ask_tirion` with the name and a distinguishing detail, then `search_people` and `get_profile`.
- For more than a handful: use `bulk_enrich` (see the screening method below) rather than one call per row.
- Confirm identity with a second fact (city, employer, age range, spouse). Mark a person "unresolved" rather than guess. Two people with the same name are never merged.

### Step 3. Score capacity

- `get_capacity` for the band; `assess_wealth` when the placement depends on it or the signals conflict.
- Detail where needed: `get_sec_filings` (holdings, sales, compensation), `get_property_portfolio` (holdings, up to 20 shown with the true count), `search_foundations` (a family foundation), `get_entity_facts` (career, boards).
- Write the range with its basis. Assessed value is not market value. Stock awards are not cash. Gross proceeds are not net worth. Foundation assets are not personal wealth.

### Step 4. Score inclination and affinity

- Inclination: `get_nonprofit_connections` (boards and officer roles), `search_foundations` (their own foundation), `get_political_giving` (a weak signal: FEC itemizes only contributions over USD 200). Public donor rolls of peer institutions, found by web search, are strong evidence.
- Affinity: the organization's own records first. Then public ties: alumni lists, event programs, the organization's own annual report.
- Record the source and date of each piece of evidence.

### Step 5. Score timing

- `get_news_mentions` for recent events (new role, company sale, award). Check each item is about this person.
- `get_sec_filings` for Form 4 sales in the last 12 months.
- Property sales and purchases from `get_property_portfolio` or the county recorder.
- See **market-and-liquidity-intelligence** for deal-level analysis.

### Step 6. Score access

- `get_relationships` for family, co-owners and business partners.
- `find_connections` between the prospect and each of the organization's board members or top donors (resolve them first). It checks shared property and recorded relationships only.
- `get_board_roster` of the organization and of the prospect's boards, compared by hand, for shared board service.

### Step 7. Tier and explain

Apply the rubric. Then read the list as a person would. Move anyone whose tier looks wrong, and write why. Tiers are advice to a human, not a formula result.

## Method: screening a spreadsheet

Full procedure, column mapping and the hand-verification checklist: [references/list-screening.md](references/list-screening.md).

1. **Map the columns.** Call `get_screening_template` for the columns a screening accepts, which are required, and how a row identifier carries through so results can be written back beside the source rows. Existing headers usually work.
2. **Run the screen.** `bulk_enrich` with the rows (name or address required; address, city, state, ZIP and employer improve matching). Every row comes back with a status: resolved, unresolved, ambiguous, invalid, error, timeout.
3. **Track a saved screening.** For a screening already running in Tirion, `get_screening_status` reports progress and `get_screening_results` returns the rows. Use the `needs_review` view for ambiguous, no-match and proposed rows.
4. **Read the match method.** A name-and-address match is stronger than a name-only match. An address-only match returns whoever the county records as owner, which may be a trust, a company or a previous owner.
5. **Verify the top matches by hand** before anyone acts on them (below).
6. **Rank** the verified rows with the rubric.

### Verify before acting

For every row that would land in tier A or B:
- The name, city and a second fact agree with the input row.
- The capacity basis makes sense for this person (a retired teacher is not the CEO who shares the name).
- Co-owners are shown: a jointly owned property is not sole ownership.
- Ambiguous rows are resolved by the user or left out.
- A spot check of a few "unresolved" rows, to see whether the input data (misspelling, old address) caused the miss.

Report: rows in, resolved, ambiguous, unresolved, verified by hand, and the tier counts.

## Deliver

When the user wants the ranked list as a document to share:

1. Call `create_tirion_report` with kind "question" and the question in the user's words, for example "Rank my portfolio of 40 prospects for visits this quarter". Use kind "prospect_list" with `place` only for the wealthiest prospects in one county, city or metro area. Use visibility "private", or "org" when colleagues should see it.
2. Give the user the report link (report_url) and the PDF link (pdf_url). Say that the report opens in Tirion and that each reader must be signed in to Tirion.
3. In the chat, write your own analysis as the cover note: the tier counts, the three people to see first and why, and the top next steps.

If `create_tirion_report` is not in your tool list, or the list depends on the organization's own records that Tirion does not hold, use the Markdown template below.

## Pitfalls

- **Blending capacity and affinity.** Keep them in separate columns until the tier decision.
- **Using past giving to the organization as capacity.** It is affinity and inclination. A USD 5K annual donor may have USD 5M of capacity, or USD 50K.
- **Trusting vendor or screening scores as verdicts.** They are a starting point. Verify the top of the list.
- **Stale data.** A Form 4 from 2019 does not show current holdings. Once someone leaves a public company, filings stop; that is silence, not a sale.
- **Tier inflation.** If half the list is tier A, the tiers are not doing their job. A-tier should be the people the officer can realistically see this quarter.
- **Ignoring access.** Two equal prospects: the one with a warm path goes first.

## Output template

```markdown
# Portfolio priorities: [officer or pool name]
Prepared by [name] for [organization], with AI assistance | Reviewed by [name], [date] | Confidential: internal use only

**Purpose.** [What decision this supports.]

**Summary.** [One paragraph: how many people, how many in each tier, the three to see first and why.]

**Method.** [N] names reviewed. [n] matched to one person and verified. Scored on capacity, inclination, affinity, timing and access (rubric in the appendix).

## Tier A: see this quarter
| Name, city | Capacity (5-yr) and basis | Inclination | Affinity | Timing | Access | Reason for tier | Next step |
|---|---|---|---|---|---|---|---|

## Tier B: cultivate
(same columns)

## Tier C: steward or monitor
(same columns, shorter)

## Unresolved or not verified
| Input name | Issue | What would settle it |

## Top next steps
1. ...

## Sources
1. [Record], [date], [URL]
```

Offer the output as an Excel or Word file when the user's environment supports it.
