#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT="$SCRIPT_DIR/../closed-issues/index.html"
ORG="sw-embed"

TMPDIR_WORK=$(mktemp -d)
trap 'rm -rf "$TMPDIR_WORK"' EXIT

REPOS=$(gh api "/orgs/$ORG/repos?per_page=100" --jq '.[].name' | grep -E '^sw-cor24-|^cor24-' | sort)

echo "Fetching closed issues..."
for repo in $REPOS; do
  PAGE=1
  while true; do
    RESP=$(gh api "/repos/$ORG/$repo/issues?state=closed&per_page=100&page=$PAGE" 2>/dev/null || echo '[]')
    COUNT=$(echo "$RESP" | jq length)
    [ "$COUNT" -eq 0 ] && break
    echo "$RESP" | jq -r --arg repo "$repo" --arg org "$ORG" \
      '.[] | "\(.closed_at[:10])\t\($repo)\t\(.number)\t\(.title | gsub("&";"&amp;") | gsub("\"";"&quot;") | gsub("<";"&lt;") | gsub(">";"&gt;"))\t\($org)"' \
      >> "$TMPDIR_WORK/issues.tsv"
    PAGE=$((PAGE + 1))
  done
done

TOTAL_ISSUES=$(wc -l < "$TMPDIR_WORK/issues.tsv" | tr -d ' ')
ALL_DATES=$(cut -f1 "$TMPDIR_WORK/issues.tsv" | sort -u)
NUM_DATES=$(echo "$ALL_DATES" | wc -l | tr -d ' ')
NUM_REPOS=$(echo "$REPOS" | wc -l | tr -d ' ')

DAY_FMT() {
  local d="$1"
  if [[ "$OSTYPE" == darwin* ]]; then
    date -j -f '%Y-%m-%d' "$d" '+%a %b %d'
  else
    date -d "$d" '+%a %b %d'
  fi
}

TH="<th>repo</th>"
while IFS= read -r d; do
  TH="${TH}<th>$(DAY_FMT "$d")</th>"
done <<< "$ALL_DATES"

ROWS=""
while IFS= read -r repo; do
  ROW="<th class=\"repo\"><a href=\"https://github.com/$ORG/$repo\">$repo</a></th>"
  while IFS= read -r d; do
    CELL_ISSUES=$(awk -F'\t' -v repo="$repo" -v date="$d" \
      '$2 == repo && $1 == date { printf "<a href=\"https://github.com/%s/%s/issues/%s\" title=\"%s\">#%s</a>\n", $5, $2, $3, $4, $3 }' \
      "$TMPDIR_WORK/issues.tsv")
    if [ -n "$CELL_ISSUES" ]; then
      LC=$(echo "$CELL_ISSUES" | wc -l | tr -d ' ')
      if [ "$LC" -gt 1 ]; then
        CELL="<div class=\"subgrid\">$(echo "$CELL_ISSUES" | tr -d '\n')</div>"
      else
        CELL=$(echo "$CELL_ISSUES" | tr -d '\n')
      fi
      ROW="${ROW}<td class=\"c\">${CELL}</td>"
    else
      ROW="${ROW}<td class=\"c\"></td>"
    fi
  done <<< "$ALL_DATES"
  ROWS="${ROWS}<tr>${ROW}</tr>"
done <<< "$REPOS"

mkdir -p "$(dirname "$OUTPUT")"

cat > "$OUTPUT" <<HTMLEOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>sw-embed Closed Issues</title>
<style>
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; margin: 1.5rem; background: #0d1117; color: #c9d1d9; }
  h1 { font-size: 1.4rem; margin-bottom: 0.25rem; }
  .meta { font-size: 0.85rem; color: #8b949e; margin-bottom: 1rem; }
  .scroll { overflow-x: auto; overflow-y: auto; max-height: 95vh; }
  table { border-collapse: collapse; font-size: 0.8rem; }
  th, td { border: 1px solid #30363d; padding: 4px 8px; text-align: left; }
  th { background: #161b22; position: sticky; top: 0; z-index: 2; white-space: nowrap; }
  th.repo { text-align: left; position: sticky; left: 0; z-index: 3; background: #161b22; }
  th:first-child { z-index: 4; position: sticky; left: 0; top: 0; }
  td.c { text-align: center; vertical-align: top; white-space: normal; min-width: 50px; }
  td:first-child { position: sticky; left: 0; background: #0d1117; z-index: 1; }
  a { color: #58a6ff; text-decoration: none; white-space: nowrap; }
  a:hover { text-decoration: underline; }
  .subgrid {
    display: inline-grid;
    grid-template-columns: repeat(5, auto);
    gap: 1px 8px;
    justify-content: center;
  }
</style>
</head>
<body>
<h1>sw-embed &mdash; Closed Issues by Repo &amp; Date</h1>
<p class="meta">${NUM_REPOS} repos &middot; ${TOTAL_ISSUES} issues &middot; ${NUM_DATES} days</p>
<div class="scroll">
<table>
<thead><tr>${TH}</tr></thead>
<tbody>
${ROWS}
</tbody>
</table>
</div>
</body>
</html>
HTMLEOF

echo "Generated $OUTPUT ($NUM_REPOS repos, $TOTAL_ISSUES issues, $NUM_DATES days)"
