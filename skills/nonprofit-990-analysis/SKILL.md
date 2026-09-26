---
name: nonprofit-990-analysis
description: >-
  Read IRS Form 990, 990-EZ and 990-PF filings for prospect research. Use when
  the user asks "does X have a family foundation", "what does the X Foundation
  fund", "who is on the board of <nonprofit>", "what boards does X sit on", "how
  big is this foundation", "who gives to <cause> in <state>", "read this 990",
  or wants grants, trustees, officer pay, related-party deals or contributors
  explained. Produces cited findings: the person's board and trustee roles, a
  family foundation's assets, payout, grant interests and geography, and what
  that means for capacity and affinity. Covers donor-advised funds (grants that
  do not name the donor). Hands off to sec-filing-analysis, property-analysis
  and political-giving-analysis for other records, to capacity-research for a
  capacity rating, to prospect-research for the full research loop, and to
  ethics-and-privacy for the research standard.
---

# Nonprofit 990 analysis

The Form 990 series is the public tax return of US tax-exempt organizations.
For prospect research it answers three questions:

- **Where does this person serve?** Board, officer and trustee roles show
  affinity and network.
- **Does this family have a private foundation, and what does it fund?** A
  990-PF gives a capacity floor, the family's causes and giving geography.
- **Who decides?** Trustees and officers of a family foundation are the
  people who approve grants.

Forms:
- **Form 990**: public charities with gross receipts of USD 200,000 or more, or
  assets of USD 500,000 or more.
- **Form 990-EZ**: smaller public charities (receipts under USD 200,000 and
  assets under USD 500,000).
- **Form 990-N (e-Postcard)**: the smallest; no financial detail.
- **Form 990-PF**: every private foundation, whatever its size.

Thresholds are as of 2026; check irs.gov for current rules.

## When to use

- The user asks about a person's nonprofit boards or trusteeships.
- The user asks about a foundation: its assets, grants, trustees or causes.
- The user wants funders for a cause or place.
- A proxy bio, obituary or news story names a board role that needs checking.

Hand off:
- Stock and insider records: `sec-filing-analysis`.
- Real estate: `property-analysis`.
- FEC records: `political-giving-analysis`.
- A capacity rating: `capacity-research`. The full research loop:
  `prospect-research`. A written brief: `briefing-writing`.
- Research standard: `ethics-and-privacy`.

## What good looks like

- Each board role with the organization, title, the filing year that shows
  it, hours per week, and any pay.
- For a family foundation: fair-market-value assets, annual grants paid,
  payout rate, top grantees by amount and purpose, giving geography, and the
  trustees, each with the fiscal year of the return.
- A plain reading: what the foundation says about the family's capacity
  floor and interests, and who makes decisions.
- Gaps named: filing lag, a DAF that hides the donor, a Schedule B that is
  redacted.
- Every fact cited: "IRS Form 990-PF, FY2023, Part XIV", with a link.

## Method

1. **Ask Tirion first.** Call `ask_tirion` with the user's question in their
   words ("What foundations is Jane Q. Doe of Richmond connected to?").

2. **Fix the identity.** Use `search_people` and `get_profile` to find the
   person and check city and employer. A 990 lists a name and, often, only
   the organization's address. A name alone does not prove the person is your
   prospect. Link them by city, by a spouse also on the board, by the
   foundation carrying the family name and the prospect's address as the
   foundation's address, or by a bio that names the role.

3. **List the person's roles.** Call `get_nonprofit_connections` for the
   person. It returns officer, director and trustee roles with pay and
   organization details from Part VII of the 990 or Part VII of the 990-PF
   (Part VIII on 990-PF returns before the early-2020s redesign).
   Record the fiscal year of each. A role missing from recent years may have
   ended, or the newest return may not be filed yet.

4. **Find a family foundation.** Call `search_foundations` with the person's
   full name and with the family surname. It matches foundation names and
   990-PF officer lists. A surname match does not prove family control. Confirm
   with at least one link: the prospect or spouse is a trustee, the foundation
   address is the family's city, or a news item or bio names it.

5. **Read the foundation's return.** Use `search_nonprofits` with the name or
   EIN (employer identification number, the organization's tax ID) to get its
   assets and revenue. Then read the return itself on ProPublica Nonprofit
   Explorer (projects.propublica.org/nonprofits), IRS Tax Exempt Organization
   Search (TEOS, apps.irs.gov/app/eos), or Candid. The Part-by-Part field guide
   is in [references/990-field-guide.md](references/990-field-guide.md).
   Key items for a 990-PF:
   - Page 1 header item I: fair market value of all assets at year end.
   - Part I, line 25: contributions, gifts and grants paid.
   - Part I, line 1: contributions received. A large gift in means the family
     funded it that year. Schedule B names the contributors (public for
     private foundations).
   - Part II: the balance sheet, including investments by type.
   - "Information About Officers, Directors, Trustees": trustees and
     officers, with pay and hours (Part VII on recent returns, Part VIII on
     older ones).
   - "Supplementary Information", line 3, "Grants and Contributions Paid
     During the Year": recipient, relationship, status, purpose and amount
     (Part XIV on recent returns, Part XV on older ones).

6. **Read the grants.** Sort grants by amount. Group them by purpose (health,
   higher education, arts, environment, faith-based, local human services) and
   by recipient location. Note repeat grantees across years: a steady grantee
   is a relationship. Note large one-time grants: they may be a pledge
   payment or a capital campaign gift. For a public charity, Schedule I lists
   grants over USD 5,000 to US organizations.

7. **Apply the payout rule.** A private foundation must distribute about 5% of
   the average fair market value of its non-charitable-use assets each year
   (IRC section 4942). Compare grants paid to year-end assets. A payout well
   above 5% may mean the family gives through the foundation actively or is
   spending it down. A payout near 5% is the minimum. A payout below 5% in one
   year can be made up later; read two or three years.

8. **Read the family-foundation signals as a researcher.**
   - **Capacity floor.** Assets in the foundation are no longer the family's
     personal wealth. They do show that the family once had at least that
     much to give away. Treat the funding history (Part I line 1 across years)
     as evidence of past liquidity.
   - **Interests.** Grant purposes show causes. Say "the foundation funds"
     not "the family believes".
   - **Geography.** Recipient cities show where the family gives.
   - **Decision-makers.** Trustees approve grants. Adult children who become
     trustees are the next generation of decision-makers.
   - **Access.** Some foundations state "contributes only to preselected
     charitable organizations" in the application section. That means the
     relationship route, not a proposal.

9. **Handle donor-advised funds.** A DAF is an account at a sponsoring charity
   (a community foundation, or a sponsor such as Fidelity Charitable or Schwab
   Charitable). The sponsor files the 990 and its Schedule I lists grants made
   in the sponsor's name. The donor who recommended the grant is not named.
   You cannot trace a DAF grant to a person from the 990. A grant letter or
   donor roll that says "the Doe Family Fund at <sponsor>" can make the link;
   cite that source.

10. **Look at board networks.** `get_board_roster` lists the board of one
    organization. `search_board_members` finds people who sit on several
    boards, by name or state. Board service is an affinity signal: the person
    gives time to the cause, and board members are often expected to give.
    Multiple boards mark a connector. A shared board is a possible warm path
    between the prospect and your own trustees. Same-name board members are
    not the same person until linked.

11. **Find funders by cause or place.** `search_foundations_by_cause` returns
    foundations and grantmakers that fund a cause, nationally, in a state, or
    in a filing city, with the matching grant descriptions as evidence. Read
    the evidence before calling a funder a fit.

12. **Check related-party and other schedules.** For a public charity where
    the prospect is an officer or director, Schedule L lists transactions with
    insiders (loans, business deals, grants to family). Schedule O holds
    narrative explanations, often governance details and pay-setting methods.
    Schedule J gives details of pay for people over USD 150,000.

## Pitfalls

| Trap | Fix |
|---|---|
| Counting foundation assets as personal net worth | Foundation assets are irrevocably given. Use them as a floor on past wealth and as proof of a giving vehicle. |
| Quoting a 990 figure without the year | 990s lag one to two years. Always give the fiscal year. |
| Reading a surname foundation as the prospect's | Confirm with a trustee, address or published link. |
| Assuming no role because the latest return omits it | Returns lag. Say "not listed on the FY<year> return". |
| Looking for DAF donors on the sponsor's 990 | The sponsor's 990 does not name them. Use donor rolls and annual reports instead. |
| Expecting Schedule B names for a public charity | Public copies of a public charity's Schedule B hide names and addresses. Private foundations' contributors are public. |
| Treating a board seat as a gift | Board service is affinity, not a record of giving. Look for the person on the organization's donor roll. |
| Reading 990-PF Part numbers from an old guide | The IRS removed a part from the 990-PF in its early-2020s redesign, so later parts moved up by one. Find the part by its title, not only its number. |
| Naming trustees who are minors or naming family health or religion | Do not. See `ethics-and-privacy`. |

## Output template

```markdown
# Nonprofit and foundation findings: <Full Name>
Prepared by <name>, with AI assistance. Reviewed by <name>, <date>. Purpose: philanthropy section of a prospect review.

**Summary.** <2-4 sentences: the family foundation (assets, grants, fiscal
year), top causes and geography, the person's board roles, and the best
warm path.>

## Board and trustee roles
| Organization | Role | Hours/week | Pay | Filing |
|---|---|---|---|---|

## <Family> Foundation (EIN <xx-xxxxxxx>)
| Fiscal year | FMV assets | Contributions received | Grants paid | Payout % |
|---|---|---|---|---|

**Trustees and officers:** <names and titles, FY<year>>
**Top grantees (FY<year>):**
| Recipient | City, State | Purpose | Amount |
|---|---|---|---|

**Reading.** <Capacity floor; interests by purpose; geography; who decides;
open to proposals or preselected only.>

## Warm paths
<Shared boards with our trustees or volunteers, with the filing that shows each.>

## Unknowns
<DAF giving, recent years not yet filed, gifts outside the foundation.>

## Sources
1. IRS Form 990-PF, <Foundation>, FY<year>, Part XIV. <ProPublica URL>
2. ...
```

Offer a Word or PDF version when the environment supports it.

Research only public records, and follow `ethics-and-privacy`.
