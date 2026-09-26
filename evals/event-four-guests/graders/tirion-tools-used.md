---
type: regex
target: trace
pattern: 'tool_use[^\n]{0,400}?name\\?"\s*:\s*\\?"mcp__[A-Za-z0-9_-]+__(search_people|get_profile|assess_wealth|get_capacity|get_relationships|find_connections|get_nonprofit_connections|bulk_enrich|ask_tirion|create_tirion_report)\b'
---

Passes when Claude called ask_tirion or one of the specific Tirion tools this task needs.
