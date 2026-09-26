# Discovery angles: tools, arguments and traps

## (a) Cause and place

| Step | Tool | Use | Check |
|---|---|---|---|
| Find funders | `search_foundations_by_cause` (cause, state, city, limit) | Foundations whose NTEE code or grant descriptions match the cause | Read the matched grant text. City scope needs a two-letter state. A county may fall back to state scope; the result says so |
| Family foundations by surname | `search_foundations` (last_name or person_name, min_assets) | When a family name is already known | A surname match is not proof of family control |
| Foundation detail | `search_nonprofits` (name or EIN) | Assets, revenue, filing year | Assets are the foundation's, not the family's |
| Trustees | `get_board_roster` (organization) | Officers and trustees from Form 990 / 990-PF Part VII | If it returns "did you mean", pick the right organization, do not guess |
| People | `search_people` (name, state, city) then `get_profile` | Confirm identity | Match city and age range to the 990 |
| Capacity | `get_capacity` or `assess_wealth` | Range and basis | A range, not a figure |

**Reading a foundation for affinity (public 990-PF).** The IRS has renumbered the parts of Form 990-PF more than once, so cite the part by its name and the form year, and check the number on the form you are reading.
- Supplementary Information, line 3a: grants paid during the year, with recipient, purpose and amount. Look for a pattern across 3 to 5 years.
- Statements Regarding Activities, the substantial-contributor question, plus Schedule B (public for private foundations): who put money in. A trustee who is also a substantial contributor has personal money in the foundation.
- Officers, directors, trustees and compensation: paid staff officers are not donors.
- Total assets at fair market value (page 1, item I). Private foundations must pay out roughly 5% of assets each year; a small grant budget limits what the foundation can give you.

Always write "interest inferred from [foundation]'s grants to [area], FY[years]" rather than "[person] cares about [cause]".

## (b) Wealth indicator

- `list_people_by_indicator`: needs a supported indicator type (for example BUSINESS_OWNERSHIP). Use `include_capacity=true` to attach a band (caps the list at 50). No row does not mean no signal.
- `discover_prospects`: at least one filter is required. Useful combinations:
  - place + `has_sec_filings=true` (public-company insiders who live there)
  - place + `min_property_value` + `has_board_seats=true` (property wealth plus philanthropic engagement)
  - `employer` + place (employees of a company that just had an exit)
  - `wealth_tier` in ULTRA_HIGH (about $10M+) or VERY_HIGH (about $2M+). This is a search filter on estimated wealth, not the A1-D4 capacity ladder. Report capacity with `get_capacity` or `assess_wealth` on the ladder.
- Results may include organizations; drop them from a people list.

## (c) Place

- `resolve_place` first. If `ambiguous` is true, ask the user which place.
- `get_area_wealth_summary` (up to 5 counties, states or tracts): assessed-value deciles and the wealthiest Census tracts. Use it to set a local capacity floor.
- `get_area_prospects` (county or metro only, where enabled): the default ranking by documented property holdings is reliable; the ranking by major-gift capacity can time out on a large place. It returns verified people and raw county owner names separately. Treat raw owner names as leads, not people.
- `discover_prospects` with city or ZIP for a people list with signals.
- `search_properties` with ZIP and `min_value` for the top residential parcels, then resolve owners. Owner names on county rolls are often last-name-first, and many are trusts or LLCs.

## (d) Affinity network

- Board of the user's own institution and peers: `get_board_roster`.
- Multi-board philanthropists in a state: `search_board_members` (min_boards 3 by default). It groups names across Form 990 filings; two people with the same name can be grouped. Confirm each.
- Around a known donor: `get_relationships` (family, co-owners, business partners), `get_nonprofit_connections` (their boards, then each board's roster).
- Link between two people: `find_connections`. It covers shared property and recorded relationships only. Shared boards: compare rosters yourself. Shared political giving: not compared.
- Employer cohort: `search_political_donors` with `employer` finds people who list that employer on FEC filings. FEC only itemizes contributions over $200; the employer is self-reported and may be old.
- Peer donors: annual reports and donor rolls of peer institutions (web search), then `search_people` to resolve each name. A gift to a peer at a known level is evidence of both capacity and inclination.

## (e) Liquidity events

- Company deal news: `get_news_mentions` on the company. Check whether each item is a confirmed match.
- Insiders at the company: `get_board_roster` on a public company lists directors and officers from SEC insider filings.
- Each insider: `get_sec_filings` for Form 4 sales (code S), option exercises (M), shares withheld for tax (F), gifts (G).
- Full deal analysis: see the market-and-liquidity-intelligence skill.

## Cutting the list

Record counts at each gate. Typical gates, in order:
1. Considered (all names from the angles used).
2. Identity confirmed (one person, not an entity, not a namesake mix).
3. Above the capacity floor.
4. Has affinity evidence (or is kept separately as a research lead).
5. Not a current donor or managed prospect (if the user gave an exclusion list).
6. Top N by capacity x affinity x timing.
