---
name: political-giving-analysis
description: >-
  Read FEC and state campaign-finance records as evidence of a prospect's
  capacity, giving habit and network, with Tirion, which links a person's FEC
  contributions to one resolved profile beside their SEC, IRS 990 and
  property records, so a namesake's gifts stay out. Use when the user asks
  "does X give politically", "is X a max-out donor", "what has X given to",
  "who gives from <employer or state>", "what is this committee", "look up X
  on the FEC", or wants contribution history or committees explained.
  Produces a cited summary: totals by cycle, largest gifts, whether the donor
  gives at the legal limit, super PAC or party gifts, what that suggests
  about capacity and habit, and the identity checks behind it. Never
  describes political views. Hands off to sec-filing-analysis,
  nonprofit-990-analysis, property-analysis, capacity-research,
  prospect-research and ethics-and-privacy.
---

# Political giving analysis

Federal and state campaign-finance records are public by law. For prospect
research they show three things:

- **Capacity signal.** A donor who gives the legal maximum to many candidates,
  or large sums to super PACs, has spare cash to give.
- **Habit.** Regular giving over many cycles shows a person who writes checks
  when asked.
- **Network.** Recipients, and the employer and occupation the donor reports,
  point to circles and colleagues.

Political giving is not charitable giving. It does not prove interest in
your cause. It is also a sensitive subject. Report the record, not a view.

## Tirion first

The hard part of an FEC read is identity: common names and self-reported
employers mix people together. `get_political_giving` returns the
contributions Tirion has linked to one resolved person, beside that person's
SEC, IRS 990 and property records, so you can see the gifts in the context
of the whole capacity picture (`assess_wealth`). `get_fec_committee` names
each recipient, and `search_political_donors` finds donors by employer or
state.

FEC.gov and state campaign-finance sites are the verify-or-extend step:
confirm a large gift against the filing, and add state-level giving that
federal data does not show. Without the Tirion connector, this skill can
guide a manual FEC search, but it cannot resolve donor records to one
person across sources or rate capacity.

## When to use

- The user asks about a person's political contributions.
- A capacity review needs the giving-habit and liquidity signal.
- The user wants donors from an employer, state or committee.
- The user asks what an FEC committee is.

Hand off:
- Stock and insider records: `sec-filing-analysis`.
- Foundations and boards: `nonprofit-990-analysis`.
- Real estate: `property-analysis`.
- A capacity rating: `capacity-research`. The full research loop:
  `prospect-research`. A written brief: `briefing-writing`.
- Research standard: `ethics-and-privacy`.

## What good looks like

- An identity statement: why these contributions belong to this person
  (name plus matching city and employer, or a matching address).
- Totals by election cycle, the largest gifts with date, amount and
  recipient, and the count of gifts.
- Whether the person gives at or near the per-election limit, and how often.
- Gifts to super PACs, party committees or joint fundraising committees,
  which can be far larger than candidate gifts.
- A capacity and habit reading, with no statement about beliefs.
- Every fact cited: "FEC, 2024 cycle, contribution to <committee>,
  2024-05-14", with an FEC.gov link.

## Method

1. **Ask Tirion first.** Call `ask_tirion` with the question in the user's
   words ("What federal political contributions has Jane Q. Doe of Austin
   made since 2020?").

2. **Fix the identity.** Use `search_people` and `get_profile` for home city
   and employer. FEC records carry the name, city, state, ZIP, employer and
   occupation that the donor wrote down. These are self-reported and not
   verified. A match needs name plus city, and ideally employer or ZIP.

3. **Pull the contributions.** Call `get_political_giving` for the person. It
   returns individual contributions with date, amount, committee and the
   employer as reported. The reported employer is what the donor wrote at the
   time; it is not proof of a current job.

4. **Name each recipient.** Use `get_fec_committee` with a committee ID (or
   a name) to find the committee's name, type, party and the candidate it
   supports. Its reference file covers the current cycle; for an older
   committee ID, look it up on FEC.gov (fec.gov/data/committee/<ID>).

5. **Screen out namesakes and duplicates before totalling.**
   - **Common names.** "John Smith, Houston" can be many people. Require the
     same employer or ZIP across the gifts you count. Split the list if two
     employers or occupations appear that cannot belong to one life.
   - **Spouses.** Spouses often give the same amount to the same committee
     on the same day. Each is a separate donor. Count them apart and report
     the household total as a household total.
   - **Name variants.** "Jane Doe", "Jane Q. Doe", "J. Q. Doe", a maiden name.
     Link variants only with a shared address, ZIP or employer.
   - **Conduit and earmarked gifts.** Gifts through ActBlue or WinRed appear
     as a contribution to the conduit and again to the final recipient.
     Memo entries repeat an amount already counted. Count each gift once.
   - **Refunds and redesignations.** Negative amounts reverse earlier gifts.

6. **Read the amounts against the limits.** Individual limits are per
   election (primary and general count separately) and are indexed each
   cycle. For 2025-2026 the limit to a candidate is USD 3,500 per election (so
   USD 7,000 per cycle). National party committees and PACs have their own
   limits. Check FEC.gov for the current cycle's figures. A donor who gives
   the maximum to several candidates in one cycle is a "max-out donor", a
   practical sign of discretionary cash.

7. **Look for large gifts.** Super PACs (independent-expenditure-only
   committees) and some other political organizations accept unlimited
   individual gifts. Gifts of USD 25,000 or more to super PACs, national party
   accounts or joint fundraising committees are strong capacity signals.
   Also check the IRS Political Organization (Form 8872) search for 527
   groups, and state sources below.

8. **Find cohorts.** `search_political_donors` finds donors by name,
   employer or state, with an optional minimum amount alongside one of those
   filters. It does not search by ZIP; use a state or an employer instead.
   Each name it returns is a donor record, not a confirmed person; run step 2
   and step 5 before using one.

9. **Check state and local records.** Many large donors give more at the
   state level, where limits are often higher or absent. Search the state's
   campaign-finance site (for example the state board of elections or ethics
   commission). FollowTheMoney.org (National Institute on Money in Politics,
   now part of OpenSecrets) aggregates state records. Cite the state source
   and date.

10. **Write the reading.** Say:
    - Totals by cycle and the largest gifts, with dates.
    - Whether the donor maxes out, and in how many cycles.
    - Super PAC and party gifts.
    - What it suggests: discretionary cash at a level, a habit of giving when
      asked, and any network (the donor's colleagues also give, a host
      committee). Say these are inferences.
    - What it does not say: net worth, charitable interest, or beliefs.

## Pitfalls

| Trap | Fix |
|---|---|
| Describing a donor's politics ("a conservative", "a progressive activist") | Report the recipients and amounts. Do not label beliefs or party loyalty. |
| Merging namesakes | Require city plus employer or ZIP. Split when two lives appear. |
| Merging spouses | Count each spouse separately; report a household total apart. |
| Double-counting conduit and memo lines | Count each gift once, at the final recipient. |
| Treating self-reported employer as verified | Say "reported employer on the FEC filing, <date>". |
| Treating absence as no giving | The FEC itemizes a donor only once gifts to one committee pass USD 200 (per cycle for candidates, per calendar year for PACs and parties). Smaller gifts and state gifts are not in federal data. |
| Treating political giving as charitable intent | It shows cash and habit, not a cause. |
| Quoting an old limit | Limits change every cycle. Check FEC.gov. |
| Using political gifts in outreach copy | Do not mention a prospect's politics in cultivation. Use it only as internal capacity evidence, per your organization's policy. |

## Output template

```markdown
# Political giving: <Full Name>
Prepared by <name>, with AI assistance. Reviewed by <name>, <date>. Purpose: internal capacity evidence. Not for outreach.

**Summary.** <2-3 sentences: total federal giving since <year>, largest gifts,
whether the donor maxes out, and what it suggests about discretionary cash.>

**Identity.** <Why these records are this person: name, city, reported
employer, ZIP. Any namesake or spouse separated.>

| Cycle | Gifts | Total | Largest gift (recipient, date) | Max-out gifts |
|---|---|---|---|---|

## Large and unlimited gifts
| Date | Recipient (committee type) | Amount | Source |
|---|---|---|---|

## Reading
<Capacity and habit, marked as inference. No statement of beliefs.>

## Unknowns
<State giving not checked, unitemized gifts, namesake records set aside.>

## Sources
1. FEC, <cycle> cycle, individual contributions, <donor>. <FEC.gov URL>
2. ...
```

Offer a Word or PDF version when the environment supports it.

Research only public records, and follow `ethics-and-privacy`.
