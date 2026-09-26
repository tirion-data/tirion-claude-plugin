---
type: regex
target: trace
pattern: 'tool_use[^\n]{0,400}?name\\?"\s*:\s*\\?"mcp__[A-Za-z0-9_-]+__(resolve_place|get_area_wealth_summary|get_area_prospects|discover_prospects|ask_tirion)\b'
---

Passes when Claude called ask_tirion or one of the specific Tirion tools this task needs.
