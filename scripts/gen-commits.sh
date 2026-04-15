#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT="$SCRIPT_DIR/../commits/index.html"
ORG="sw-embed"

TMPDIR_WORK=$(mktemp -d)
trap 'rm -rf "$TMPDIR_WORK"' EXIT

REPOS=$(gh api "/orgs/$ORG/repos?per_page=100" --jq '.[].name' | grep -E '^sw-cor24-|^cor24-' | sort)

echo "Fetching commits..."
for repo in $REPOS; do
  PAGE=1
  while true; do
    RESP=$(gh api "/repos/$ORG/$repo/commits?per_page=100&page=$PAGE" 2>/dev/null || echo '[]')
    COUNT=$(echo "$RESP" | jq length)
    [ "$COUNT" -eq 0 ] && break
    echo "$RESP" | jq -r --arg repo "$repo" --arg org "$ORG" \
      '.[] | "\(.commit.author.date[:13])\t\($repo)\t\(.sha[:7])\t\(.commit.message | split("\n")[0] | gsub("&";"&amp;") | gsub("\"";"&quot;") | gsub("<";"&lt;") | gsub(">";"&gt;"))\t\($org)"' \
      >> "$TMPDIR_WORK/commits.tsv"
    PAGE=$((PAGE + 1))
  done
done

TOTAL_COMMITS=$(wc -l < "$TMPDIR_WORK/commits.tsv" | tr -d ' ')
ALL_HOURS=$(cut -f1 "$TMPDIR_WORK/commits.tsv" | sort -u)
NUM_HOURS=$(echo "$ALL_HOURS" | wc -l | tr -d ' ')
NUM_REPOS=$(echo "$REPOS" | wc -l | tr -d ' ')

HOUR_FMT() {
  local d="$1"
  local full="${d}:00:00"
  if [[ "$OSTYPE" == darwin* ]]; then
    date -j -f '%Y-%m-%dT%H:%M:%S' "$full" '+%a %b %d %H:00'
  else
    date -d "$full" '+%a %b %d %H:00'
  fi
}

mkdir -p "$(dirname "$OUTPUT")"

write_html() {
  echo '<!DOCTYPE html>'
  echo '<html lang="en">'
  echo '<head>'
  echo '<meta charset="utf-8">'
  echo '<meta name="viewport" content="width=device-width, initial-scale=1">'
  echo '<title>sw-embed Commits</title>'
  echo '<style>'
  echo '  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; margin: 1.5rem; background: #0d1117; color: #c9d1d9; }'
  echo '  h1 { font-size: 1.4rem; margin-bottom: 0.25rem; }'
  echo '  .meta { font-size: 0.85rem; color: #8b949e; margin-bottom: 1rem; }'
  echo '  .scroll { overflow-x: auto; overflow-y: auto; max-height: 95vh; }'
  echo '  table { border-collapse: collapse; font-size: 0.8rem; }'
  echo '  th, td { border: 1px solid #30363d; padding: 4px 8px; text-align: left; }'
  echo '  th { background: #161b22; position: sticky; top: 0; z-index: 2; white-space: nowrap; }'
  echo '  th.repo { text-align: left; position: sticky; left: 0; z-index: 3; background: #161b22; }'
  echo '  th:first-child { z-index: 4; position: sticky; left: 0; top: 0; }'
  echo '  td.c { text-align: center; vertical-align: top; white-space: normal; min-width: 60px; }'
  echo '  td:first-child { position: sticky; left: 0; background: #0d1117; z-index: 1; }'
  echo '  a { color: #58a6ff; text-decoration: none; white-space: nowrap; }'
  echo '  a:hover { text-decoration: underline; }'
  echo '  .subgrid { display: inline-grid; grid-template-columns: repeat(5, auto); gap: 1px 8px; justify-content: center; }'
  echo '</style>'
  echo '</head>'
  echo '<body>'
  echo "<h1>sw-embed &mdash; Commits by Repo &amp; Hour</h1>"
  echo "<p class=\"meta\">${NUM_REPOS} repos &middot; ${TOTAL_COMMITS} commits &middot; ${NUM_HOURS} hours</p>"
  echo '<div class="scroll">'
  echo '<table>'

  printf '<thead><tr><th>repo</th>'
  while IFS= read -r h; do
    printf '<th>%s</th>' "$(HOUR_FMT "$h")"
  done <<< "$ALL_HOURS"
  echo '</tr></thead>'

  echo '<tbody>'
  while IFS= read -r repo; do
    printf '<tr><th class="repo"><a href="https://github.com/%s/%s">%s</a></th>' "$ORG" "$repo" "$repo"
    while IFS= read -r h; do
      CELL_COMMITS=$(awk -F'\t' -v repo="$repo" -v hour="$h" \
        '$2 == repo && $1 == hour { printf "<a href=\"https://github.com/%s/%s/commit/%s\" title=\"%s\">%s</a>\n", $5, $2, $3, $4, $3 }' \
        "$TMPDIR_WORK/commits.tsv")
      if [ -n "$CELL_COMMITS" ]; then
        LC=$(echo "$CELL_COMMITS" | wc -l | tr -d ' ')
        if [ "$LC" -gt 1 ]; then
          printf '<td class="c"><div class="subgrid">%s</div></td>' "$(echo "$CELL_COMMITS" | tr -d '\n')"
        else
          printf '<td class="c">%s</td>' "$(echo "$CELL_COMMITS" | tr -d '\n')"
        fi
      else
        printf '<td class="c"></td>'
      fi
    done <<< "$ALL_HOURS"
    echo '</tr>'
  done <<< "$REPOS"

  echo '</tbody>'
  echo '</table>'
  echo '</div>'
  echo '</body>'
  echo '</html>'
}

write_html > "$OUTPUT"

echo "Generated $OUTPUT ($NUM_REPOS repos, $TOTAL_COMMITS commits, $NUM_HOURS hours)"
