---
name: filing-intelligence
description: >-
  Read one SEC or IRS 990 filing with Tirion to find who makes money, how,
  how much and when. Add each person's bio, interests, nonprofit roles and
  stated connections. Use for "analyze this filing", "who makes money from
  this S-1", "who gets paid in this deal", "read this 8-K / proxy / Form 4 /
  13D", "who is in this filing", or an EDGAR link pasted alone. Accept an
  SEC accession number, an EDGAR URL or an IRS 990 object id. Produce a cited
  money table, short profiles and a next step for cultivation. Hand off a
  person's Form 4 history to sec-filing-analysis.
---

# Filing intelligence

Start with one filing. Find who benefits and what each person receives.
Then explain who they are and which stated ties matter for cultivation.
Follow [ethics-and-privacy](../ethics-and-privacy/SKILL.md) throughout.

## Tirion first

Call `analyze_filing(document_key, source="sec")` on the Tirion connector.
It reads one filing for beneficiaries, money, timing and connections.
It also returns Tirion's context for people it resolves to profiles.
The first call can take a minute or two. Tirion generates the result, then
caches it. Allow the call to finish before making another call.

The result is AI-assisted. Check the figures that drive the conclusion
against the filing. Null amounts and dates mean the filing does not disclose
them. They do not mean zero or that an event did not happen.

If the connector is unavailable, the filing is absent, extracted text is
missing, or the service is busy, use the manual fallback in step 2.
Manual reading does not supply Tirion's resolved profiles or missing facts.

## When to use

- The user gives one accession number, EDGAR URL or IRS 990 object id.
- The user asks who makes money from this filing, IPO or deal.
- The user wants the people in a filing, their bios and their connections.

Hand off:
- One person's Form 4 history: `sec-filing-analysis`.
- A capacity estimate: `capacity-research`.
- A full biography: `bio-writing`.
- The full research loop: `prospect-research`.
- Company-level deal views: `market-and-liquidity-intelligence`.
- A deeper read of 990 roles, grants or foundation assets:
  `nonprofit-990-analysis`.
- Research standard: `ethics-and-privacy`.

## What good looks like

- Identify the filing by source, form, filer, date and document key.
- Show each beneficiary's mechanism, amount, timing and evidence.
- Keep realized cash, paper value and contingent payments separate.
- Keep each person separate from trusts, companies and namesakes.
- Give short, sourced profiles with interests, roles and stated connections.
- Say what is unknown and which figures were checked in the original filing.
- Recommend who to contact, when and why. Do not invent an ask amount.

## Method

1. **Identify the filing.** Use the supplied accession number or EDGAR URL
   as `document_key` for SEC filings. Use the IRS 990 object id for IRS
   filings. If the user names only an IPO or deal, identify the relevant
   filing first. Ask which filing if several could answer the question.
   Record the form, filer and filing date. Keep the event date separate.

2. **Call Tirion.** Call `analyze_filing` with `document_key` and
   `source="sec"`, or `source="irs"` for a 990 object id.
   - Check `filing` against the requested document. Keep its `url` as the
     filing link and its `app_url` as the Tirion page link.
   - Read `summary`, `callouts` and `how_to_read` before drawing conclusions.
   - Use `beneficiaries` for money and timing, `connections` for ties stated
     in the filing, and `people` for Tirion's person records.
   - On failure, state the limitation. For SEC filings, read EDGAR manually
     using [sec-filing-analysis](../sec-filing-analysis/SKILL.md): select the
     form's tables, read transaction codes and footnotes, and cite the form,
     filing date and URL. Apply the cash and timing distinctions below.
   - For an IRS filing, use the original 990 and the manual method in
     [nonprofit-990-analysis](../nonprofit-990-analysis/SKILL.md).
     EDGAR does not hold IRS 990 filings.
   - If the original is also unavailable, report the gap. Do not invent
     beneficiaries or amounts.

3. **Read the money by mechanism and timing.** For each beneficiary, read
   `role`, `how`, `description`, `amount_usd`, `amount_text`, `when`,
   `timing` and `evidence` together.
   - Keep `realized`, `scheduled`, `contingent` and `unknown` labels visible.
     A realized award or transfer is not necessarily realized cash.
   - Separate cash received from stock value and amounts subject to future
     conditions. Split cash, stock and earnout parts of deal consideration.
   - Use `amount_text` to preserve ranges, conditions and units. Show null
     amounts or dates as "not disclosed". Do not fill them with estimates.
   - Label any calculation from disclosed figures. Show its inputs and
     source. Keep it separate from amounts reported in the filing.
   - For a mechanism's cash treatment, read
     [references/money-mechanisms.md](references/money-mechanisms.md).
     Keep `other` as described when no listed mechanism fits.

4. **Separate people from their vehicles and trusts.** Name the legal holder
   and the person's stated role. Report ownership disclaimers and limits on
   control. Do not assign all of a trust's or company's assets to one person.
   Do not count the same shares once for the person and again for the vehicle.
   Link beneficiaries to `people` by `entity_id`, not by name alone.
   A null `entity_id` means no resolved Tirion profile. Keep that person
   unresolved unless further evidence settles identity.

5. **Verify the one or two figures that drive the conclusion.** Open the
   original SEC filing on EDGAR. Check the table, footnote or exhibit behind
   each figure. Check shares, price, recipient, date and payment conditions.
   For an IPO, distinguish proposed shares from a priced, completed sale.
   For an IRS result, check the original 990 instead.
   If the filing conflicts with the generated result, use the filing and
   explain the difference. If you cannot open it, mark the figure unverified.

6. **Build each person's context.** Start with the matching `people` entry.
   Use `get_profile`, `get_bio`, `get_relationships` or
   `get_nonprofit_connections` only when more context is needed.
   - Use `display_name`, city, state, employer and title to check identity.
     Check suffixes such as Jr and Sr before joining records.
   - Cite `bio.source_name` and `bio.source_url` for `bio.text`.
     Treat stored bio text as a draft to check against its source.
   - Report nonprofit organization, EIN, title and tax year. Preserve
     `match_basis` and `confidence`. If `match_basis` is `name`, say
     "matched by name only; not confirmed as this person".
   - Describe interests from `kind` and `key`. Use `own_giving_dollars` only
     as recorded, with `first_year` and `last_year`. Do not turn a board's
     grants into the officer's personal gifts.
   - Attribute any `wealth_tier` to Tirion. It is not cash from this filing
     or a disclosed net-worth figure. Missing context stays unknown.

7. **Name only stated connections.** For filing `connections`, preserve
   `a`, `b`, `kind` and `detail`. For Tirion `relationships`, preserve the
   named parties, `entity_type` and `relation`. Label which source states
   each tie. A shared board seat does not prove a friendship or warm access.
   A shared surname does not prove a family relationship.

8. **Translate to a cultivation read.** Recommend who to congratulate or
   contact, when and why. Tie the timing to a verified event or stated
   condition. Use documented interests and connections to explain relevance.
   If payment remains contingent, recommend a follow-up check at the stated
   milestone. Do not invent an ask amount or treat gross proceeds as capacity.
   Recommend contact; do not send a message as part of this read.

## Output format

Keep the money table short. Use one row per person and mechanism where
timing or payment form differs. Name a vehicle in the row when it receives
the money. If no personal payment is disclosed, say so.

```markdown
# Filing intelligence: <filer>, <form>, <filing date>
Confidential: for internal use by <organization> only.
Prepared by <researcher>, with AI assistance. Unreviewed draft.

**Filing:** <document key> | <original filing link> | <Tirion app_url, if returned>
**Read:** <Who benefits, what is cash, and what remains conditional.>

## Who makes money
| Person | How | How much | When | Source |
|---|---|---|---|---|
| <name; vehicle if relevant> | <mechanism; cash or paper> | <gross amount or not disclosed> | <date/period; timing label> | <filing link, table/footnote> |

## People
**<Name>** — <Role, employer and brief sourced bio.>
<Recorded interests and nonprofit roles, with tax years and match limits.>
<Stated connections, with filing or Tirion attribution.>

## What to do next
- <Who to contact, when, why, and any documented path to an introduction.>
- <Which figure was verified; remaining gap and the source needed to settle it.>
```

Repeat the profile in 2–4 lines for each person. Link profile facts to their
sources. Replace the draft label with a named reviewer and date only after
that review occurs. Include material callouts and missing evidence.

## Pitfalls

| Trap | Fix |
|---|---|
| Gross proceeds as net worth | Label gross proceeds. Taxes, costs and other assets remain unknown. |
| Lock-up expiry as cash | It is a scheduled event. A later sale must occur to produce sale proceeds. |
| S-1 selling-stockholder shares as sold | They are proposed before pricing. Pricing alone does not prove a completed sale. |
| Company offering proceeds as a founder's payout | Identify the recipient. Company capital is not personal cash. |
| An award, vesting or option exercise as a sale | Read settlement terms and any separate sale. Keep paper value apart. |
| Name-only 990 matches as confirmed roles | Say "matched by name only" and keep identity unconfirmed. |
| Family or wealth inferred from a name or title | State only what the filing or cited Tirion record supports. |
| Jr/Sr namesakes combined | Check suffix, employer, role and other identity evidence before joining. |
| AI output treated as the filing | Verify the decisive figures in the original. Mark checks you could not complete. |
