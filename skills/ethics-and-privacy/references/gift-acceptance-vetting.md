# Gift-acceptance and reputational-risk vetting

Vetting protects the organization and the donor. Run it before a large gift, a naming gift, a board appointment, or any gift the gift-acceptance policy flags.

## Steps

1. **Confirm identity.** Full legal name, middle name or initial, city, employer, approximate age, spouse. Use `ask_tirion` and `search_people`, then `get_profile` and `get_entity_facts`. Never vet a name alone.
2. **Sanctions screening.**
   - US: OFAC Specially Designated Nationals and Blocked Persons (SDN) list and the consolidated non-SDN lists, through the Treasury Sanctions List Search (sanctionssearch.ofac.treas.gov).
   - UK: the OFSI consolidated list of financial sanctions targets.
   - EU: the EU consolidated list of financial sanctions.
   - UN: the UN Security Council consolidated list.
   - Record the date of each search and the result. A fuzzy name hit needs identity confirmation (date of birth, nationality, address on the list entry).
3. **Politically exposed person (PEP) check** for foreign donors: senior government, military, judicial or state-company roles, and their close family. Use public government sources and reputable news.
4. **Enforcement and litigation.** SEC litigation releases and administrative proceedings; DOJ press releases; state attorney-general actions; FINRA BrokerCheck for registered brokers; federal court records (PACER) and state court records for the prospect's county.
5. **Adverse media.** Reputable outlets only. Use `get_news_mentions` for coverage Tirion holds; check whether each mention is about this person before relying on it. Add a web search with the name plus terms such as fraud, lawsuit, indicted, sanctions, investigation.
6. **Source of wealth.** Does the public record explain the wealth? Use `get_sec_filings` (company roles, sales), `get_property_portfolio`, `get_nonprofit_connections`, `search_foundations`. A large gift with no visible source of wealth is not a red flag by itself; private wealth is common. Note it as an open question.
7. **Organizational ties.** If the gift comes through a company or foundation, vet that entity too: `search_nonprofits` or `get_board_roster` for foundations, and the company's filings.

## Reporting

Write a short vetting memo, separate from any cultivation briefing:

- Purpose and date of the review.
- Identity confirmed by: [facts].
- Sanctions: lists searched, date, result.
- Enforcement and litigation: findings with citations, or "none found in [sources] as of [date]".
- Adverse media: findings with outlet and date.
- Source of wealth: summary with citations.
- Open questions and recommendation: "no concerns found", or "refer to the gift-acceptance committee because ...".

State findings neutrally. The committee decides. Research does not.

## Pitfalls

- A name match is not a finding. Confirm identity with at least two independent facts.
- Absence of adverse media is "none found in [sources] as of [date]", not "clean".
- Do not carry vetting findings into cultivation briefings unless the committee decides they belong there.
