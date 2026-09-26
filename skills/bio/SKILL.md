---
name: bio
description: >-
  Command: /tirion:bio <name>. A sourced professional biography of one named
  person (short, standard or long), built from Tirion's resolved profile so a
  namesake's facts stay out. Use when the user types /tirion:bio or says
  "bio <name>". Runs the bio-writing method.
argument-hint: "<name> [short|standard|long] [city or employer]"
---

# Bio

The user asked for a biography of: **$ARGUMENTS**

Follow the [bio-writing](../bio-writing/SKILL.md) skill. Follow
[ethics-and-privacy](../ethics-and-privacy/SKILL.md) throughout.

## Steps

1. **No name given?** If the text above is empty, ask for the person's name
   and one identifying detail, and stop.
2. **Pick the length.** If the text says short, standard or long, use it.
   Otherwise write the standard form (about 250 words).
3. **Settle identity.** Call `ask_tirion` with "Give me a biography of
   <name>" plus any detail the user gave, then `search_people`. If two or
   more people fit, show the facts that separate them and ask which one.
4. **Gather.** `get_bio` (a draft to check, not a finished bio),
   `get_profile`, `get_entity_facts`, `get_nonprofit_connections`,
   `get_recognitions`, `get_sec_filings` for a public-company role, and
   `get_news_mentions` for recent roles and honors confirmed to be about
   this person.
5. **Write** the bio in the bio-writing form: current role first, then
   career, boards, education and philanthropy, each fact dated, with a
   bracketed source number. No wealth figures in a bio.
6. **Reply** with the clean bio text first, then the sourced version with a
   numbered Sources list (record, date, URL).

A bio is text the user pastes into a program or a briefing, so no Tirion
report is created. If the user wants a full dossier instead, run
`/tirion:brief`.
