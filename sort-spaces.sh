#!/usr/bin/env bash
set -euo pipefail

# herdr has no setting to keep spaces sorted, so this reorders them once, by name
# (case-insensitive). New spaces still land at the bottom; re-run to tidy up.

for cmd in herdr jq nc; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd is required." >&2
    exit 1
  fi
done

SOCKET="${HERDR_SOCKET_PATH:-${XDG_CONFIG_HOME:-$HOME/.config}/herdr/herdr.sock}"

sorted_ids="$(herdr workspace list \
  | jq -c '[.result.workspaces | sort_by(.label | ascii_downcase)[] | .workspace_id]')"

# `herdr workspace` has no move subcommand, so call the socket API directly. With no
# anchor, move_block appends the ids in the given order, which reorders every space at once.
response="$(jq -cn --argjson ids "$sorted_ids" \
    '{id: "sort-spaces", method: "workspace.move_block", params: {workspace_ids: $ids}}' \
  | nc -U -w 2 "$SOCKET")"

if ! jq -e '.result' >/dev/null <<<"$response"; then
  echo "Error: herdr rejected the reorder: $response" >&2
  exit 1
fi

herdr workspace list | jq -r '.result.workspaces[] | "\(.number). \(.label)"'
