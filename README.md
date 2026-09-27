# Tirion for Claude

Wealth intelligence for fundraisers and prospect researchers.

This plugin connects Claude to [Tirion Data](https://tiriondata.com) and teaches it to work like a senior prospect-research analyst. Ask in plain words: "Who in Palm Beach should I see next week?", "How much could this person give?", "Write a briefing for Thursday's dinner." Claude answers with a conclusion, the public records behind it, and a next step.

## What's inside

**The Tirion connector** (`https://mcp.tiriondata.com/mcp`). It gives Claude what only Tirion does:

- one resolved profile per person, joined across SEC, IRS Form 990, FEC, property and news records;
- insider wealth valued at the price on each event's date;
- a capacity rating on the A1-D4 ladder, with the records that drive it;
- property ownership across about 137 million parcels, including trusts and LLCs;
- 990 board seats and foundation grants linked to people;
- liquidity-event and wealth-indicator leads, area wealth, and prospects for a place;
- list screening, relationships and warm paths;
- Tirion reports: Tirion-branded dossiers, prospect lists and area reports hosted on app.tiriondata.com.

Sign in with your Tirion account the first time Claude uses it. The skills use public sources (SEC EDGAR, ProPublica Nonprofit Explorer, county assessors, FEC.gov) to verify or extend what Tirion finds. Without the connector, the skills can guide manual research, but Claude cannot resolve identity across sources, value insider wealth at event dates, or rate capacity.

**Skills.** Claude loads each one when a request needs it.

| Skill | Use it to |
|---|---|
| `prospect-research` | Research one person or organization end to end, with a quality check before anything goes out |
| `capacity-research` | Estimate 3–5 year giving capacity as a range, with the assets behind it |
| `bio-writing` | Write a sourced professional biography (short, standard or long) |
| `briefing-writing` | Write a one-page meeting briefing, a presidential briefing, an in-depth profile (PRP), a capacity evaluation, or an event packet |
| `trip-and-event-planning` | Plan a donor trip itinerary or research an event guest list |
| `finding-prospects` | Find prospects by cause and place, wealth signal, affinity or liquidity event |
| `prioritizing-prospects` | Qualify and tier a pool or portfolio; screen a list |
| `market-and-liquidity-intelligence` | Understand wealth in a place, and act on M&A, IPOs and big stock sales |
| `sec-filing-analysis` | Read Forms 3/4/5, 13D/G, proxies, S-1s and 8-Ks for prospect research |
| `nonprofit-990-analysis` | Read Forms 990 and 990-PF: board roles, grants, foundation assets |
| `property-analysis` | Read real estate records: assessed vs market value, trusts and LLCs, second homes |
| `political-giving-analysis` | Use FEC records as a capacity and affinity signal, with care |
| `ethics-and-privacy` | The research standard every skill follows (Apra Principles of Ethics and Compliance, Donor Bill of Rights) |

**Commands.** Five shortcuts run a skill's method on one argument. Each is a skill, so it loads on every surface.

| Command | Does | Runs |
|---|---|---|
| `/tirion:brief <name>` | One-page pre-meeting briefing, as a Tirion report link plus talking points | `briefing-writing` |
| `/tirion:bio <name>` | Sourced biography (short, standard or long) | `bio-writing` |
| `/tirion:trip <place> <dates>` | Trip plan: who to see, itinerary, visit briefs, Tirion report links | `trip-and-event-planning` |
| `/tirion:find-prospects <cause and/or place>` | Ranked list of new prospects, as a Tirion report link plus a cover note | `finding-prospects` |
| `/tirion:screen` then a pasted list | Screens the names, tiers them A/B/C, flags rows to verify, with a Tirion report link | `prioritizing-prospects` |

How to run them on each surface:

- **Claude Code:** type the command, for example `/tirion:brief Mary Barra, General Motors`.
- **Cowork (Claude Desktop):** type the same command in a Cowork task.
- **Chat (claude.ai web, desktop and mobile):** there is no slash menu for plugin skills. Type the request in words, for example "brief Mary Barra of General Motors", and Claude applies the matching skill.

## What the plugin runs, sends and fetches

- **It runs no code on your machine.** The plugin is Markdown skills plus one connector setting. It has no hooks, scripts or executables.
- **It connects to one service:** the Tirion MCP server at `https://mcp.tiriondata.com/mcp`, over HTTPS, signed in with your Tirion account (OAuth).
- **What it sends to Tirion:** the questions you ask and the names, places, addresses and employers in them; for list screening, the rows you paste (name, address, city, state, ZIP, employer). Each lookup counts against your Tirion account's quota.
- **What it fetches from Tirion:** public-record research results (profiles, filings, 990 roles, property, political giving, news, area statistics, capacity ratings).
- **What it creates:** when you ask for a document to share, `create_tirion_report` saves a report in your Tirion account and returns a link (`report_url`) and a PDF link (`pdf_url`) on `app.tiriondata.com`. The report is private to you, or visible to your organization if you choose "org". Readers must be signed in to Tirion.
- **Public sources:** when Claude verifies a fact, it may use your own web tools, if you have them, to read public pages such as SEC EDGAR or a county assessor's site. The plugin does not add a web tool.

## What Tirion keeps, and for how long

- **Reports** you create with `create_tirion_report` stay in your Tirion account until you delete them.
- **Memories** you confirm (for example "that's the right Jane Doe") expire after 24 months. Proposed memories you never confirm expire after 30 days. Your preferences are kept until you delete them. You can view, edit or delete any memory in Tirion at /ai/memory.
- **Account records** of each connector call (which tool, when, and the lookups it used) are kept for billing, quota and security.

See Tirion's privacy policy: https://tiriondata.com/privacy

## Tools the connector provides

`ask_tirion`, `search_people`, `get_profile`, `get_bio`, `get_capacity`, `assess_wealth`, `get_entity_facts`, `get_recognitions`, `get_news_mentions`, `get_relationships`, `find_connections`, `get_nonprofit_connections`, `search_nonprofits`, `search_board_members`, `get_board_roster`, `search_foundations`, `search_foundations_by_cause`, `get_sec_filings`, `get_political_giving`, `search_political_donors`, `get_fec_committee`, `get_property_portfolio`, `search_properties`, `search_by_address`, `search_parcels`, `get_owner_footprint`, `get_owners_near`, `resolve_place`, `get_area_wealth_summary`, `get_area_prospects`, `discover_prospects`, `list_people_by_indicator`, `enrich_prospect`, `bulk_enrich`, `get_screening_template`, `get_screening_status`, `get_screening_results`, `propose_research`, `get_memory`, `propose_memory`, and `create_tirion_report` (creates a Tirion-hosted report and returns its links).

## Install

Install **Tirion** from the plugin directory in the Claude apps (Customize > Plugins). It is then also available in your Claude Code sessions.

You need a Tirion account. Get one at [tiriondata.com](https://tiriondata.com). The first time Claude uses Tirion, it asks you to sign in.


## Principles

- **Public records, cited.** Every material fact names its record and date, for example "SEC Form 4, filed 2026-08-24".
- **Identity first.** Claude confirms it has the right person before it researches them, and it never merges two people who share a name.
- **Capacity is a range with its reasons.** It is never a bare number.
- **Ethical by default.** No private contact details and no sensitive personal categories. Research follows the Apra Principles of Ethics and Compliance.

## Privacy

Tirion's privacy policy: https://tiriondata.com/privacy

## Support

support@tiriondata.com

## License

Apache 2.0. See [LICENSE](LICENSE).
