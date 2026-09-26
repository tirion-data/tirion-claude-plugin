# Template: event or trip briefing packet

For a gala, dinner, reception, board retreat, or a multi-stop trip. The packet has
three parts: an overview page, one card per attendee or visit, and a list of
unconfirmed people. Each card fits on half a page to one page.

## Building the packet

1. Get the list: names, and any detail the host has (city, employer, company,
   guest-of). Screen a long list with `bulk_enrich` first.
2. Sort each name into one of three groups:
   - **Priority**: high capacity, a strong tie, or a planned conversation. Full
     card.
   - **Other confirmed**: a short card (role, interests, tie to us, one talking
     point).
   - **Unconfirmed**: identity not settled. No facts beyond the name and the
     candidates.
3. Research priority guests at one-page-brief depth (see
   [one-page-briefing.md](one-page-briefing.md)).
4. Look for connections among guests and to our people: `find_connections` for
   pairs, `get_relationships` for each priority guest, and shared boards from
   `get_nonprofit_connections` and `get_board_roster`.
5. Write the overview last.

For a trip, add the visit schedule and route to the overview. Choosing whom to
visit is the job of trip-and-event-planning. This packet briefs the visits once
the list is set.

## Overview page

```markdown
# <Event or trip name>: briefing packet
**Confidential: for internal use**
Prepared <YYYY-MM-DD> by <name or team> for <reader(s)>.
Purpose: prepare <our attendees> for <event> on <date> at <place>.

## Summary
<3-5 sentences: who is in the room and why it matters; the top 3 conversations
to have; any sensitivity; how many guests are unconfirmed.>

## Our goals for the event
1. <goal>
2. <goal>

## Priority conversations
| Guest | Why they matter | Capacity (tier) | Our lead | Goal of the conversation |
|---|---|---|---|---|

## Connections in the room
- <Guest A> and <Guest B> serve together on <board> [n]. <Our trustee> knows <Guest C> through <...> [n].

## Handle with care
- <neutral, sourced items; or "None known.">

## All guests
| Name | Role and organization | City | Tie to us | Card |
|---|---|---|---|---|

## Unconfirmed guests
| Name as listed | Possible matches | Question that settles it | Who can answer |
|---|---|---|---|
| Jane Doe | (1) Jane A. Doe, board chair, Acme, Columbus OH; (2) Jane Doe, physician, Dayton OH | Which Jane Doe accepted? Does the RSVP show an employer or city? | Event registrar |
```

For a trip, add:

```markdown
## Schedule
| Date and time | Visit | Place | Our attendee | Goal |
|---|---|---|---|---|
```

## Priority guest card

```markdown
### <Full name>, <title, organization>, <city>
**Why they matter:** <one line>.
**Capacity:** <tier label, range>; driver: <one line> [n]. Confidence: <level>.
**Interests:** <causes, boards, named gifts> [n]
**Tie to us:** <degree, gift, volunteer role, mutual contact> [n]
**Recent:** <YYYY-MM-DD event> [n]
**Talking points:** 1. <...> 2. <...>
**Handle with care:** <or "None known.">
**Our lead and goal:** <name>; <goal>.
```

## Short card (other confirmed guests)

```markdown
### <Full name>, <title, organization>, <city>
<One or two lines: role, interests, tie to us.> [n]
**Talking point:** <...>
```

## Volunteer version

When the packet goes to board members or volunteer hosts, remove capacity and
asset figures. Keep role, interests, ties, talking points and handle-with-care
notes.

## Sources

End the packet with one numbered Sources list shared by all cards: record or
publication, date, URL.

## Rules for unconfirmed guests

- Do not attach any capacity, wealth, giving or news fact to an unconfirmed name.
- List every candidate you found, with the fact that separates each one.
- Write one concrete question that would settle identity, and who can answer it.
- A plus-one known only by first name is "guest of (name)", unconfirmed.
- When the question is answered, move the person to the right group and write the
  card.
