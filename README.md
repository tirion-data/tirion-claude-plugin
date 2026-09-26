# Tirion for Claude

Wealth intelligence for fundraisers and prospect researchers.

This plugin connects Claude to [Tirion Data](https://tiriondata.com) and teaches it to work like a senior prospect-research analyst. Ask in plain words: "Who in Palm Beach should I see next week?", "How much could this person give?", "Write a briefing for Thursday's dinner." Claude answers with a conclusion, the public records behind it, and a next step.

## What's inside

**The Tirion connector** (`https://mcp.tiriondata.com/mcp`). It covers people and their wealth signals, SEC insider filings, IRS Form 990 board roles and foundation grants, property ownership, FEC political giving, news, and area wealth. Sign in with your Tirion account the first time Claude uses it.

**Skills.** Claude loads each one when a request needs it.

| Skill | Use it to |
|---|---|
| `prospect-research` | Research one person or organization end to end, with a quality check before anything goes out |
| `capacity-research` | Estimate 3–5 year giving capacity as a range, with the assets behind it |
| `bio-writing` | Write a sourced professional biography (short, standard or long) |
| `briefing-writing` | Write a one-page meeting briefing, an in-depth profile, or an event packet |
| `trip-and-event-planning` | Plan a donor trip itinerary or research an event guest list |
| `finding-prospects` | Find prospects by cause and place, wealth signal, affinity or liquidity event |
| `prioritizing-prospects` | Qualify and tier a pool or portfolio; screen a list |
| `market-and-liquidity-intelligence` | Understand wealth in a place, and act on M&A, IPOs and big stock sales |
| `sec-filing-analysis` | Read Forms 3/4/5, 13D/G, proxies, S-1s and 8-Ks for prospect research |
| `nonprofit-990-analysis` | Read Forms 990 and 990-PF: board roles, grants, foundation assets |
| `property-analysis` | Read real estate records: assessed vs market value, trusts and LLCs, second homes |
| `political-giving-analysis` | Use FEC records as a capacity and affinity signal, with care |
| `ethics-and-privacy` | The research standard every skill follows (Apra Principles of Ethics and Compliance, Donor Bill of Rights) |

## Install

In Claude Code:

```
/plugin marketplace add tirion-data/tirion-claude-plugin
/plugin install tirion@tirion
```

In the Claude apps, install **Tirion** from the plugin directory.

You need a Tirion account. Get one at [tiriondata.com](https://tiriondata.com).

## Principles

- **Public records, cited.** Every material fact names its record and date, for example "SEC Form 4, filed 2026-08-24".
- **Identity first.** Claude confirms it has the right person before it researches them, and it never merges two people who share a name.
- **Capacity is a range with its reasons.** It is never a bare number.
- **Ethical by default.** No private contact details and no sensitive personal categories. Research follows the Apra Principles of Ethics and Compliance.

## Support

support@tiriondata.com

## License

Apache 2.0. See [LICENSE](LICENSE).
