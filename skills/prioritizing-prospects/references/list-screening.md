# Screening a spreadsheet

## Before you start

- Confirm the user may screen these people. A donor or alumni file screened for the organization's own fundraising is standard practice. For EU or UK residents, data-protection law applies; see the ethics-and-privacy skill.
- Ask what the list is for (event, reunion, portfolio, campaign). It sets the capacity floor and what to verify.

## 1. Map the columns

Call `get_screening_template`. It returns:
- the column slots a screening accepts (name or full name, address, city, state, ZIP, employer),
- which slots are required,
- how the user's other columns ride along,
- the row identifier convention that lets results be written back beside the source rows,
- the row limit.

Map the user's headers to those slots. Keep the user's own row ID in every row. Clean obvious problems first: split "Smith, John and Mary" into two people only if the user wants spouses screened separately; fix state names to two-letter codes; keep ZIP as text so leading zeros survive.

## 2. Run it

`bulk_enrich` with the rows. Each row needs a name or an address. Rows beyond the row limit are not processed, and the summary says the list was truncated. Split a large file into batches and keep the row IDs.

Each row returns a status:
- **resolved:** matched to one profile.
- **ambiguous:** several possible people, listed as candidates. Do not pick one without a second fact.
- **unresolved:** no confident match. It does not mean the person has no wealth.
- **invalid:** the row lacked a name and an address.
- **error / timeout:** the lookup failed. Retry the row; do not read it as "no match".

And a match method:
- **name+address:** strongest.
- **name:** weaker; confirm with city or employer.
- **address_only:** the county's recorded owner of that address. May be a trust, a company or a previous owner.

Co-owned property: when one owner resolves and others do not, the resolved person comes back with the other owner names. Do not describe the property as solely theirs.

For a single row that needs a closer look, `enrich_prospect` gives a match confidence; scores below 0.40 are not resolved.

## 3. Saved screenings

When a screening was started in the Tirion app, use:
- `get_screening_status` to poll progress. It reports rows written so far; it never claims the job finished on counts alone. Wait for a clear finish before summarizing.
- `get_screening_results`, view `core` for linked rows and `needs_review` for ambiguous, no-match and proposed rows. With detail on (up to 25 rows per call) it adds the capacity band and parcel detail.

## 4. Verify the top matches by hand

Do this for every row that would be tier A or B, before anyone contacts the person:

1. **Identity.** Name, city and one more fact (employer, age range, spouse, address) match the input row.
2. **Profile coherence.** The facts fit one life. Roles in many states, or careers that cannot belong to one person, suggest two namesakes were joined. Flag and hold.
3. **Capacity basis.** Read what drives the band (property, SEC holdings, a foundation). Check the most important item against the public record (county assessor, SEC EDGAR).
4. **Co-ownership and entities.** A trust or LLC owner is not the person until a filing ties them.
5. **Staleness.** Note the date of each key record.

Record for each verified row: verified by whom, date, what was checked.

## 5. Report the screening

```markdown
**Screening summary.** [N] rows submitted; [n] resolved ([n] name+address, [n] name only, [n] address only); [n] ambiguous; [n] unresolved; [n] errors retried. [n] top rows verified by hand; [n] held for identity questions.
```

Then rank the verified rows with the scoring rubric.

## Pitfalls

- A resolved row is a match proposal, not a verified identity.
- An unresolved row is a gap in matching, not evidence of low capacity.
- Errors and timeouts are failures to retry, not empty results.
- Screening scores are for triage. The rating that goes into the organization's system should be the verified one.
