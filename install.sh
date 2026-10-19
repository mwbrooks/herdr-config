#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HERDR_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/herdr"

if ! command -v herdr >/dev/null 2>&1; then
  echo "Error: herdr is not installed. See https://herdr.dev/docs/install/" >&2
  exit 1
fi

# Symlink each tracked file into place, backing up any pre-existing real file.
link_file() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ "$(readlink "$dest" || true)" != "$src" ]; then
    local backup
    backup="$dest.backup-$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $dest -> $backup"
    mv "$dest" "$backup"
  fi
  echo "Linking $dest -> $src"
  ln -sf "$src" "$dest"
}

mkdir -p "$HERDR_CONFIG_DIR"
link_file "$REPO_DIR/config.toml" "$HERDR_CONFIG_DIR/config.toml"

# herdr silently falls back to defaults for invalid values, so surface diagnostics here.
herdr config check

# Apply to a running server; when herdr isn't running, the config loads on next start.
if herdr server reload-config >/dev/null 2>&1; then
  echo "Reloaded config in the running herdr server."
else
  echo "herdr server not running - config will load on next start."
fi

echo
echo "Done."
