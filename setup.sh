#!/usr/bin/env bash
# Fills in your name, GitHub username and email across every file.
# Run this ONCE, before your first push:   bash setup.sh
set -euo pipefail

read -rp "Your display name (e.g. Ayush Srivastava): " AUTHOR
read -rp "Your GitHub username (exactly, case-sensitive): " USERNAME
read -rp "Your public email (or leave blank): " EMAIL
read -rp "Blog tagline (e.g. Notes on systems and inference): " TAGLINE

[ -z "$EMAIL" ] && EMAIL="hello@example.com"

# Escape forward slashes and ampersands for sed
esc() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

for f in index.html about.html posts/*.html robots.txt sitemap.xml README.md; do
  [ -f "$f" ] || continue
  sed -i.bak \
    -e "s/{{AUTHOR}}/$(esc "$AUTHOR")/g" \
    -e "s/{{USERNAME}}/$(esc "$USERNAME")/g" \
    -e "s/{{EMAIL}}/$(esc "$EMAIL")/g" \
    -e "s/{{TAGLINE}}/$(esc "$TAGLINE")/g" \
    "$f"
  rm -f "$f.bak"
  echo "  updated $f"
done

echo
echo "Done. Your site will live at: https://${USERNAME}.github.io/"
echo "Next: create the repo named exactly '${USERNAME}.github.io' on GitHub, then:"
echo "  git init && git add -A && git commit -m 'first post'"
echo "  git branch -M main"
echo "  git remote add origin https://github.com/${USERNAME}/${USERNAME}.github.io.git"
echo "  git push -u origin main"
