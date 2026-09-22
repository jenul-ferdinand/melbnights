---
name: whats-on
description: Find what's on in Melbourne for a day or weekend, with an optional vibe (rave, cheap, uni, gig, bar). Use for "/whats-on", "what's on tonight", "anything on friday", "where should we go this weekend".
---

Arguments: `$ARGUMENTS` = `[tonight|tomorrow|<weekday>|weekend|YYYY-MM-DD] [vibe words...]`. Default: tonight, any vibe.

Follow "Answering what's on" in AGENTS.md. Concretely:

1. Resolve the date(s) with `date`. Weekend = next Fri, Sat, Sun.
2. For each date, if `events/<date>.md` exists and its `fetched:` line is under 24h old, use it and skip to 6.
3. `jq` over `venues.json` for `.weekly[<ddd>]` entries. Include only those matching the vibe if one was given.
4. `scripts/ra.sh <date> <date>` for club/rave listings. Fetch other `sources.md` URLs only if the vibe calls for them (gig -> Beat, bar -> Broadsheet, cheap/uni -> Eventbrite free + WebSearch).
5. Write `events/<date>.md`:
   ```
   fetched: <ISO timestamp>
   - HH:MM | Venue, Suburb | Title | $price | tags | url
   ```
6. Reply with the list (filtered to vibe), then one line: the pick for the night and why.
