---
name: find-prospects
description: >-
  Command: /tirion:find-prospects <cause and/or place>. A ranked list of new
  major-gift prospects for a cause, a place or both, found with Tirion's
  cause, place and wealth-indicator discovery and rated for capacity,
  delivered as a Tirion report link with a cover note. Use when the user
  types /tirion:find-prospects or says "find prospects for <cause> in
  <place>". Runs the finding-prospects method.
argument-hint: "<cause> [in <place>]"
---

# Find prospects

The user asked for prospects for: **$ARGUMENTS**

Follow the [finding-prospects](../finding-prospects/SKILL.md) skill. Follow
[ethics-and-privacy](../ethics-and-privacy/SKILL.md) throughout.

## Steps

1. **Nothing given?** If the text above is empty, ask for a cause, a place,
   or both, and stop.
2. **Read the brief.** Take the cause and the place from the text. If a place
   is given, call `resolve_place`; if it is ambiguous, ask which one. Use a
   capacity floor of USD 25K to USD 100K over five years unless the user gave
   one.
3. **Start broad.** Call `ask_tirion` with the user's words, for example
   "Who are prospects for <cause> in <place>?".
4. **Go deeper by angle.**
   - Cause: `search_foundations_by_cause` with the cause and state, then
     `get_board_roster` for trustees of the strongest matches.
   - Place: `get_area_wealth_summary`, `get_area_prospects`, and
     `discover_prospects` with the place and a wealth or property filter.
   - Timing: `discover_prospects` with SEC filings, and `get_news_mentions`
     for recent deals.
5. **Qualify each person.** Confirm identity (`search_people`), capacity as
   a range (`get_capacity`, or `assess_wealth` for the top names), and
   affinity evidence with its record and date. Say when interest is inferred
   from foundation service rather than a personal gift.
6. **Create the Tirion report.** `create_tirion_report` with kind
   "prospect_list", the question in the user's words, and visibility
   "private".
7. **Reply** with the report link and PDF link (say that it opens in Tirion
   and each reader must be signed in), then a cover note: the three names to
   act on first and why, a short ranked table (name and city, why this
   person, capacity range and basis, affinity, next step), how the list was
   built, and sources.

If `create_tirion_report` is not in your tool list, give the full ranked
table from the finding-prospects template and say that the Tirion report was
not available.
