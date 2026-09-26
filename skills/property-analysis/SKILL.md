---
name: property-analysis
description: >-
  Analyze a prospect's real estate with Tirion, which links property across
  about 137 million parcels to resolved people, including homes held in
  trusts and LLCs, and rolls up an owner's holdings by county and state. Use
  when the user asks "what does X own", "does X have a second home",
  "who owns <address>", "what is X's house worth", "did X buy or sell a home
  recently", "who are the property owners near <place>", or wants a
  portfolio, sale history, LLC or trust ownership explained. Produces a cited
  property section: each holding with its assessed value, the market-value
  adjustment and why, how ownership was confirmed, recent purchases or sales,
  and what the portfolio means as a capacity floor. Shows city, not street
  address unless allowed. Hands off to sec-filing-analysis,
  nonprofit-990-analysis, political-giving-analysis, capacity-research,
  prospect-research and ethics-and-privacy.
---

# Property analysis

Real estate is the most common public wealth signal. It is also the easiest
to misread. The county records a value set by its own rules, in the name of
whoever holds title, which may be a trust or an LLC. Your job is to find what
the prospect's household owns, value it honestly, and say what it means.

## Tirion first

Finding a person's property by hand means searching one county at a time
and guessing which trust or LLC is theirs. Tirion does that across about 137
million parcels:

- `get_property_portfolio` returns the parcels linked to the person, with
  the county's value and assessment year and the true count when there are
  more than 20.
- `get_owner_footprint` rolls up an owner's confirmed parcels by county and
  state, so second homes in other states show up.
- `search_properties`, `search_by_address`, `search_parcels` and
  `get_owners_near` search by owner, address, value or place.
- Ownership links run through trusts, LLCs and co-owners, and each parcel
  sits on the same resolved profile as the person's SEC, 990 and FEC
  records.

The county assessor and recorder are the verify-or-extend step: confirm a
holding that drives capacity, read the sale history and mortgages, and
check a county Tirion does not cover. Without the Tirion connector, this
skill can guide a county-by-county search, but it cannot find a person's
property across counties, link trust and LLC holdings to them, or rate
capacity.

## When to use

- The user asks what a person owns, or who owns an address.
- A capacity estimate needs its real-estate component.
- The user is planning a visit and wants owners in an area.
- A recent purchase or sale may be a life event (a move, a downsizing, an
  estate sale, a second home).

Hand off:
- Stock, insider and deal records: `sec-filing-analysis`.
- Foundations and boards: `nonprofit-990-analysis`.
- FEC records: `political-giving-analysis`.
- A capacity rating: `capacity-research`. The full research loop:
  `prospect-research`. A written brief: `briefing-writing`. This skill
  supplies the property section.
- Research standard: `ethics-and-privacy`.

## What good looks like

- Each holding with city and state (street address only if the user's policy
  allows), property type, assessed value, assessment year, the county, and
  the owner of record as the county wrote it.
- For each value, the adjustment from assessed to estimated market value and
  its basis (assessment ratio, homestead cap, a recent sale price).
- How each holding was tied to the prospect: name match plus at least one
  link.
- Recent purchases and sales with dates and prices, read as life or liquidity
  events.
- A portfolio reading: primary home, second homes, investment or commercial
  property, land, and what the total says as a capacity floor.
- Every fact cited: "Palm Beach County Property Appraiser, 2026 roll".

## Method

1. **Ask Tirion first.** Call `ask_tirion` with the question in the user's
   words ("What real estate does Jane Q. Doe of Naples, FL own?").

2. **Fix the identity.** Use `search_people` with name and state, then
   `get_profile`. Note the home city, employer and spouse if known. You need
   these to confirm ownership later.

3. **Pull the portfolio.** Call `get_property_portfolio`. It returns up to 20
   properties with address, county value, assessment year, land-use code and
   the owner name as the assessor wrote it. If the response says the person
   holds more than 20, say so and report the full count. Values from
   different counties are computed differently and are not directly
   comparable; the tool says which. An empty list means no property was found in
   the records searched, not that the person owns none.

4. **Look for what the portfolio missed.** Tirion links trusts, LLCs and
   co-owners where a record ties them to the person. For names it has not
   linked, search each:
   - `search_properties` with `owner_name` in county order, last name first
     ("Doe Jane", "Doe Family Trust", "Doe John & Jane"), and a state or
     county.
   - Trust names: "Jane Q. Doe Revocable Trust", "Doe Living Trust", "Jane Q.
     Doe, Trustee". A revocable trust named for the prospect is the
     prospect's property in substance.
   - LLCs: an LLC with a family name, an address name ("123 Ocean LLC") or a
     mailing address that matches the prospect. Check the state's business
     registry for the LLC's manager or registered agent.
   - `get_owner_footprint` gives every confirmed parcel for an owner with a
     county and state rollup, when it is available.
   - `get_relationships` returns co-owners and family members already linked
     to the person. A spouse on the deed is a household link.

5. **Confirm each holding belongs to the prospect.** A name match is not
   enough. Require one of:
   - The tax-bill mailing address is the prospect's known home or office.
   - The spouse is a co-owner.
   - The trust is named for the prospect or spouse.
   - Tenancy by the entirety (a form of joint ownership only for married
     couples, available only in some states; check the state) with a matching spouse.
   - The LLC's manager or agent is the prospect, per the state registry.
   - A deed, news story or proxy bio names the property.
   Common names in a large county will produce namesakes. If the link is
   missing, list the property as "possible, unconfirmed" and say what would
   confirm it.

6. **Look up an address.** To answer "who owns this address", call
   `search_by_address` with a state or ZIP. It returns the owner the county
   recorded and the matched person if there is one. The recorded owner may be
   a trust, a company or a prior owner if the sale is recent. A timeout means
   the search failed, not that nobody owns it.

7. **Convert assessed value to a market estimate.** Assessed value is not
   market value. For each property:
   - Find the state's assessment basis and any cap. See
     [references/state-assessment-notes.md](references/state-assessment-notes.md).
   - If a recent arm's-length sale price exists (from the recorder or the
     assessor's sales page), it is the best market evidence. Say its date.
   - Otherwise adjust by the county's published assessment ratio or "just
     value" and say so. Florida (Save Our Homes) and California (Prop 13)
     caps can make a long-held home's assessed value a fraction of market.
     Name the cap when it applies.
   - Give a range, not a point: "assessed USD 1.2M (2026); likely market USD 2.5M
     to USD 3.5M given Prop 13 and a 1998 purchase".
   Rules change. Check the county assessor's own site before relying on a
   ratio or cap.

8. **Read the sale history.** On the assessor or recorder site, look at the
   last transfer: date, price and document type.
   - A recent purchase of a second home or a larger home: capacity and a new
     local connection.
   - A sale of a long-held home: a liquidity event, possibly a move or
     downsizing.
   - A transfer to a trust for USD 0 or USD 10: estate planning, not a sale.
   - A transfer from an estate: an inheritance or a death in the family.
     Treat with care.
   - A quitclaim between spouses: may be a divorce. Do not speculate; report
     the recorded fact only if it matters.

9. **Read mortgages and liens if recorded.** The recorder's index shows
   recorded mortgages (amount, lender, date) and liens. A large mortgage
   lowers equity. A home with no recorded mortgage suggests it was paid for
   or paid off. A tax lien or judgment is a caution. Many counties do not put
   these online; say when you could not check.

10. **Classify the portfolio.** Primary residence; second and vacation homes
    (a strong capacity signal, and a location for a visit); rental and
    investment property; commercial property (often through LLCs, with value
    in the income, not the assessment); land and farms (farmland is often
    assessed on "current use" or agricultural value, far below market; say
    so).

11. **Find owners near a place.** For trip planning or neighborhood work:
    `resolve_place` turns a place name into a scope; `search_parcels` lists
    parcels in a radius (up to 500 meters), a drawn shape or a county;
    `get_owners_near` lists distinct owners around a point, marking which
    names are matched to a person and which are only a name the county
    recorded; `search_properties` filters by city, ZIP and value. Treat an
    unmatched owner name as a lead, not a person.

12. **State the reading.** Total estimated market value as a range, how much
    is primary home versus other property, whether the total is complete, and
    what the property means for capacity. Property is a floor. It is
    illiquid, often mortgaged, and shows little about liquid wealth. Hand the
    total to the capacity step rather than converting it here.

## Pitfalls

| Trap | Fix |
|---|---|
| Treating assessed value as market value | Adjust by the state and county basis and name the cap. Give a range. |
| Comparing values across counties as if equal | Say each county's basis. Convert each to a market estimate first. |
| Attaching a namesake's property | Require a link: mailing address, spouse, trust name, registry. |
| Missing trust- and LLC-held property | Search trust and LLC name patterns and the prospect's mailing address. |
| Reading a USD 10 transfer as a sale price | Transfers to trusts and between family are nominal. |
| Treating the first 20 properties as the whole portfolio | Report the full count the tool gives. |
| Counting an empty result as "owns nothing" | Say no property was found in the records searched. |
| Reading farm or conservation land at its assessed value | Use-value assessment is far below market. Say so. |
| Publishing a home address in a shared document | Use the city unless the user's policy allows addresses. |
| Converting property straight to a gift amount | Property is a floor. Pass it to the capacity step with its caveats. |

## Output template

```markdown
# Property findings: <Full Name>
Prepared by <name>, with AI assistance. Reviewed by <name>, <date>. Purpose: real-estate section of a prospect review.

**Summary.** <2-4 sentences: number of properties, total likely market value
as a range, primary and second homes by city, any recent purchase or sale,
and what it means as a capacity floor.>

| # | Location (city, state) | Type | Owner of record | Assessed (year) | Likely market | Basis for adjustment | How confirmed |
|---|---|---|---|---|---|---|---|

## Recent transactions
| Date | Location | Event | Price | Reading |
|---|---|---|---|---|

## Reading
<Primary vs other property; completeness; mortgages if recorded; what it
means for capacity and for a visit.>

## Unknowns
<Unconfirmed holdings, counties not checked, mortgages not online.>

## Sources
1. <County> Property Appraiser, <year> roll. <URL>
2. <County> Recorder, deed recorded <date>. <URL>
```

Offer a Word or PDF version when the environment supports it.

Research only public records. Do not include a home street address in a
shared document unless the user's policy allows it. Follow `ethics-and-privacy`.
