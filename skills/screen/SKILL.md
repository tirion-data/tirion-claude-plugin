---
name: screen
description: >-
  Command: /tirion:screen, followed by a pasted list of names (with city,
  address or employer where known). Screens the list with Tirion, which
  resolves each row to one person and attaches a capacity rating, then tiers
  the matches A/B/C and flags rows to verify, with a Tirion report link. Use
  when the user types /tirion:screen or says "screen this list". Runs the
  prioritizing-prospects screening method.
argument-hint: "(paste the list after the command)"
---

# Screen a list

The user asked to screen this list:

$ARGUMENTS

Follow the screening method in
[prioritizing-prospects](../prioritizing-prospects/SKILL.md) and its
[list-screening reference](../prioritizing-prospects/references/list-screening.md).
Follow [ethics-and-privacy](../ethics-and-privacy/SKILL.md) throughout.

## Steps

1. **No list?** If nothing was pasted above or earlier in the conversation,
   ask the user to paste the names, one per line, with city, state, address
   or employer where they have it. Stop.
2. **Map the rows.** Call `get_screening_template` for the accepted columns
   and the row limit. Turn each line into a row with name, and address,
   city, state, ZIP or employer where given. Keep the user's order.
3. **Screen.** Call `bulk_enrich` with the rows, in batches within the row
   limit (about 25 rows). For a list much larger than that, tell the user to
   run it as a saved screening in the Tirion app, and screen the first batch
   here.
4. **Read each row's status and match method.** Resolved on name and address
   is stronger than name only. Address-only matches return the county's
   recorded owner, which may be a trust or a prior owner. List ambiguous and
   unresolved rows apart; never pick between two people.
5. **Verify the top matches.** For each row that would land in tier A or B,
   check that the city and a second fact agree with the input, and check the
   capacity basis with `get_capacity` or `assess_wealth`.
6. **Tier** with the rubric in
   [the scoring rubric](../prioritizing-prospects/references/scoring-rubric.md):
   A (see this quarter), B (cultivate), C (monitor), each with a one-line
   reason. Capacity is a range on the A1 to D4 ladder, in its own column.
7. **Create the Tirion report.** `create_tirion_report` with kind
   "prospect_list", the question "Screening of <n> names: capacity and
   priority tiers", and visibility "private".
8. **Reply** with the report link and PDF link (say that it opens in Tirion
   and each reader must be signed in), then: rows in, resolved, ambiguous,
   unresolved, verified; the tier table; the rows that need the user's
   input; and the top three next steps.

If `create_tirion_report` is not in your tool list, give the tier table in
Markdown and say that the Tirion report was not available.
