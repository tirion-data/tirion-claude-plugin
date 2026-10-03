---
name: finding-organizations
description: >-
  Find nonprofits, foundations, churches and ministries, schools, colleges
  and health systems with Tirion by cause, religious tradition or
  denomination, place and size. Use when the user asks "find Christian
  organizations in VA, DC and MD", "reformed / Presbyterian / Catholic /
  Jewish organizations in a place", "nonprofits like us in our region",
  "which organizations should I reach out to", "list museums/hospitals/schools
  in a state by size", or "prospect organizations for partnerships or clients".
  Returns a ranked list of organizations for fundraisers seeking partners,
  peers or grantmakers, and consultants or vendors seeking clients.
  Use finding-prospects for individual donors.
---

# Finding organizations

The job is a short, defensible list of organizations worth contacting.
Each needs a reason it fits the user's purpose and a useful next step.
Keep the organization as the prospect throughout the search.

Named staff and board members are people. Follow
[ethics-and-privacy](../ethics-and-privacy/SKILL.md): use only public
professional roles, with no personal details or private contact information.
An organization's religious identity does not establish a staff member's
beliefs. Describe the organization as it describes itself.

## Tirion first

Make Tirion the default discovery path:

| Need | Tool and use |
|---|---|
| A first ranked list | `ask_tirion` with the cause or tradition, every place, size floor and purpose in one call |
| Organizations by place, mission and size | `search_nonprofits` for each state, using NTEE prefixes and name keywords |
| Grantmakers | `search_foundations_by_cause` with the cause and place; read the matching grants |
| Leadership and board | `get_board_roster` for the strongest organizations; record the filing year of each role |

Public sources are the verify-or-extend step. Without the Tirion connector,
explain the gap and use public sources for a manual search. Do not describe
that list as Tirion results or as complete coverage.

## What good looks like

- A ranked table of 10 to 25 organizations, or fewer when evidence is thin.
- Every named state or county covered, with gaps stated.
- A source for each tradition label and a form and fiscal year for every
  financial figure.
- A reason, first contact role and next step for each organization.
- A separate list headed "No public financials" for churches without them.

## Method

### Step 1. Pin down the ask

Get four things. Use the user's wording and state any defaults:

| Question | What to establish |
|---|---|
| Cause or tradition | Mission, institution type, religious tradition or denomination; for "like us", the peer traits that matter |
| Places | All named states, DC and counties; whether the user means based there or serving there |
| Size floor | Revenue, assets or another stated measure; for client prospecting, default to annual revenue of at least USD 2M |
| Purpose | Partner or peer institution, grantmaker, or prospective client |

The client default looks for organizations large enough to have a development
team. Revenue alone does not prove they have one or need the user's service.
For partners and grantmakers, do not impose the client floor without a reason.

### Step 2. Search across the full geography

Start with `ask_tirion` for a ranked list in one call. Include all four parts
of the ask. Then use `search_nonprofits` separately for every named state,
including DC when requested. For counties, search their states and check
each result's county; do not silently widen a county request to the state.

Use NTEE (National Taxonomy of Exempt Entities) prefixes to search by mission:

| Prefix | Search area |
|---|---|
| X | Religion, churches and ministries |
| B | Education, schools and colleges |
| P | Human services and senior living |
| E | Health, hospitals and health systems |
| A | Arts, culture and museums |

Also search names for the cause and tradition words. Religious schools,
colleges, hospitals and service organizations often have non-X codes.
Search words such as Christian, Presbyterian, Reformed, Catholic and Jewish
across the relevant mission codes, and without a code restriction. A keyword
finds a candidate; it does not settle the classification.

For grantmakers, use `search_foundations_by_cause` and read the matched grant
descriptions. Distinguish the foundation's address from where it makes grants.
Check eligibility and whether it accepts proposals before recommending outreach.

Combine the results and remove duplicates. Check the legal name, location
and filing so a school, its supporting foundation and its parent institution
do not share the same revenue by mistake. State any result limits or unsearched
places. A short result set is not proof that no other organizations exist.

### Step 3. Label tradition and denomination evidence

Say how each organization was classified:

| Evidence label | What it supports |
|---|---|
| Name | An explicit tradition in the organization's name; it may not establish a specific denomination |
| IRS group exemption | The denomination attached to its group exemption, when Tirion returns it; cite the returned record |
| Organization website | Its own affiliation page, mission or statement of faith; link the page and record the date checked |
| Not established | No clear evidence, or sources disagree; describe the gap |

Never infer a denomination from "Grace", "Covenant" or another generic word.
An X code does not establish a denomination. Respect the organization's stated
identity and explain any conflict with an older filing.

For a Reformed search, let the user choose the scope:

| Search scope | Bodies to distinguish |
|---|---|
| Confessional Reformed or Presbyterian | PCA, OPC, ARP, RPCNA, URC, CRC and EPC |
| Mainline Reformed or Presbyterian | PC(USA) and RCA |

Ask whether to include one group or both if the request does not settle it.
Keep them separate while gathering candidates. These groups guide the search;
use each institution's own stated affiliation for its final label.

### Step 4. Assess fit for the purpose

For partners and peers, rank mission, geography and comparable scale. For
grantmakers, rank relevant grants, giving geography and eligibility. For
clients, look for these signals:

| Signal | How to read it |
|---|---|
| Revenue | Compare with the size floor using the latest available return; label its fiscal year |
| Contributions share | Contributions divided by total revenue from the same return and fiscal year; label it calculated, and leave it unavailable if revenue is zero or missing |
| Fundraising expense | Evidence of fundraising activity; missing data is not zero |
| Development or advancement staff | Relevant titles on the 990 and leadership roster; the return is not a full staff directory |
| Recent campaign news | A dated campaign announcement on the organization's site may show a timely need; it does not prove buying intent |

Use `get_board_roster` for leadership and board roles. Verify current staff
on the organization's website before naming a person. Suggest a role such as
development director, advancement vice president, partnerships director or
program officer even when the current person's name is unknown.

Most churches do not file a 990. List churches without public financials
separately as "no public financials". Do not treat missing revenue as zero
or claim they pass the size floor. If a church publishes financial statements,
identify that source and period explicitly; never label it a Form 990.

For a closer reading of a return, use
[nonprofit-990-analysis](../nonprofit-990-analysis/SKILL.md).

### Step 5. Verify or extend the top rows

Check the facts that drive the ranking against public sources:

- The organization's site: current mission, stated tradition, staff and
  campaign news.
- ProPublica Nonprofit Explorer: the underlying return and fiscal year.
- IRS Tax Exempt Organization Search (TEOS): exemption records and available
  filings. A missing church record is not proof it is inactive.

Match the source to the same organization. Every filing figure carries its
form and fiscal year, for example "USD 3.2M (Form 990, FY2024)". Use the same
form and year for a calculated share. For other public financial reports,
name the report and fiscal year instead of inventing a form. Cite website
claims with a link and date. If web access is unavailable, label the top rows
as awaiting public-web verification.

### Step 6. Rank and deliver

Rank by the stated purpose, with a short reason for each position. For a
"by size" request, sort by the requested financial measure and flag different
fiscal years. Do not rank on religious identity beyond the user's stated
organizational fit criteria.

State how many organizations were considered, what was filtered out and
which places were searched. Name filing lag, search limits and missing
financials. Recommend the first few organizations to research or contact next.

## Output template

```markdown
# Organization list: [cause or tradition] in [places]
Prepared by [name], with AI assistance | Unreviewed draft, [date]
Confidential: for internal use by [organization] only

**Purpose and scope.** [Partner, peer, grantmaker or client; all places;
size floor; denomination scope.]

**How this list was built.** [N] organizations considered; [n] meet the
filters; top [n] shown. [Sources searched and coverage limits.]

| Rank | Organization | City/state | Tradition (with evidence) | Revenue (form, FY) | Why it fits | First contact role | Next step |
|---|---|---|---|---|---|---|---|---|
| 1 | [Name] | [City, state] | [Tradition; evidence label and source] | [Amount; Form 990, FYyear; source] | [Purpose-specific reason; form and FY for each figure] | [Role] | [Action] |

**No public financials.** [Churches listed separately, with location,
tradition evidence, fit, first contact role and next step; size unverified.]

**Gaps and verification.** [Missing places, uncertain affiliations, filing
lag and any top rows still awaiting verification.]

**Sources.** [Return links with form and fiscal year; organization pages
with date checked; dated campaign announcements.]
```
