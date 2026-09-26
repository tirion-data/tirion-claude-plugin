---
name: brief
description: >-
  Command: /tirion:brief <name>. A one-page pre-meeting briefing on one named
  person, built from Tirion's resolved profile and capacity rating, delivered
  as a Tirion report link plus talking points. Use when the user types
  /tirion:brief or says "brief <name>" or "brief me on <name>". Runs the
  briefing-writing method.
argument-hint: "<name> [city, employer, meeting date]"
---

# Brief

The user asked for a one-page briefing on: **$ARGUMENTS**

Follow the [briefing-writing](../briefing-writing/SKILL.md) skill for a
one-page pre-meeting briefing. Follow
[ethics-and-privacy](../ethics-and-privacy/SKILL.md) throughout.

## Steps

1. **No name given?** If the text above is empty, ask for the person's name
   and one detail that identifies them (city, employer or organization), and
   stop.
2. **Settle identity.** Call `ask_tirion` with "Who is <name>?" plus any detail
   the user gave. Then call `search_people` with the name and a state or city.
   If two or more people fit, show the facts that separate them and ask which
   one. Do not go on until one person is confirmed.
3. **Research at one-page depth.** `get_profile` and `get_bio` for role and
   background; `assess_wealth` for the capacity rating and its drivers;
   `get_sec_filings` for insider sales and gifts valued at the event date;
   `get_nonprofit_connections` for boards and causes; `get_news_mentions`
   for the last 12 months (use only articles confirmed to be about this
   person); `get_relationships` for warm paths.
4. **Create the Tirion report.** Call `create_tirion_report` with kind
   "person_dossier", the person's entity_id, a title such as "Briefing:
   <name>", and visibility "private".
5. **Reply in this order:**
   - The report link (report_url) and PDF link (pdf_url), with one line: "The
     report opens in Tirion; each reader must be signed in to Tirion."
   - A summary of four or five sentences: who they are, capacity as a range
     with its main driver, their main interests, and the recommended next
     step.
   - Three talking points and one topic to avoid.
   - Sources: each material fact's record and date.

If `create_tirion_report` is not in your tool list, write the one-page
briefing in Markdown from
[references/one-page-briefing.md](../briefing-writing/references/one-page-briefing.md)
instead, and say that the Tirion report was not available. Never describe
Tirion's internals, and never give private contact details.
