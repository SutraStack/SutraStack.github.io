#!/usr/bin/env bash
# Start a new post:  bash new-post.sh "My Post Title"
set -euo pipefail
TITLE="${1:?usage: bash new-post.sh \"My Post Title\"}"
SLUG=$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9]\+/-/g' -e 's/^-//' -e 's/-$//')
DATE=$(date +%Y-%m-%d)
PRETTY=$(date +"%-d %b %Y")
OUT="posts/${SLUG}.html"

[ -e "$OUT" ] && { echo "$OUT already exists"; exit 1; }
sed -e "s/POST TITLE/${TITLE}/g" \
    -e "s/2026-11-01/${DATE}/g" \
    -e "s/1 Nov 2026/${PRETTY}/g" \
    posts/_template.html > "$OUT"

echo "Created $OUT"
echo
echo "Now add this block to index.html, just under the 'Writing' label:"
cat <<HTML

  <a class="post" href="/posts/${SLUG}.html">
    <div class="meta">
      <time datetime="${DATE}">${PRETTY}</time>
      <span class="tag">topic</span>
    </div>
    <h2>${TITLE}</h2>
    <p>One or two sentences that make someone want to click.</p>
    <span class="readmore">Read →</span>
  </a>
HTML
