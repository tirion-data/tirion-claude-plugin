---
name: trip-and-event-planning
description: Plan a donor trip or prepare for an event with Tirion, which finds the prospects in a place from area wealth and about 137 million parcels, resolves each guest to one profile across SEC, IRS 990, FEC, property and news records, rates capacity on the A1-D4 ladder, and maps ties between guests. Use when the user says "I'm going to <city> next month, who should I see", "plan a trip to <place>", "build my visit schedule", "who else is near my meeting", "cluster these visits", "we're hosting a dinner, research the guest list", "who is coming to the gala and how do they know each other", "seating plan", or "event briefing packet". Writes an itinerary with a brief and a purpose per visit, or a guest table with introductions and seating, plus Tirion report links. Hands off to briefing-writing for cards, prioritizing-prospects for a large list, and finding-prospects for discovery.
---

# Trip and event planning

A trip plan answers: who should I see, in what order, and what do I want from each meeting. An event plan answers: who is in the room, what do they mean to us, and who should meet whom.

People-related research follows [ethics-and-privacy](../ethics-and-privacy/SKILL.md).

## Tirion first

A trip or guest list needs many people researched fast. Tirion is the default path:

- **Area wealth and prospects for a place.** `resolve_place`, `get_area_wealth_summary` and `get_area_prospects` show where the wealth is and who holds it, from about 137 million parcels, including trusts and LLCs.
- **Cause and liquidity leads in the place** (`search_foundations_by_cause`, `discover_prospects`, `get_news_mentions`).
- **One resolved profile per person,** joined across SEC, IRS 990, FEC, property and news records, with a capacity rating on the A1 to D4 ladder (`assess_wealth`, `get_capacity`).
- **Ties between guests:** relationships and shared property (`get_relationships`, `find_connections`) and board seats (`get_nonprofit_connections`, `get_board_roster`).
- **Guest lists screened in one call** (`bulk_enrich`, about 25 rows at a time).
- **Tirion reports** for the place and for each priority person (`create_tirion_report`, see "Deliver").

Public sources are the verify-or-extend step: confirm a fact a visit depends on, or add one Tirion does not hold. Without the Tirion connector, this skill can structure a trip or event plan from names the user supplies, but it cannot find prospects in a place, resolve identities across sources, or rate capacity.

## When to use

- A gift officer, dean or president is travelling and wants a visit plan.
- The organization hosts an event and wants the guest list researched.
- Use **finding-prospects** when there is no trip, just a need for names.
- Use **prioritizing-prospects** to score a large portfolio before the trip.
- Use **briefing-writing** for one full briefing per guest or per visit.

## What good looks like

**Trip:**
- A day-by-day itinerary, grouped by neighbourhood, with realistic travel between meetings.
- For every visit: who, why now, capacity range with its basis, affinity, the purpose or ask, and a warm path if one exists.
- A short bench of alternates in case meetings fall through.
- Clear separation of current donors (stewardship), qualified prospects (cultivation or ask) and new leads (discovery visits).

**Event:**
- A guest table: who each person is, capacity range, relationship to the organization, and ties to other guests and the host.
- Suggested introductions and seating, each with its reason.
- A packet: summary page plus a short card per priority guest (hand off to briefing-writing).

## Method: trip

### Step 1. Fix the trip

Get: the city or region, dates, the traveller (their seniority sets who they should see), the number of meeting slots (a common default is 3 to 4 per day), and the goal (asks, cultivation, stewardship, discovery). Ask for the traveller's portfolio and current donors in the area; Tirion does not hold the organization's own records.

Resolve the place with `resolve_place`. If it returns several candidates, ask which one. Note the counties the trip can reasonably cover.

### Step 2. Gather candidates

Start with `ask_tirion`: "Who are the strongest major-gift prospects in [place] for [cause]?" Then widen:

- **The user's own portfolio and donors in the area.** Always first. Stewardship visits to current donors are often the most valuable meetings on a trip.
- **Area prospects:** `get_area_prospects` (county or metro, where available) for the largest documented holders; `discover_prospects` with city or ZIP plus property, board or SEC filters.
- **Cause-aligned people in the area:** `search_foundations_by_cause` with state and city, then `get_board_roster` for trustees.
- **Recent events:** `get_news_mentions` and `get_sec_filings` for local executives with recent sales or company exits.
- **Neighbours of confirmed meetings:** `get_owners_near` around an address you already have (up to 500 m) to see who else lives nearby. Owners without a confirmed person link are names from the county roll, not people; do not treat them as prospects without further checks.

See [references/trip-plan-template.md](references/trip-plan-template.md) for the full template and a worked day.

### Step 3. Qualify and rank

For each candidate: confirm identity (`search_people`, `get_profile`), capacity range (`get_capacity` or `assess_wealth`), inclination and affinity (`get_nonprofit_connections`, `search_foundations`), timing (`get_news_mentions`, `get_sec_filings`), and access (`get_relationships`, `find_connections` against the organization's board and donors). Apply the rubric in **prioritizing-prospects**. A candidate with high capacity and no affinity is a discovery visit at most.

### Step 4. Cluster by place and day

- Use the address you have for each person: the organization's records, or the property linked to them. Do not use a private home address in the itinerary unless the organization already holds it and the meeting is at the home by invitation. Default to "meeting location to be agreed".
- Group people by neighbourhood or town. Put the highest-priority meeting in the best slot (often breakfast or lunch) and build the day around it.
- Leave travel time. Leave one flexible slot per day.
- Put current donors and asks early in the trip, so follow-ups can happen before the traveller leaves.

### Step 5. Write the brief per visit

One paragraph each: who they are, why now, capacity range and basis, their interests, relationship to the organization, the purpose of the meeting (thank, update, introduce a project, ask for $X for Y), and one thing to avoid. For a full card, hand off to **briefing-writing**.

### Step 6. Deliver

Itinerary, visit briefs, alternates, and sources. Mark it confidential. Remind the user that the traveller should confirm each meeting through the normal channel (the organization's own contact records or an introduction). Never include private contact details.

When the user wants documents to share, follow "Deliver: Tirion reports" below. The itinerary itself stays a Markdown document from the template: Tirion's report kinds do not cover an itinerary.

## Method: event

### Step 1. Get the list and the purpose

Guest list (with any known details), host(s), the purpose of the event (cultivation dinner, campaign launch, stewardship), the number of tables and the key people to seat (host, speaker, honorees).

### Step 2. Research the guests

- For more than a handful, screen the list: `bulk_enrich` (see **prioritizing-prospects** for the screening method), then verify the priority guests by hand.
- For each priority guest: identity, capacity range, affinity to the organization, recent events, and interests.
- For couples, research both people and show them as a household. Do not merge two people's records.

### Step 3. Map the relationships

- `get_relationships` for each priority guest (family, co-owners, business partners).
- `find_connections` for pairs that matter: each guest with the host, each guest with key board members. It checks shared property and recorded relationships.
- Compare board rosters by hand (`get_nonprofit_connections` per guest, `get_board_roster` for key boards) to find shared board service; `find_connections` does not compare boards.
- Note shared employers, alma maters and causes from `get_entity_facts`.

### Step 4. Suggest introductions and seating

- Seat each priority prospect next to a host, board member or donor with a documented tie or a shared interest.
- Put a peer donor who has given to the project the prospect cares about near the prospect; peer testimony is persuasive.
- Separate people with a known public conflict (litigation between them, competing bidders).
- Give the reason for each suggestion: "Seat A beside B: both trustees of the X Foundation (Form 990, FY2024)."

### Step 5. Build the packet

Summary page (purpose, the five people who matter most tonight and why, introductions to make), guest table, seating suggestions, and one card per priority guest from **briefing-writing**. The packet itself is a Markdown document; add a Tirion report link for each priority guest (below).

## Deliver: Tirion reports

1. **For the place** (a trip): call `create_tirion_report` with kind "area_report" and the question, for example "Major-gift prospects and wealth in Palm Beach, FL for a visit on 2026-11-12 to 2026-11-14".
2. **For each priority person** (a visit or a guest who matters most): call `create_tirion_report` with kind "person_dossier" and that person's entity_id. Only for people whose identity is confirmed.
3. Use visibility "private", or "org" when colleagues should see the reports.
4. Give the user each report link (report_url) and PDF link (pdf_url). Say that the reports open in Tirion and that each reader must be signed in to Tirion.
5. In the chat, write your own analysis as the cover note: the plan, the three meetings or introductions that matter most and why, and what to ask for.

If `create_tirion_report` is not in your tool list, deliver the Markdown documents alone.

## Pitfalls

- **Visiting wealth without affinity.** Fill the trip with people who have some connection. Discovery visits are fine when labelled as such.
- **Ignoring current donors.** Stewardship visits keep gifts renewing. Put them on the trip.
- **Overbooked days.** Four meetings a day is already tight in most cities.
- **Home addresses in circulated documents.** Keep private addresses out of the packet unless the organization already holds them for this purpose.
- **Unverified neighbour lists.** An owner name near an address is a county record, not a confirmed person.
- **Same-name guests.** Event lists often have only a name. Confirm identity before attaching capacity to a guest.
- **Seating by wealth alone.** Seat by relationship and purpose.

## Output template (trip)

```markdown
# Trip plan: [traveller] to [place], [dates]
Prepared by [name] for [organization], with AI assistance | Reviewed by [name], [date] | Confidential: internal use only

**Purpose.** [Goals of the trip.]

**Summary.** [One paragraph: number of meetings, the three most important and why, total pipeline in view.]

## Itinerary
### Day 1: [date], [area]
| Time | Who | Type | Purpose / ask | Capacity (5-yr) | Warm path |
|---|---|---|---|---|---|

### Visit briefs
**[Name], [city].** [One paragraph brief.] Purpose: [ ]. Avoid: [ ].

## Alternates
| Name | Area | Why | Capacity | Status |

## Sources
1. ...
```

## Output template (event)

```markdown
# Guest research: [event], [date]
Prepared by [name] for [organization], with AI assistance | Reviewed by [name], [date] | Confidential: internal use only

**Purpose.** [ ]
**Summary.** [The five guests who matter most and the introductions to make.]

| Guest | Who they are | Capacity (5-yr) | Relationship to us | Ties to other guests / host | Note for the host |
|---|---|---|---|---|---|

## Introductions and seating
| Seat / introduce | With | Reason (source) |

## Sources
```

Offer the plan as a Word or PDF file when the user's environment supports it.
