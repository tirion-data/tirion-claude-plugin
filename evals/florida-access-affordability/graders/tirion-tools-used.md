---
type: regex
target: trace
pattern: 'tool_use[^\n]{0,400}?name\\?"\s*:\s*\\?"mcp__[A-Za-z0-9_-]+__(search_foundations_by_cause|get_board_roster|discover_prospects|list_people_by_indicator|ask_tirion|create_tirion_report)\b'
---

Passes when Claude called ask_tirion or one of the specific Tirion tools this task needs.
