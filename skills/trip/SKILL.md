---
name: trip
description: >-
  Command: /tirion:trip <place> <dates>. A donor-trip plan for a place and
  dates: Tirion finds the prospects there from area wealth and property
  records, rates capacity, and returns an itinerary, visit briefs and Tirion
  report links. Use when the user types /tirion:trip or says "trip <place>
  <dates>". Runs the trip-and-event-planning method.
argument-hint: "<place> <dates> [cause or goal]"
---

# Trip

The user asked for a trip plan for: **$ARGUMENTS**

Read the place and the dates from that text. Follow the
[trip-and-event-planning](../trip-and-event-planning/SKILL.md) skill (the trip
method). Follow [ethics-and-privacy](../ethics-and-privacy/SKILL.md)
throughout.

## Steps

1. **Missing place or dates?** Ask for them, and stop. Also ask, once, for
   the traveller's current donors and portfolio names in the area; if the
   user has none to hand, go on without them and say so.
2. **Fix the place.** Call `resolve_place`. If it returns several
   candidates, ask which one.
3. **Find candidates.** `ask_tirion` with "Who are the strongest major-gift
   prospects in <place>?"; `get_area_wealth_summary` for what wealth means
   there; `get_area_prospects` and `discover_prospects` for the largest
   holders; `search_foundations_by_cause` for the organization's cause in
   that state and city; `get_news_mentions` and `get_sec_filings` for
   recent liquidity events.
4. **Qualify.** For each candidate, confirm identity (`search_people`,
   `get_profile`), capacity (`assess_wealth` or `get_capacity`), affinity
   (`get_nonprofit_connections`) and access (`get_relationships`). Drop
   anyone whose identity is not confirmed.
5. **Plan the days.** Three to four meetings a day, grouped by area, the most
   important meeting in the best slot, one flexible slot a day. Use "meeting
   location to be agreed", not a home address.
6. **Create Tirion reports.** `create_tirion_report` with kind
   "area_report" and the question "Major-gift prospects in <place> for a
   visit on <dates>", and kind "person_dossier" for each of the top three
   visits. Visibility "private".
7. **Reply** with the report links and PDF links (say that they open in
   Tirion and each reader must be signed in), then the itinerary in Markdown
   from [the trip template](../trip-and-event-planning/references/trip-plan-template.md),
   a one-paragraph brief per visit, alternates, and sources.

If `create_tirion_report` is not in your tool list, deliver the Markdown
itinerary alone and say that the Tirion reports were not available.
