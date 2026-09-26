---
name: sec-filing-analysis
description: >-
  Read SEC filings about a prospect and turn them into capacity, liquidity and
  timing intelligence. Use when the user asks "did X sell stock", "what does X
  own in <company>", "read X's Form 4s", "what is X paid", "is X a 5% holder",
  "what happens to X when the IPO or acquisition closes", "check the proxy", or
  wants insider sales, awards, gifts of stock, 13D/13G stakes, proxy
  compensation, S-1 selling stockholders, 8-K deal or officer news, Form 144
  notices or Form D raises explained. Produces dated, cited findings: what the
  person holds, what they sold or were given, what it was worth on the event
  date, and what it means for an ask. Hands off to property-analysis,
  nonprofit-990-analysis and political-giving-analysis for other records, to
  capacity-research for a capacity rating, to prospect-research for the full
  research loop, and to ethics-and-privacy for the research standard.
---

# SEC filing analysis

SEC filings are the strongest public evidence of wealth for a public-company
insider. They are legally required, dated and priced. They also cover only a
narrow group: officers, directors and 10%+ holders of public companies, plus
people named in deal documents. Read them for three things: what the person
holds, what changed, and when the next liquidity moment is.

## When to use

- The prospect is, or was, an officer, director or large holder of a public
  company.
- The user asks about a stock sale, an award, a gift of stock, an IPO, an
  acquisition, or a new role at a public company.
- A company the prospect founded or runs raised money (Form D) or is being
  bought (8-K Item 2.01, merger proxy).

Hand off:
- Real estate: `property-analysis`.
- Foundation, 990 board roles, grants: `nonprofit-990-analysis`.
- FEC records: `political-giving-analysis`.
- A capacity rating: `capacity-research`. The full research loop:
  `prospect-research`. A written brief: `briefing-writing`. This skill
  supplies the SEC section of that work.
- A company-level event (who got paid in an acquisition or IPO, a market
  view): `market-and-liquidity-intelligence`.
- Research standard: `ethics-and-privacy`.

## What good looks like

- Identity settled first: the filer is the prospect (same CIK, same company
  role, same city in the filing header).
- A holdings line: shares held directly and indirectly, as of the latest
  Form 4 or proxy, with the date and the value at a stated price.
- A transactions table: date, code, shares, price, value, direct or indirect,
  10b5-1 or not, each with its filing date.
- Liquidity read: cash actually realized (sales) kept apart from paper value
  (awards, unvested stock, options).
- A timing read: the next event that could free cash (lock-up expiry, deal
  close, vesting date, a Form 144 notice).
- Every fact cited: "SEC Form 4, filed 2026-08-24", with the EDGAR link.

## Method

1. **Ask Tirion first.** Call `ask_tirion` with the user's question in their
   words (for example "Has Jane Q. Doe of Acme sold stock this year?"). It
   returns a sourced summary and often settles the easy case.

2. **Fix the identity.** Use `search_people` with name and state to get the
   person, then `get_profile` to check employer and city. On EDGAR the filer's
   CIK (Central Index Key, the SEC's permanent ID for a filer) is the anchor.
   Two people with the same name have different CIKs. Confirm with a link: the
   issuer named in the filing is the prospect's employer, or the address in the
   filing header matches the prospect's city. If two candidates remain, show
   both and ask.

3. **Pull the insider record.** Call `get_sec_filings` for the person. It
   returns proxy compensation, holdings, company positions and insider
   transactions from DEF 14A and insider filings. Treat a gap as unknown, not
   as proof of no holding.

4. **Read each transaction by its code.** The code on a Form 4 line says what
   happened. P and S are open-market trades. A is an award. M and X are option
   exercises. F is shares withheld for tax. G is a gift. D is a disposition
   back to the issuer. C is a conversion. The full table, with what each code
   means for liquidity, is in
   [references/form4-transaction-codes.md](references/form4-transaction-codes.md).
   Key rules:
   - Only S (and D for cash) puts cash in the prospect's hands. A, M and C
     change the form of wealth, not its liquidity.
   - An M followed the same day by an S is a cashless exercise-and-sell. Net
     cash is (sale price minus exercise price) times shares, before tax.
   - F is tax withholding. It is not a sale decision.
   - G is a gift. The recipient in the footnote matters: a family trust, a
     foundation, a donor-advised fund (DAF, a charitable account held at a
     sponsor such as a community foundation or a financial firm), or a named
     charity. A gift to a DAF or foundation is a strong philanthropic signal.

5. **Separate direct and indirect ownership.** Column 6 of Table I marks D
   (direct) or I (indirect). Indirect holdings name the holder in column 7 or
   a footnote: "by GRAT", "by Family Trust", "by spouse", "by LLC". Count
   trust and LLC holdings toward the family's capacity, but say that the
   person may not control them alone. Many insiders disclaim beneficial
   ownership of indirect shares "except to the extent of pecuniary interest".
   Report the disclaimer.

6. **Separate Table I from Table II.** Table I is non-derivative securities
   (common stock). Table II is derivatives (options, RSUs, warrants,
   convertible notes). An option is worth only its spread (market price minus
   exercise price) and only once it vests. An RSU (restricted stock unit) is
   worth nothing to the holder until it vests. Do not add Table II to net
   worth at full share price.

7. **Read the footnotes.** They carry the facts that change the reading:
   - "effected pursuant to a Rule 10b5-1 trading plan adopted on <date>": the
     sale was scheduled in advance. It is still cash. Do not read a motive
     into it. Forms 4 filed on or after April 1, 2023 carry a checkbox for
     10b5-1 trades.
   - "weighted average price; range $X to $Y": the price is an average over
     many trades that day.
   - Vesting schedules, trust names, GRAT and family-partnership holders.

8. **Value each transaction on its event date.** Use the price reported on
   the Form 4 line. When there is no price (codes A, G, often F and M), use
   the closing price on the transaction date from a public quote source, and
   say that you did: "valued at the 2026-03-14 closing price of USD 84.20; the
   Form 4 reports no price for gifts". Never value a 2019 gift at today's
   price. Gross sale proceeds are not net worth: taxes and the cost basis are
   unknown.

9. **Read the proxy for pay and the ownership table.** For officers and
   directors, the DEF 14A (the annual proxy statement) gives the Summary
   Compensation Table, the beneficial ownership table, director bios and
   related-party transactions. Use the checklist in
   [references/proxy-reading-checklist.md](references/proxy-reading-checklist.md).
   Stock awards in the pay table are grant-date accounting values, not cash.

10. **Go to EDGAR for the filings the tool does not cover.** Search EDGAR
    directly for:
    - **Schedule 13D / 13G**: filed by holders of more than 5% of a class.
      13D means an active holder (may seek influence); 13G is a passive or
      exempt holder. The cover page gives shares and percent owned. As of
      2026, an initial 13D is due within 5 business days of crossing 5%
      (since February 5, 2024), and a 13D amendment within 2 business days.
      An initial 13G from a passive investor is due within 5 business days
      (since September 30, 2024); 13G amendments are due 45 days after the
      end of the quarter in which a material change occurred. Check sec.gov
      for current rules.
    - **S-1 / 424B prospectus**: the "Principal and Selling Stockholders"
      table lists pre-IPO holders and what each sells in the offering. The
      "Shares Eligible for Future Sale" section gives the lock-up, usually 180
      days, sometimes staged. The lock-up expiry is a liquidity date.
    - **8-K**: Item 2.01 (completion of an acquisition or disposition of
      assets) marks a deal closing. Item 5.02 marks an officer or director
      arriving or leaving, often with pay terms or a separation agreement.
      Item 1.01 marks a material agreement, such as a merger agreement.
    - **Form 144**: notice of a proposed sale of restricted or control stock,
      filed by affiliates when a sale in three months exceeds 5,000 shares or
      USD 50,000. It signals a coming sale. It does not prove the sale happened;
      the Form 4 confirms it.
    - **Form D**: notice of a private securities offering (Regulation D).
      Item 3 lists "related persons": executive officers, directors and
      promoters. It shows the amount raised and the date of first sale. It is
      a signal about the company, not the person's stake.
    How to search: EDGAR company search by name or ticker; person search by
    name (the result is the reporting owner's CIK and every filing under it);
    EDGAR full-text search (efts, filings since 2001) for a name inside
    documents, for example a trust name or a selling stockholder table. Cite
    each fact with its form, filing date and URL.

11. **Find peers and cohorts.** To find other people with a similar signal
    (for example owners of a business, or sports-franchise owners), use
    `list_people_by_indicator` with an indicator type the tool lists. Do not
    invent an indicator type. Each person it returns needs the same identity
    check as step 2.

12. **Translate to capacity and timing.** Write the read in plain terms:
    - Realized cash in the last 3 to 5 years (sum of S lines at their prices).
    - Current stake at a stated price and date, split into vested common,
      unvested awards, and in-the-money options.
    - Concentration: most insiders hold much of their wealth in one stock.
      Say so, and say the stake's value moves with the share price.
    - Events: a sale, a deal close, a lock-up expiry, a retirement 8-K. Each
      is a liquidity event and a cultivation moment. A prospect who just
      realized cash has both money and, often, a tax reason to give that year.
    - What is unknown: holdings outside this company, cost basis, taxes,
      private wealth.

## Pitfalls

| Trap | Fix |
|---|---|
| Adding option and RSU counts at full share price | Value options at their in-the-money spread and only when vested; show unvested awards apart. |
| Treating an A (award) as income received | An award is compensation granted, often unvested. It is not cash. |
| Reading F as a sale | F is tax withholding on vesting. Not a decision to sell. |
| Valuing a gift or award at today's price | Use the event-date closing price, and say so. |
| Summing gross sales as net worth | Sales are pre-tax proceeds. Say "gross proceeds". |
| Treating a 10b5-1 sale as a signal of doubt about the company | It was scheduled in advance. Report it as a scheduled sale. |
| Stopping at the last Form 4 | Holdings after someone leaves the company are no longer reported. Say the figure is "as of" the last filing. |
| Attaching a same-name filer | Match on CIK, issuer and city. Show both candidates if unsure. |
| Treating a Form 144 as a completed sale | Confirm with the matching Form 4. |
| Treating a Form D raise as the founder's wealth | It is the company's raise. The founder's stake is unknown unless another filing shows it. |
| Counting a trust's shares as the person's alone | Say who the trust or LLC holds for, and report any disclaimer. |

## Output template

```markdown
# SEC findings: <Full Name>
Prepared by <name>, with AI assistance. Reviewed by <name>, <date>. Purpose: SEC section of a prospect review.

**Summary.** <2-4 sentences: role, current stake and its value on <date>,
cash realized since <year>, the next liquidity date, and what it means for
timing an ask.>

## Identity
<Name, CIK, issuer, role, city in the filing header. Any namesake noted.>

## Holdings (as of <filing, date>)
| Class | Shares | Direct / indirect (holder) | Value at $<price> on <date> |
|---|---|---|---|

## Transactions since <year>
| Date | Code | Shares | Price | Value | D/I | 10b5-1 | Filing |
|---|---|---|---|---|---|---|---|

## Pay (DEF 14A, <fiscal year>)
<Salary, bonus, stock awards (grant-date value), total. Note awards are not cash.>

## Liquidity and timing
- Realized: <gross proceeds, dates>
- Paper: <vested stake; unvested; options spread>
- Next events: <lock-up expiry, deal close, vesting, 144 notice>

## Unknowns
<What is not known and which filing or question would settle it.>

## Sources
1. SEC Form 4, <issuer>, filed <date>. <URL>
2. ...
```

Offer a Word or PDF version when the environment supports it.

For a deeper read, the two reference files hold the code table and the proxy
checklist. Research only public records, and follow `ethics-and-privacy`.
