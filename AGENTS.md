# melbnights

Event finder for Melbourne: cheap nights, raves, clubs, bars, gigs. There is no app. The agent (Claude Code, Codex) IS the app; this repo is its knowledge and its tools.

## Files

- `venues.json`: curated venues with vibe tags and recurring weekly nights (e.g. Tightarse Tuesday at the Hawthorn Hotel). This is the part the internet does not have in one place. Grow it.
- `sources.md`: where to look for one-off events, with URLs the agent can fetch directly.
- `scripts/ra.sh <from> <to>`: Resident Advisor listings for Melbourne as JSON. Covers raves, club nights, warehouse parties.
- `events/YYYY-MM-DD.md`: cache of what was found for a given date. Reuse if less than 24h old.
- `.claude/skills/whats-on/`: the `/whats-on` command.

## Answering "what's on"

1. Work out the target date(s). "tonight" = today, "weekend" = Fri-Sun, "tuesday" = the next Tuesday.
2. Check `events/<date>.md`. If fresh, answer from it.
3. Recurring nights: filter `venues.json` for entries whose `weekly` has that weekday.
4. One-offs: run `scripts/ra.sh <date> <date>`, then WebFetch the sources in `sources.md` that match the vibe asked for.
5. Write the merged list to `events/<date>.md` (format below), then answer from it.

Event line format, one per line, sorted by start time:

```
- 21:00 | Venue, Suburb | Title | $price or free | vibe tags | url
```

Unknown price: `$?`. No url: omit.

## Rules

- Never invent an event. If a source returned nothing, say so.
- Recurring nights in `venues.json` can go stale. If a fetched venue page contradicts the file, fix the file in the same turn.
- When the user mentions a venue or night that is not in `venues.json`, add it.
- Keep answers short: the list, then one line on the best pick for the vibe asked.
