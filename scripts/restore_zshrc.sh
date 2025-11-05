#!/usr/bin/env bash
set -euo pipefail

# Restore zsh/.zshrc from the repo to ~/.zshrc.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/zsh/.zshrc"
DEST="$HOME/.zshrc"

usage() {
  cat <<EOF
Usage: $(basename "$0")

This script restores the repo copy of .zshrc to your home directory.
If a .zshrc already exists it will be backed up to ~/.zshrc.YYYYMMDDTHHMMSSZ.bak
EOF
  exit 1
}

if [[ ! -f "$SRC" ]]; then
  echo "No backup file found in repo at: $SRC" >&2
  exit 1
fi

if [[ -f "$DEST" ]]; then
  BACKUP="$DEST.$(date -u +%Y%m%dT%H%M%SZ).bak"
  cp -p "$DEST" "$BACKUP"
  echo "Existing $DEST backed up to $BACKUP"
fi

mkdir -p "$(dirname "$DEST")"
cp -p "$SRC" "$DEST"
echo "Restored $SRC -> $DEST"
