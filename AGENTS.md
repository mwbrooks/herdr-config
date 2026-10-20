# AGENTS.md

Guidance for AI coding agents working in this repository.

## Repository purpose

Personal [herdr](https://herdr.dev/) configuration, migrated from [tmux-config](https://github.com/mwbrooks/tmux-config). Tracked artifacts: `config.toml` (the herdr config), `install.sh` (the bootstrap, which symlinks `config.toml` to `~/.config/herdr/config.toml`), and `sort-spaces.sh` (sorts spaces alphabetically once via the socket API's `workspace.move_block`, since herdr has no sort setting).

## Common commands

```sh
./install.sh                 # idempotent: backs up existing config, symlinks this one, validates, reloads
herdr config check           # validate config.toml and print diagnostics
herdr server reload-config   # apply edits to a running herdr (or <prefix> R inside herdr)
herdr --default-config       # print every setting with its default
./sort-spaces.sh             # sort spaces alphabetically (one-shot; re-run after adding spaces)
shellcheck *.sh              # only lint that applies; there is no test suite or build step
```

## Architecture notes

- `install.sh` is the source of truth for setup steps. The README describes its behavior - keep them in sync when changing one.
- `config.toml` is symlinked, so edits take effect on the next reload with no copy step.
- Prefer herdr defaults. Only add settings that intentionally differ from `herdr --default-config`. The user is learning herdr and wants its defaults unless there's a reason.
- Keybindings in `[keys]` replace the default for that action, so each array keeps herdr's default binding first and adds the tmux-habit alias after it. Don't drop the default entry.
- Use literal punctuation in key strings (`prefix+|`, `prefix+$`). Named forms like `pipe` and `dollar` are rejected; `minus`, `comma`, `ampersand`, `plus`, and `backtick` are accepted.
- Invalid config values don't fail loudly: herdr disables the binding and falls back. Always run `herdr config check` after editing.
- Herdr docs for agents: https://herdr.dev/llms.txt. Config reference: https://herdr.dev/docs/config-reference/.

## Conventions

- Scripts run under `set -euo pipefail`. Preserve that and quote expansions when editing.
- The script must remain idempotent.
- Comments in `config.toml` document the *why* (which tmux habit a binding preserves, why a setting differs from default). Don't restate what a key obviously does.
- Keep the README cheat sheet in sync with `config.toml`.
