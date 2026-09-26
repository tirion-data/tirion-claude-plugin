---
name: prioritizing-prospects
description: Qualify, rank and tier a pool of prospects or a gift officer's portfolio, or screen a spreadsheet of names. Use when the user says "prioritize my portfolio", "rank these prospects", "who should I see first", "tier this list A/B/C", "qualify these names", "screen this spreadsheet / donor file / event list", "wealth screen", "which of these people have capacity", or "who is ready for an ask". It scores each person on capacity, inclination, timing and access with an explained rubric, returns A/B/C tiers with a reason for each placement and the top next steps, and for a spreadsheet runs a Tirion screening and then verifies the top matches by hand before anyone acts. Hand off to finding-prospects when the user has no names yet, to trip-and-event-planning when the ranked list feeds a trip or event, and to briefing-writing for a full profile of a top prospect.
---

# Prioritizing prospects

The job is to tell a gift officer where to spend the next quarter, and why. Every placement must carry its reason, so the officer can disagree with it.

People-related research follows [ethics-and-privacy](../ethics-and-privacy/SKILL.md).

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
Prepared by [name] for [organization] | [date] | Confidential: internal use only

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
