# melbnights

<p align="center">
  <img width="480" alt="Alain Delon in Purple Noon" src="https://github.com/jenul-ferdinand/melbnights/releases/download/assets/purple-noon.gif" />
</p>

What's on in Melbourne: cheap nights, raves, clubs, bars, gigs.

No app, no UI. Open this repo in Claude Code (or Codex) and ask:

```
/whats-on tonight
/whats-on saturday rave
/whats-on weekend cheap
```

The agent reads `venues.json` (recurring weekly nights like Tightarse Tuesday), pulls one-off events from Resident Advisor and the sites in `sources.md`, caches the result in `events/`, and answers.

## Contributing a venue or night

Edit `venues.json`. The recurring nights are the valuable part; nothing else on the internet lists them in one place. Set `verified` to the date you last checked it.

## Requirements

`curl`, `jq`, and an agent with web access.
