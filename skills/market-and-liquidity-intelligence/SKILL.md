---
name: market-and-liquidity-intelligence
description: Understand a wealth market or a moment of new money. Use when the user asks "what does wealth look like in <place>", "compare these counties / ZIPs", "who are the wealthy families and foundations in <city>", "company X was acquired / went public, who got paid", "when does the lock-up end", "which insiders sold stock", "monitor news on <person, company or topic>", or "is this article about our prospect". It covers area wealth with cited public statistics (IRS Statistics of Income by ZIP, Census ACS), liquidity events (M&A, IPOs, insider sales) with who was paid and when, and news checks for identity. After a liquidity event it recommends a congratulatory contact, not an ask. Hand off to finding-prospects or prioritizing-prospects for people lists, sec-filing-analysis for one person's filings, trip-and-event-planning for visits, and briefing-writing for a profile.
---

# Market and liquidity intelligence

Two questions: what does wealth look like here, and who just received new money. Both lead to a short action list, not a data tour.

People-related research follows [ethics-and-privacy](../ethics-and-privacy/SKILL.md).

## When to use

- **Area wealth:** a territory review, a new regional office, a campaign feasibility question, a trip that needs context.
- **Liquidity events:** a local company is acquired or goes public; a large insider sale; a family business sale.
- **News monitoring:** checking recent news on a prospect, a company or a topic, and deciding whether each item is about the right person.
- Use **finding-prospects** to turn the result into a list of people, and **prioritizing-prospects** to rank it.

## What good looks like

- Conclusion first: "Wealth in [place] is concentrated in [tracts / towns], driven by [industries]; the largest recent liquidity event is [deal, date]."
- Every statistic carries its source and vintage (IRS SOI ZIP data, tax year 2022; ACS 5-year 2019-2023).
- For a deal: who was paid, roughly how much (a range, gross, before tax), when the cash arrives or the shares unlock, and the source filing.
- For news: each item labelled as confirmed about this person, or not confirmed, with the reason.
- A recommended next step: the right contact at the right time.

## Method A: area wealth

### Step 1. Fix the place

`resolve_place` with the user's phrase. If ambiguous, ask. Record the county FIPS codes or tracts for comparison.

### Step 2. Tirion's view

- `ask_tirion`: "What does wealth look like in [place]?" for a first summary.
- `get_area_wealth_summary` for up to five counties, states or Census tracts: assessed-value deciles (p10 to p90) and the wealthiest tracts. Say that these are assessed values, which differ from market values by county.
- `get_area_prospects` (county or metro, where available) for the largest documented property holders. Separate verified people from raw county owner names.
- `discover_prospects` with the place and filters (SEC filings, board seats, property value) for the profile of wealth: executive, property, philanthropic.
- `search_nonprofits` with state and asset filters, and `search_foundations_by_cause` with the place, for the largest foundations and what they fund.
- `search_board_members` with the state for the most connected philanthropists.

### Step 3. Public statistics

Fill in context from public sources and cite each with its vintage. See [references/public-statistics.md](references/public-statistics.md) for which table answers which question.
- **IRS Statistics of Income (SOI), individual income tax ZIP code data:** returns by adjusted gross income (AGI) size class, including the USD 200,000-and-over class; dividends, capital gains and charitable deductions by ZIP. Published with about a two-to-three-year lag.
- **Census American Community Survey (ACS) 5-year estimates:** median household income, median home value, educational attainment, by county, tract and ZIP Code Tabulation Area.
- **Top employers and industries:** state labour department and county economic-development office lists; Census County Business Patterns.
- **Notable families and foundations:** local business-journal lists, foundation annual reports, 990-PF filings via ProPublica Nonprofit Explorer.

### Step 4. Write the market brief

Lead with the conclusion. Then: where the wealth is, what drives it, who the major foundations and philanthropic families are, recent liquidity events, and what this means for the organization (territory priority, a campaign target, a trip).

## Method B: liquidity events

Full filing guide with form names, sections and codes: [references/liquidity-events.md](references/liquidity-events.md).

### Step 1. Identify the event

`get_news_mentions` on the company, or `ask_tirion` ("recent acquisitions of companies based in [place]"). Establish: the type (merger, acquisition, IPO, secondary offering, tender, private sale), the announcement date, the closing date, and the price and form of consideration (cash, stock, mix).

### Step 2. Find who got paid

- **Public target acquired:** the merger proxy (DEFM14A) or the tender-offer recommendation (Schedule 14D-9) lists the directors' and officers' holdings and what they receive, including the "golden parachute" compensation table. The latest annual proxy (DEF 14A) beneficial-ownership table lists holders of 5% or more.
- **IPO:** the S-1 (and final 424(b) prospectus) "Principal and Selling Stockholders" section lists pre-IPO holders and who sold shares in the offering.
- **Insider sales:** Form 4 (transaction code S for open-market sales), Form 144 (notice of a proposed sale by an affiliate).
- **Private company sold:** often no public price. The acquirer's 8-K or 10-Q may disclose the price if material. Press releases and business journals name founders. Do not guess ownership percentages.
- Use `get_board_roster` on a public company for its insiders, then `get_sec_filings` per person for holdings and transactions, and `search_people` to confirm identity and home place.

### Step 3. Size it honestly

- Holdings x deal price per share = gross value. It is before tax, before any debt, and may be partly in acquirer stock.
- Unvested awards may accelerate or roll over. Say which, from the proxy.
- Stock received in the acquirer is not cash, and may be subject to a lock-up.
- Express the result as a range: "roughly USD 8M to USD 12M gross, before tax, from 410,000 shares at USD 24.50 (DEFM14A, filed 2026-04-10)".

### Step 4. Timing

- Closing date: 8-K Item 2.01 (completion of acquisition).
- IPO lock-up: usually 180 days after the offering (stated in the S-1 "Shares Eligible for Future Sale" and "Underwriting" sections); early-release provisions vary.
- Earn-outs and escrows delay part of the payment; check the merger agreement summary.

### Step 5. Recommend the contact

After a liquidity event the right first contact is congratulatory: a note or call acknowledging the milestone, not an ask. Cultivation follows. Timing the ask to tax planning (the donor's advisors often look at charitable giving in the same tax year as a large gain) is a conversation for the gift officer and planned-giving staff, not a research conclusion.

## Method C: news and topic monitoring

1. `get_news_mentions` for the person or company. Results lead with confirmed matches, then recency.
2. For each item, check the identity: does the article name the employer, city, title or family member that matches the person? An item matched on name alone may be about someone else. Many matches are about the organization the person leads, not the person.
3. Label each item: **confirmed** (with the matching facts), **likely** (one matching fact), or **not confirmed**. Only confirmed items go into a briefing as facts.
4. Supplement with a web search for recent months. Cite outlet and date.
5. For topics ("new foundations in Ohio", "tech exits in Austin"), start with `ask_tirion`, then search news and filings.

## Pitfalls

- **Assessed value as market value.** Assessment ratios differ by county and state (California's Proposition 13 keeps assessments near purchase price; Florida's homestead cap limits annual increases). Compare counties with care.
- **Old statistics as current.** IRS SOI ZIP data runs about two to three years behind. ACS 5-year estimates cover a five-year window. State the vintage.
- **Gross proceeds as wealth.** Sale proceeds are before tax. Stock awards are not cash. Unvested equity may never vest.
- **Filing silence as a sale.** Once a person leaves a public company or drops below reporting thresholds, filings stop. Holdings may still exist.
- **Name-matched news.** Confirm identity for every news item before you rely on it.
- **Asking too soon.** A congratulatory note first. An ask weeks after a sale, uninvited, can close the door.

## Output template (liquidity event brief)

```markdown
# Liquidity event: [company], [event type], [date]
Prepared by [name] for [organization] | [date] | Confidential: internal use only

**Purpose.** [Why this matters to us.]

**Summary.** [Deal in one sentence with price and closing date. Who among our constituents or prospects benefits, with gross ranges. Recommended action.]

## The deal
| Item | Detail | Source |
|---|---|---|
| Acquirer / target | | |
| Price and consideration | | |
| Announced / closed | | |
| Lock-up or earn-out | | |

## Who got paid
| Person | Role | Shares or interest | Gross value (range) | Timing | Connection to us | Source |
|---|---|---|---|---|---|---|

## Recommended next steps
1. [Congratulatory note from X to Y by date]
2. ...

## Sources
1. [Filing, filer, date filed, URL]
```

Use the same header, summary and sources structure for a market brief. Offer the brief as a Word or PDF file when the user's environment supports it.
