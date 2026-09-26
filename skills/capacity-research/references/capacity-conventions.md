# Capacity conventions and reference tables

These are practitioner conventions, not rules or measured laws. Prospect research
shops set their own. Use them to structure an estimate, say which one you used,
and adjust with judgment. Every capacity figure is a range over 3 to 5 years.

## 1. The capacity rating ladder (3-5 year major-gift capacity)

Tirion's `assess_wealth` and `get_capacity` return a label on this ladder. Use the
label and its band in deliverables.

| Tier | Range | Tier | Range |
|---|---|---|---|
| A1 | $100M and above | C1 | $500K - $999K |
| A2 | $50M - $99M | C2 | $250K - $499K |
| A3 | $25M - $49M | C3 | $100K - $249K |
| A4 | $10M - $24M | D1 | $50K - $99K |
| A5 | $5M - $9.9M | D2 | $25K - $49K |
| B1 | $2.5M - $4.9M | D3 | $10K - $24K |
| B2 | $1M - $2.4M | D4 | under $10K |

Each tier is about double the one below. When evidence spans two tiers, report
both ("B1 to A5").

## 2. Net worth to capacity

| Convention | Use |
|---|---|
| About 5% of estimated net worth over 5 years | The common starting point. |
| 1-3% of net worth | Cautious: little giving history, illiquid wealth, young family, or peak-career spending. |
| 3-5% | Some giving history. |
| 5-10% | Active philanthropist: foundation, board service, named gifts. |
| 10-25% or more | Proven major donor, legacy-minded, or planning a transformational gift. |

Adjust up for liquid wealth, later life stage, no dependents, and a recent
liquidity event. Adjust down for concentrated or illiquid holdings, heavy debt,
and large pledges elsewhere.

Critics note that the 5% convention can understate the very wealthy because it
ignores invested assets, foundations and donor-advised funds. When you can see
holdings, build from the assets (section 3) and use the percentage as a check.

## 3. Asset back-solve conventions

When you can see one asset class, some shops estimate net worth from it. These
shares vary widely by person. Use them only when nothing better exists, and say so.

| Visible asset | Convention | Estimate |
|---|---|---|
| Real estate (all properties, market value) | often 20-25% of net worth for affluent households | net worth ~ real estate / 0.225 |
| Public securities (known holdings) | often 30-35% of net worth | net worth ~ holdings / 0.325 |
| Annual income | net worth often ~10x income for established earners | net worth ~ income x 10 |

A conservative real-estate-only floor, used when real estate is the only signal:

1. Equity = market value x 0.65 (assumes about 35% average loan-to-value when the
   mortgage is unknown; use the recorded mortgage when you have it).
2. Annual giving rate on equity: 1% under $500K, 2% under $2M, 3% under $10M, 5%
   at $10M and above.
3. Capacity = equity x rate x 5 years.

| Real estate | Equity | Rate | 5-year floor |
|---|---|---|---|
| $1M | $650K | 2% | about $65K |
| $5M | $3.25M | 3% | about $490K |
| $10M | $6.5M | 3% | about $975K |
| $25M | $16.25M | 5% | about $4.1M |

Treat this as a floor with low confidence. Many owners of valuable homes have
wealth well beyond them; many have large mortgages.

## 4. Income to capacity

| Household income | Capacity as % of estimated wealth |
|---|---|
| under $100K | 1% |
| $100K - $249K | 2% |
| $250K - $499K | 3% |
| $500K - $999K | 4% |
| $1M and above | 5% or more |

For estimated wealth of $20M or more, drop the income scale and use 5-10% of
estimated wealth.

A simpler income convention: capacity over 5 years of about 10% of one year's
income, for a well-paid executive with little visible wealth.

**Income implied by a home** (when the home is the only clue): assume an 80%
mortgage at 30 years and a current rate; assume the payment is about 20% of gross
income; income ~ monthly payment x 5 x 12. Adjust for the local cost of housing;
a coastal metro home implies less income than the same price elsewhere.

## 5. Profession-specific floors

**Investment firms** (private equity, venture, hedge funds)
- Management fees are typically 1.5-2% of assets under management a year (venture
  2-2.5%); carried interest is typically 20% of profits above a hurdle.
- Floor for a partner's income ~ (fund assets x management fee) / number of
  partners. Example: $460M x 1.5% / 4 partners ~ $1.7M a year.
- Carried interest can be several times that floor but is uncertain and paid on
  exits. Treat it as upside.
- Sources: Form ADV Part 1 (assets under management; Schedule A lists owners of
  5% or more), fund press releases.

**Law firms**
- Equity or non-equity partner status matters more than the title.
- Income ~ firm profits per equity partner x a seniority multiplier: senior or
  founding equity partner 1.5-3x; mid-level equity 0.8-1.2x; junior equity
  0.5-0.8x; non-equity 0.3-0.5x.
- Profits per partner is published for large firms by legal trade press. It is an
  average, and pay inside a firm is spread widely.

**Public-company executives**
- Use the proxy Summary Compensation Table for pay and the Option Exercises and
  Stock Vested table for realized equity. Add holdings from the beneficial
  ownership table and the last Form 4.

## 6. SEC forms and Form 4 transaction codes

| Form | What it shows |
|---|---|
| Form 3 | Initial holdings when a person becomes an insider. |
| Form 4 | Changes in holdings, filed within 2 business days. Gifts (code G) must also be reported within 2 business days since February 27, 2023. |
| Form 5 | Annual report of deferred or exempt transactions. |
| Form 144 | Notice of a proposed sale of restricted or control securities. |
| Schedule 13D / 13G | Ownership above 5% of a class of stock. As of 2026, an initial 13D or passive-investor 13G is due within 5 business days. |
| DEF 14A (proxy) | Summary Compensation Table; Option Exercises and Stock Vested; beneficial ownership table; director bios. |
| Form D | Notice of a private securities offering; names executive officers and directors; amount raised. |
| 8-K | Material events, including mergers and executive changes. |

| Form 4 code | Meaning | Capacity reading |
|---|---|---|
| P | Open-market or private purchase | Discretionary cash spent on stock. |
| S | Open-market or private sale | Liquidity. Record date, shares, price, proceeds. |
| A | Grant or award from the company | Not cash. Future value if it vests. |
| M | Exercise or conversion of a derivative (exempt) | Often paired with S (exercise and sell). |
| X | Exercise of an in-the-money or at-the-money derivative | As M. |
| F | Shares withheld to pay exercise price or tax | Not a sale by choice. Not liquidity. |
| G | Gift | Charitable or family gift of stock. Strong inclination signal when the recipient is a charity or foundation. |
| D | Disposition back to the company | Often a buyback or forfeiture. |
| C | Conversion of a derivative | Neutral. |
| J | Other (see footnote) | Read the footnote. |

The 10b5-1 checkbox (required on Forms 4 and 5 filed on or after April 1, 2023)
marks trades made under a pre-set trading plan. Plans adopted by officers and
directors since February 27, 2023 have a cooling-off period of 90 to 120 days
before trades start. Recurring plan
sales mean steady, planned liquidity.

Value a sale at the price reported on the Form 4. Value current holdings at a
recent close, and date it.

## 7. Nonprofit and foundation records

| Record | What to read |
|---|---|
| Form 990-PF (private foundation) page 1, item I, and Part II | Total assets at fair market value (item I); the balance sheet at book and fair market value (Part II). |
| Form 990-PF Part XIV, Supplementary Information, line 3 (Part XV on returns before the early-2020s redesign) | Grants and contributions paid during the year, by recipient. |
| Form 990-PF Schedule B | Contributors to the foundation. Public for private foundations. |
| Form 990 / 990-EZ Schedule B (public charity) | Contributor names and addresses are withheld from public copies. |
| Form 990 Part VII | Officers, directors, trustees, key employees and their pay. |
| Form 990 Schedule I | Grants made to other organizations. |

Private foundations must distribute about 5% of net investment assets a year
(Internal Revenue Code section 4942). Foundation assets therefore imply the annual
grant budget. Foundation assets are not the founder's personal wealth, but a large
foundation shows both inclination and substantial family wealth.

990 data trails by one to two years. Always name the fiscal year.

## 8. Adjusting capacity to an ask range

Capacity is the ceiling. Most shops set the ask by inclination and affinity. A
common scheme:

| Evidence | Ask range |
|---|---|
| Gives at this level elsewhere and has a strong tie to us | At the capacity tier. |
| Gives generously elsewhere; moderate tie to us | One tier below capacity. |
| Gives modestly, or a strong tie but little giving shown | Two tiers below capacity, or a first gift to build the relationship. |
| No giving shown and no tie to us | No ask yet. Cultivate. State what would change that. |

Timing: an ask soon after a liquidity event (a stock sale, a company sale, a
property sale) meets available cash. Asks are often sized to a campaign's gift
range chart, where each level is about half the level above.

## 9. Confidence levels

| Level | Typical basis |
|---|---|
| Higher | Direct evidence of large assets (SEC holdings and sales, a documented company sale, a published net-worth figure) plus an independent second source. |
| Moderate | Two or three independent signals that agree. |
| Lower | One signal, such as real estate alone, or role and employer alone. |

Keep the research rating and any officer rating side by side. When they differ by
more than a tier, say so. The gap is information: the officer may know about
wealth or constraints that records do not show.
