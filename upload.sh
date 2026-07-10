#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILE="${1:-}"
SUBDIR="${2:-}"

if [[ -z "$FILE" ]]; then
  echo "Usage: $0 <image-file> [subdir/]"
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "Error: file not found: $FILE"
  exit 1
fi

FILENAME="$(basename "$FILE")"
DEST_DIR="$SCRIPT_DIR"
if [[ -n "$SUBDIR" ]]; then
  DEST_DIR="$SCRIPT_DIR/$SUBDIR"
  mkdir -p "$DEST_DIR"
fi

DEST="$DEST_DIR/$FILENAME"

cp "$FILE" "$DEST"

cd "$SCRIPT_DIR"
git add "$DEST"
git commit -m "Add image: ${SUBDIR}${FILENAME}" || true
git push origin main

echo "Uploaded. Pages URL:"
echo "https://caden1225.github.io/image-bed/${SUBDIR}${FILENAME}"
