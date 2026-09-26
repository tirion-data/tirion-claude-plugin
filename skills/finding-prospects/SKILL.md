---
name: finding-prospects
description: Discover new major-gift prospects. Use when the user asks "who should we be talking to", "find donors interested in <cause> in <place>", "who in <city/ZIP> has capacity", "who recently sold stock / bought a big house / sold a company", "find people like our top donors", "who is connected to our board", or "build me a prospect list". It finds candidates by cause and place (foundation grants and trustees), by wealth indicator, by geography, by affinity network and by liquidity event, and returns a ranked table with a "why this person" reason, capacity range, affinity evidence and next step. Hand off to prioritizing-prospects to tier a pool or screen a spreadsheet, trip-and-event-planning for an itinerary, market-and-liquidity-intelligence for a market or deal deep dive, and briefing-writing or prospect-research for one person.
---

# Finding prospects

The job is a short, defensible list of people worth a gift officer's time, each with a reason. A long list with no reasons is not a deliverable.

People-related research follows [ethics-and-privacy](../ethics-and-privacy/SKILL.md).

## When to use

- Discovery: the user does not yet have names.
- Use **prioritizing-prospects** when the user already has a pool, a portfolio or a spreadsheet to rank or screen.
- Use **trip-and-event-planning** when the list is for a trip or an event.
- Use **market-and-liquidity-intelligence** for "what does wealth look like in X" or "who got paid in deal Y" as the main question.
- Use **briefing-writing** when the user wants a full profile of one person.

## What good looks like

- A ranked table of 10 to 25 people (fewer if the evidence is thin), each with a "why this person" reason in one line.
- A capacity range for each person, with the assets behind it, never a bare figure.
- Affinity evidence for each person, with its source and date, and a clear label when affinity is inferred.
- A next step for each person (research further, find a warm path, send a congratulatory note, add to a trip).
- A line at the top: how many people were considered, how the list was cut, and what the list cannot see.

## Method

### Step 1. Pin down the brief

Get four things, and assume sensible defaults if the user does not say:

- **Cause or institution** (what the organization funds). This drives affinity.
- **Place** (state, metro, county, ZIP). Resolve it with `resolve_place` when it is ambiguous ("Springfield", "Portland"); ask which one if it returns several candidates.
- **Capacity floor** (the smallest gift worth a visit). Default: major-gift level for the organization, often USD 25K to USD 100K over five years.
- **Exclusions** (current donors, existing portfolio names). Ask the user for their list if they want managed prospects excluded.

Start with `ask_tirion`, in the user's own words. It often returns a usable first cut and tells you which angle has the most evidence. Then go deeper with the approach below that fits.

### Step 2. Choose the discovery angle

Use one or more. Details, tool arguments and traps for each: [references/discovery-angles.md](references/discovery-angles.md).

**(a) By cause and place.** "Donors interested in access and affordability in Florida."
1. `search_foundations_by_cause` with the cause phrase and state (and city if given). It returns foundations and grantmakers whose NTEE code or grant descriptions match. Read the matched grant descriptions; drop foundations whose match is incidental.
2. `get_board_roster` for each strong foundation, to list trustees and officers (the officer and trustee part of Form 990-PF, or Form 990 Part VII).
3. For each person, confirm identity (`search_people` with name and state), then assess capacity (`get_capacity`, or `assess_wealth` for the fuller basis).
4. Say plainly: **interest is inferred from the person's foundation governance and its grants, not from a personal gift record.** A trustee of a family foundation that funds scholarships is a strong lead; a trustee of a large institutional foundation is a staff-governed board member whose own interest is less certain.

**(b) By wealth indicator.** "Who recently sold stock or bought a large house?"
- `list_people_by_indicator` for a supported indicator type (for example business ownership), with `include_capacity` on to attach a capacity band.
- `discover_prospects` with filters such as `has_sec_filings`, `min_property_value`, `wealth_tier`, `employer` and place.
- An indicator is a signal, not a dollar value. Read the underlying record before you rank on it.

**(c) By place.** "Who in Fairfax County has capacity?"
- `resolve_place` to fix the scope.
- `get_area_prospects` (if available on the account) for the largest documented holders; separate verified people from raw county owner names.
- `discover_prospects` with city or ZIP plus a property-value or wealth-tier filter.
- `get_area_wealth_summary` to know what "wealthy" means in this place before you set the floor. A USD 2M home is top-decile in one county and median in another.

**(d) By affinity network.** Alumni, board networks, peers of existing donors.
- `get_board_roster` for the organization's own board and peer institutions' boards.
- `search_board_members` for people on several nonprofit boards in the state (a philanthropic-engagement signal). It groups names, so confirm each person's identity before use.
- For a known donor: `search_people` to get their profile, then `get_relationships` for co-owners, family and business partners, and `get_nonprofit_connections` for their board seats, whose fellow board members are candidates.
- `find_connections` to check a specific link between two people. It checks shared property and recorded relationships. It does not compare boards or political giving, so check shared boards by reading the rosters.
- Employer-based alumni proxies: `discover_prospects` with `employer`, or `search_political_donors` with `employer` for people who list that employer on FEC filings.

**(e) Liquidity-event leads.** M&A closings, IPOs, large insider sales.
- `get_news_mentions` on a company to find deal news; `discover_prospects` with `has_sec_filings` and a place.
- `get_sec_filings` per person for Form 4 sales and holdings.
- For the deal mechanics (who got paid, when the lock-up ends), hand off to **market-and-liquidity-intelligence**.

### Step 3. Confirm identity for every candidate

Before a person goes on the list:
- One profile per person. Check city, employer and age range against the source that surfaced them.
- When two people share a name, show both with their distinguishing facts, or drop the lead. Never merge them.
- A profile with roles in many states, or careers that cannot belong to one life, is a possible mix of namesakes. Flag it, and do not rank it high.

### Step 4. Estimate capacity as a range

- Use `get_capacity` for a quick band, `assess_wealth` when the ranking depends on it.
- State the assets behind the range: "Form 4 sales of USD 6.2M since 2024; residence assessed at USD 3.1M (2026 roll)".
- Assessed value is not market value. Stock awards are not cash. Gross sale proceeds are not net worth. Foundation assets are not personal wealth.
- When only one kind of evidence exists (for example, one house), say the range is a floor with low confidence.

### Step 5. Rank and cut

Rank by capacity x affinity x timing, and note access (a warm path) as a tiebreaker. Keep capacity and affinity separate: a high-capacity person with no affinity evidence is a research lead, not a top prospect. For a formal score, use the rubric in **prioritizing-prospects**.

Cut the list to what a gift officer can act on. Record the count at each stage: considered, identity confirmed, above the capacity floor, with affinity evidence, shown.

### Step 6. Fill gaps from public sources

When Tirion does not hold a fact that would change the ranking, look it up and cite it:
- Foundation grants and trustees: ProPublica Nonprofit Explorer, IRS Tax Exempt Organization Search (TEOS), the Form 990-PF Supplementary Information part, line 3a (grants paid; the part number varies by form year).
- Stock sales and holdings: SEC EDGAR full-text search, Form 4, DEF 14A beneficial-ownership table.
- Property: the county assessor and recorder sites.
- Gifts to peer institutions: annual reports, donor rolls, press releases.

## Pitfalls

- **Foundation trustee = personal donor.** Not always. Staff-run and bank-trusteed foundations have trustees with no family money in them. Check whether the foundation carries the family name or the person is a founder or substantial contributor (the 990-PF substantial-contributor question and Schedule B show who put money in).
- **Cause match on one grant.** A single grant in a matching area is weak. Look for a pattern across several years of 990-PF grant lists.
- **Unverified news.** Many news matches are name matches that nobody has checked. Confirm the person before crediting a news item.
- **Absent is not zero.** A person with no property in Tirion may still own property. Say "no property found", not "owns no property".
- **Area lists dominated by entities.** County owner lists include LLCs, trusts and companies. Separate people from entities, and do not attribute an LLC's parcel to a person without a filing that links them.
- **High capacity, zero affinity.** Do not put this at the top. Label it a research lead.
- **Current donors in a discovery list.** Ask for the exclusion list, or mark likely current donors so the officer can check.

## Output template

```markdown
# Prospect list: [cause] in [place]
Prepared by [name] for [organization] | [date] | Confidential: internal use only

**Purpose.** [Who this list is for and what decision it supports.]

**Summary.** [One paragraph: the strongest 3 names and why; how the list was built; the main limitation.]

**How this list was built.** Considered [N] people from [angles]. [n1] confirmed as the right person; [n2] above the [$X] capacity floor; [n3] with affinity evidence. Shown: top [n].

| Rank | Name, city | Why this person | Capacity (5-yr) and basis | Affinity evidence | Timing | Warm path | Next step |
|---|---|---|---|---|---|---|---|
| 1 | | | USD 1M-USD 2.4M; Form 4 sales USD 4.8M (2025) [1] | Trustee, X Family Foundation; 990-PF FY2023 grants to college access [2] (inferred interest) | Sold shares 2026-08 [1] | Shares board with our trustee Y [3] | Ask Y for an introduction |

**Research leads (capacity without affinity evidence).** [Short list.]

**Not included and why.** [Namesakes not resolved; entities; existing donors.]

**Sources**
1. SEC Form 4, [issuer], filed [date], [URL]
2. IRS Form 990-PF, [foundation], FY[year], Supplementary Information (grants paid), [URL]
3. ...
```

Offer the list as a Word or Excel file when the user's environment supports it.
