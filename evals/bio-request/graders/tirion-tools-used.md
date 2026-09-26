---
type: regex
target: trace
pattern: 'tool_use[^\n]{0,400}?name\\?"\s*:\s*\\?"mcp__[A-Za-z0-9_-]+__(get_bio|get_profile|get_entity_facts|get_nonprofit_connections|search_people|ask_tirion)\b'
---

Passes when Claude called ask_tirion or one of the specific Tirion tools this task needs.
