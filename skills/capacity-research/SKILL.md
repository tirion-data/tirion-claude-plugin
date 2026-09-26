---
name: capacity-research
description: >-
  Estimate a prospect's 3-5 year major-gift capacity and recommend an ask
  range. Use it for "how much could X give", "what is X's capacity", "rate
  this prospect", "is X a seven-figure prospect", "what should we ask for",
  "check this capacity rating", or when a brief or profile needs its capacity
  section. It builds the estimate from assets and income (real estate,
  public-company stock and Form 4 activity, proxy pay, private-company and
  partnership signals, foundations and past gifts, political giving as a
  signal) and returns a range, its drivers, exclusions, confidence and an ask
  range. Identity must be settled first (prospect-research). Recent stock
  sales and deals: market-and-liquidity-intelligence. Documents:
  briefing-writing. Ethics: ethics-and-privacy.
---

# Capacity research

Capacity is what a person could give over 3 to 5 years if they chose to. It is
not net worth, and it is not what they will give. This skill builds a capacity
range from public evidence of assets and income, states what drives it and what
it leaves out, and turns it into an ask range by weighing inclination and
affinity.

Every number here is an estimate from public records. Say so. Follow
[ethics-and-privacy](../ethics-and-privacy/SKILL.md): public and properly sourced
information only.

## When to use

- The user asks what someone could give, wants a rating, or wants an ask amount.
- A brief or profile needs its capacity section.
- A rating from Tirion or a vendor needs a sanity check.

Before you start, the identity must be settled. If it is not, run the identity
step in [prospect-research](../prospect-research/SKILL.md) first. For what a
specific stock sale, merger or IPO means for timing, use
market-and-liquidity-intelligence.

## What good looks like

- A capacity range on the standard rating ladder (for example "B1, 2.5 to 4.9
  million dollars over 5 years"), never a single figure.
- The drivers: each asset or income source, its value, its record and date.
- Exclusions: what is unknown or left out, and whether it would raise or lower
  the range.
- A confidence level with its reason.
- An ask range, with the inclination and affinity evidence that set it.
- Liquidity and timing: what could fund a gift now, and what only on a future
  event.

## Method

### 1. Get Tirion's rating and its basis

1. Run `ask_tirion` with the user's question ("what could Jane Doe of Naples, FL
   give?").
2. Run `assess_wealth` for the rating on the A1 to D4 ladder, the public
   sources it rests on, and any conflict flags. `get_capacity` is the lighter
   version; use `assess_wealth` when you must explain the rating.
3. Read the rating as a starting point. Your job is to check it against the
   assets below, explain it, and say what it does not include.

The ladder and its dollar bands are in
[references/capacity-conventions.md](references/capacity-conventions.md).

### 2. Build the asset picture

Work from the hardest evidence to the softest. For each asset, record the value,
the record, the date, and whether the person controls it.

**Real estate** (`get_property_portfolio`, `get_owner_footprint`,
`search_properties`, `search_by_address`; county assessor and recorder sites)

- Assessed value is not market value. Assessment ratios differ by state and
  county. California's Proposition 13 holds long-held homes far below market.
  Florida's homestead cap does the same more slowly. Use a recent sale price or a
  county's stated assessment ratio to move toward market, and say which you used.
- Look for more than the primary home: second homes, rental and commercial
  property, farmland. Search the owner name last-name-first, and search trust and
  LLC names found on deeds or in the mailing address.
- Ownership vehicles matter. A revocable trust in the person's name counts as
  theirs. An LLC counts only when a filing ties it to them.
- Check the recorder for a mortgage or deed of trust. Debt reduces equity.
- A county list of 20 parcels may not be the whole portfolio. Say so if the tool
  reports more.

**Public-company equity** (`get_sec_filings`; SEC EDGAR)

- Form 4 is the insider report officers, directors and 10% owners file within
  two business days of a trade. Read the transaction codes (S sale, P purchase,
  M option exercise, F shares withheld for tax, G gift, A grant). The code table
  is in the reference file.
- Holdings after the last Form 4, times a recent closing price, give the current
  position. Date both.
- A 10b5-1 plan is a pre-set trading plan. Form 4 has a checkbox for trades
  under one (on filings since April 1, 2023). Plan sales show regular, planned liquidity.
- Form 144 is the notice of a planned sale of restricted or control stock. It
  signals coming liquidity.
- The proxy (DEF 14A) beneficial-ownership table gives shares held by each
  director and named officer, with footnotes on trusts and family holdings.
- Gross sale proceeds are not net worth. Taxes, reinvestment and spending
  are unknown. Count sales as evidence of liquidity, dated.
- A person who has left the company stops filing. Mark holdings "last reported
  (date); current holding not confirmed".

**Compensation** (`get_sec_filings`; DEF 14A)

- The Summary Compensation Table gives salary, bonus, stock awards, option
  awards, non-equity incentive pay, and all other compensation for the named
  executive officers, for three years.
- Stock and option awards are grant-date values, not cash received. The
  "Option Exercises and Stock Vested" table shows what was realized.
- Income supports capacity over years. Use the conventions in the reference file
  to turn income into capacity.

**Private-company and partnership signals** (`get_entity_facts`,
`get_news_mentions`; public sources)

- Founder or owner of a private company: look for acquisition press, the
  acquirer's 8-K or merger proxy, funding rounds, and SEC Form D (a notice of a
  private offering that names officers and directors and the amount raised).
- Investment firm partner: Form ADV (on the SEC's adviser search) gives assets
  under management and lists owners of 5% or more.
- Law, accounting or consulting partner: equity or non-equity status matters
  more than the title. Published profits-per-partner figures give a range.
- These assets are often larger than everything visible, and rarely liquid. They
  raise the top of the range, not the bottom.

**Past giving** (`get_nonprofit_connections`, `search_foundations`,
`get_recognitions`; donor rolls, annual reports, press)

- Named gifts and donor-roll ranges elsewhere show proven capacity. A known gift
  of an amount to a peer institution suggests capacity of at least that amount.
- A private foundation files Form 990-PF. Part XIV (Supplementary Information,
  line 3) lists grants paid; older returns call it Part XV. Page 1, item I, gives
  total assets at fair market value. Private foundations must pay out about 5% of assets a year, so assets
  imply the annual grant budget. Foundation assets are not personal wealth.
- Schedule B donor names are withheld from public copies of Form 990 and 990-EZ
  for public charities, so a charity's donors cannot be read there. A private
  foundation's 990-PF Schedule B is public and names who funded it.
- Giving shows inclination. Do not let giving history inflate the capacity figure
  itself. Use it in the ask range.

**Political giving** (`get_political_giving`, `get_fec_committee`; FEC.gov)

- FEC itemizes a donor's contributions once they pass 200 dollars (per election
  cycle to a candidate, per calendar year to a PAC or party). Repeated maximum
  contributions and large super PAC gifts show discretionary cash.
- Treat it as a signal of wealth and engagement only. It is not a capacity
  amount. Common names produce false matches; check the reported employer and city.

### 3. Estimate a range

1. Name the primary wealth driver (real estate, public stock, compensation, a
   private company, or a mix).
2. Set the floor from assets you can see and value, net of known debt.
3. Set the ceiling from what is likely but not visible (private company value,
   partnership interests, family trusts), with the basis for each.
4. Convert to 3-to-5-year capacity with the conventions in the reference file.
   A common starting convention is about 5% of estimated net worth over 5 years,
   adjusted by liquidity, age and life stage, and giving history. It is a
   convention, not a rule. Some shops use 1 to 3% for cautious ratings and 10%
   or more for proven major donors.
5. Place the result on the ladder. When the range spans two tiers, give both.

Only assets the person controls drive the rating. A spouse's separate assets, a
parent's estate, or a family foundation the person does not control are upside.
List them on their own line.

### 4. Set confidence

- **Higher**: direct evidence of large, valued assets (SEC holdings and sales, a
  documented company sale, a published net-worth figure) plus a second source.
- **Moderate**: two or three independent asset signals.
- **Lower**: one signal, such as real estate alone, or title and employer alone.

Real estate alone makes a floor with low confidence and a wide range. A
high-status role with little visible wealth is not proof of modest means. Wealth
often sits in private assets.

### 5. Turn capacity into an ask range

Capacity is the ceiling. The ask depends on inclination (do they give?) and
affinity (do they care about us?). Use the adjustment table in the reference
file, state which evidence placed the prospect there, and add timing: a recent
liquidity event, a campaign, a plan year.

### 6. Check your work

Run the capacity items of the QC checklist in
[prospect-research](../prospect-research/references/qc-checklist.md). In short:
range, not point; assessed not called market; awards not called cash; proceeds
not called net worth; each asset counted once; every figure dated.

## Output template

```markdown
**Capacity (3-5 years): <tier label>, <low> to <high> dollars.** Confidence: <higher | moderate | lower>, because <reason>.

**Drivers**
| Asset or income | Value | Basis | Record and date |
|---|---|---|---|
| <e.g., Primary home, Naples FL> | <assessed 4.2M; est. market 5-6M> | <2025 sale of comparable> | <Collier County Property Appraiser, 2026 roll> |
| <e.g., Form 4 sales, ACME common> | <18M gross proceeds since 2023> | <sum of code S trades> | <SEC Form 4s, 2023-03-02 to 2026-08-24> |

**Upside not in the range:** <private company, spouse's assets, family trust>, with basis.
**Excluded or unknown:** <what, and what would settle it>.
**Liquidity and timing:** <what is liquid now; what depends on a future event>.

**Ask range: <low> to <high> dollars**, because <inclination and affinity evidence>. Suggested timing: <when and why>.
```

Write dollar amounts in the deliverable with a dollar sign as usual.

## Pitfalls

- **One number.** A single figure implies precision the evidence does not have.
  Fix: a tier and a range, with confidence.
- **Assessed as market.** Fix: say which value you used and how you adjusted it.
- **Awards as cash.** Fix: count vested and sold stock; list unvested awards as
  future upside.
- **Proceeds as net worth.** Fix: report proceeds as dated liquidity.
- **Double counting.** The Form 4 holding and the proxy ownership row are the same
  shares. Fix: one line per asset.
- **Foundation assets as personal wealth.** Fix: count them as inclination and as
  a floor on family wealth, not as the person's assets.
- **Stale holdings.** Fix: date every holding; mark departed insiders.
- **Giving history inflating capacity.** Fix: use giving in the ask range, not in
  the capacity figure.
- **Real estate as the whole story.** Fix: treat it as a floor and look for the
  private assets above it.
