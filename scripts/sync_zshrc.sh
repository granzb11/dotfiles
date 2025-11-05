#!/usr/bin/env bash
set -euo pipefail

# Sync ~/.zshrc into this repo at zsh/.zshrc, commit if changed, optionally push.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$HOME/.zshrc"
DEST_DIR="$REPO_ROOT/zsh"
DEST="$DEST_DIR/.zshrc"
PUSH=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [--push]

Options:
  --push    Push the commit to the configured remote after committing
  -h|--help Show this help
EOF
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --push) PUSH=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done

if [[ ! -f "$SRC" ]]; then
  echo "No $SRC found; nothing to sync." >&2
  exit 1
fi

mkdir -p "$DEST_DIR"
cp -p "$SRC" "$DEST"

cd "$REPO_ROOT"

# Stage only the destination file
git add -- "$DEST"

# If the file is staged with changes, commit it. Otherwise, inform the user.
if git diff --cached --name-only --quiet -- "$DEST"; then
  echo "No changes to commit."
else
  git commit -m "backup: .zshrc ($(date -u +%Y-%m-%dT%H:%M:%SZ))" -- "$DEST"
  echo "Committed $DEST"
  if [ "$PUSH" = true ]; then
    git push
  fi
fi

echo "Synced $SRC -> $DEST"
