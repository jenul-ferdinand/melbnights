#!/usr/bin/env bash
# Resident Advisor listings for Melbourne (RA area id 2).
# usage: scripts/ra.sh 2026-09-26 2026-09-27
# Prints one line per event: date | startTime | venue | title | artists | url
set -euo pipefail
from=${1:-$(date +%F)}
to=${2:-$from}
curl -sf -m 30 'https://ra.co/graphql' \
  -H 'content-type: application/json' -H 'user-agent: Mozilla/5.0' \
  --data "$(cat <<EOF
{"variables":{"filters":{"areas":{"eq":2},"listingDate":{"gte":"$from","lte":"$to"}},"pageSize":100,"page":1},
 "query":"query(\$filters: FilterInputDtoInput, \$pageSize: Int, \$page: Int) { eventListings(filters: \$filters, pageSize: \$pageSize, page: \$page) { data { event { title date startTime contentUrl venue { name } artists { name } } } } }"}
EOF
)" | jq -r '.data.eventListings.data[].event
  | [ (.date[:10]), (.startTime[11:16]), .venue.name, .title,
      ([.artists[].name] | join(", ")), ("https://ra.co" + .contentUrl) ]
  | join(" | ")'
# ponytail: page 1 only (100 events); loop over pages if a weekend ever exceeds that
