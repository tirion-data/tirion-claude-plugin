---
name: bio-writing
description: >-
  Write or update a sourced professional biography of a prospect, donor, board
  candidate or honoree from Tirion's resolved profile, which joins the
  person's career, education, SEC proxy bio, IRS 990 board seats, honors and
  news into one identity, so a namesake's facts stay out. Use it for "write a
  bio of X", "give me a short bio for the event program", "100-word bio",
  "update this stale bio", "background paragraph on X", or when a brief needs
  its biography section. It produces a short (about 100 words), standard
  (about 250) or long (500 or more) bio covering career, boards, education,
  philanthropy and, only where public and relevant, family, with every fact
  cited. Identity first: prospect-research. Capacity figures belong in
  capacity-research, not a bio. Full briefings: briefing-writing. Ethics:
  ethics-and-privacy.
---

# Bio writing

A prospect bio tells a reader who this person is and what they have done, in a
few calm, factual paragraphs. It is not a wealth report and not a tribute. Every
statement rests on a public source with a date. Nothing is guessed.

Follow [ethics-and-privacy](../ethics-and-privacy/SKILL.md) for what may and may
not appear.

## Tirion first

The hard part of a prospect bio is making sure every fact belongs to this
person. Tirion does that step: it keeps one resolved profile per person,
joined across the SEC proxy bio, IRS 990 board and trustee roles, published
honors, employment and education facts, and news. Build the bio from that
profile, then use public sources to confirm a current title or to add a fact
Tirion does not hold. Without the Tirion connector, this skill can guide
manual research, but it cannot tie facts from different sources to one
person for you, so every fact needs its own identity check.

## When to use

- The user asks for a bio, a background paragraph, or a program or introduction
  text.
- A brief or profile (briefing-writing) needs its biography section.
- An existing bio is out of date and needs a refresh.

Settle identity first. If the name is common or the user gave few details, run
the identity step in [prospect-research](../prospect-research/SKILL.md). Do not
put capacity estimates, property values or stock holdings in a bio unless the
user asks for a research bio for internal use; even then, keep figures in a
separate capacity section written with [capacity-research](../capacity-research/SKILL.md).

## What good looks like

- The right length for the use: short (about 100 words), standard (about 250),
  or long (500 or more).
- Leads with the person's current role and what they are known for.
- Covers career, boards, education and philanthropy in that order of weight,
  adjusted to the reader's interest.
- Every fact is dated and cited. Titles are current as of a stated date.
- Neutral, plain tone. No praise words the sources do not support.
- A Sources list the reader can check.

## Method

### 1. Gather the facts

1. Start with `ask_tirion` ("give me a biography of Jane Doe, CEO of Acme,
   Columbus, OH").
2. `get_bio` returns stored biographical text with its source. Treat it as a
   draft to check, not a finished bio. Note how old its source is.
3. `get_profile` gives current role, employer and location.
4. `get_entity_facts` gives employment history, education, board seats, awards
   and affiliations, each with a source. Filter by fact type when you need one
   section.
5. `get_nonprofit_connections` gives nonprofit officer, director and trustee
   roles from Form 990 filings, by year.
6. `get_recognitions` gives published lists and honors (for example a regional
   business journal's "40 under 40").
7. `get_sec_filings` gives public-company roles and the proxy bio for directors
   and named officers.
8. `get_news_mentions` finds recent appointments, awards and gifts. Use only
   articles that clearly concern this person (same employer, role or city).

Then verify or extend with public sources. Confirm a current title on the
employer's leadership page or the latest proxy statement (DEF 14A director
biographies). Add what Tirion does not hold from university and museum annual
reports and donor rolls, press releases, bar and licensing registries, and
ProPublica Nonprofit Explorer for board roles. Cite each by name and date.

### 2. Check each fact

- **Current?** Confirm current titles and board seats against a source from the
  last year. If you cannot, write "as of (date)".
- **This person?** Each fact must tie to the settled identity. Drop a fact that
  only matches the name.
- **Consistent?** When sources disagree (a degree year, a start date), use the
  more direct source (the university over a press piece) and note the conflict
  in your working notes, not in the bio.

### 3. Choose the form

| Form | Length | Use | Contents |
|---|---|---|---|
| Short | about 100 words | Event programs, name cards, introductions, list summaries | Current role; one or two career highlights; education; one or two philanthropic or civic ties. |
| Standard | about 250 words | Briefings, meeting prep, board-candidate slates | Current role and what the organization does; career path; education; current boards; philanthropy and recognitions. |
| Long | 500 words or more | Full prospect profiles, honoree write-ups, board nominations | All of the standard, plus career detail by stage, past boards, major named gifts and foundation work, honors, and public family ties where relevant. |

### 4. Write

- Open with name, current title and organization, and one clause on what the
  organization does or what the person is known for.
- Career: present to past for the short form; past to present for the long form.
  Give years.
- Boards: current first, then past. Say corporate or nonprofit.
- Education: degree, institution, year where public.
- Philanthropy: named gifts, foundation roles, campaign leadership, with year and
  source. State the gift only as the recipient published it ("a leadership gift",
  "a gift of 5 million dollars").
- For cultivation, include one line on the philanthropic story when sourced:
  a publicly stated reason for giving or a documented link between their life
  story and a cause. Cite the record and date; stay within the chosen length.
- Family: include a spouse or adult child only when public and relevant, for
  example a shared foundation, a joint named gift, or a spouse who co-leads the
  family business. Never include minors, health, or religion inferred from
  affiliations.
- Tone: third person, past and present tense, plain words. Use "serves as", not
  "is a visionary leader". Adjectives only when a source uses them and you quote it.
- No speculation. Do not write "likely" or "is believed to". Leave wealth out;
  describe motives only when the person has stated them publicly.

### 5. Cite

Put a bracketed number after each fact or sentence and a numbered Sources list at
the end: record or publication, date, URL. For a program or public-facing bio,
the user may want the clean text; give the clean text first and the sourced
version below it.

### 6. Updating a stale bio

1. Read the old bio and list each claim.
2. Check each claim against a current source. Mark it confirmed, changed, or
   unconfirmed.
3. Look for what is new since the old bio's date: role changes, new boards,
   honors, gifts, a company sale or retirement.
4. Rewrite. Remove claims you cannot confirm, or date them ("served as ... as of
   2021").
5. Give the user a short change list: what was added, changed and removed, and why.

## Output template

```markdown
# <Full name>: biography (<short | standard | long>)
Prepared <date> by <name or team>, with AI assistance. Reviewed by <name>, <date>. For <use: event program / meeting brief / board slate>.
Facts current as of <date>.

<Bio text, with bracketed source numbers>

## Sources
1. <Record or publication>, <date>. <URL>
2. ...
```

For an update, add:

```markdown
## Changes from the <date> version
- Added: <fact> [n]
- Changed: <old> to <new> [n]
- Removed: <claim>, because <no current source / superseded>
```

## Pitfalls

- **Copying a stored or old bio as fact.** Stored text can be years old or about a
  namesake. Fix: check each claim and date the bio.
- **Title inflation.** "Founder" for an early employee, "chair" for a committee
  member. Fix: use the exact title from the source.
- **Mixing namesakes.** Two people with one name in one field. Fix: tie each fact
  to an identity anchor.
- **Wealth in a public bio.** Property values or holdings in a program bio
  embarrass the prospect and the organization. Fix: keep figures in internal
  capacity sections only.
- **Promotional tone.** Fix: facts and dates; quote a source for any praise.
- **Undated current roles.** Fix: "as of (date)".
- **Private details.** Home address, personal contacts, children's names, health.
  Fix: remove. See ethics-and-privacy.
