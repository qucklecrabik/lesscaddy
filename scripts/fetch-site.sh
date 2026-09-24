#!/bin/sh
set -eu

SITE_DIR=/srv/site
URL="${TEMPLATES_URL}"

if [ -f "$SITE_DIR/index.html" ] && [ "${FORCE:-0}" != "1" ]; then
  echo "[site-init] сайт уже есть, пропускаю (FORCE=1 для смены шаблона)"
  exit 0
fi

apk add --no-cache curl unzip >/dev/null

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

echo "[site-init] скачиваю $URL"
curl -fsSL "$URL" -o "$tmp/t.zip"
unzip -q "$tmp/t.zip" -d "$tmp/x"

# GitHub archive: <repo>-<branch>/<template>/index.html
pick=$(find "$tmp/x" -mindepth 3 -maxdepth 3 -name index.html -exec dirname {} \; | shuf -n1)
[ -n "$pick" ] || { echo "[site-init] шаблоны не найдены"; exit 1; }

echo "[site-init] выбран шаблон: $(basename "$pick")"
find "$SITE_DIR" -mindepth 1 -delete
cp -a "$pick"/. "$SITE_DIR"/

# Removing the clutter that betrays a "cookie-cutter" feel.
find "$SITE_DIR" \( -name '*.md' -o -name 'LICENSE*' -o -name '.git*' -o -name '*.psd' \) -exec rm -rf {} + 2>/dev/null || true
echo "[site-init] готово"
