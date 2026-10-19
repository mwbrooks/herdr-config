# herdr-config

My personal [herdr](https://herdr.dev/) configuration, migrated from [tmux-config](https://github.com/mwbrooks/tmux-config). It sticks to herdr's defaults and adds a few aliases so tmux muscle memory keeps working.

## Install

```sh
git clone https://github.com/mwbrooks/herdr-config ~/Development/github.com/mwbrooks/herdr-config
cd ~/Development/github.com/mwbrooks/herdr-config
./install.sh
```

The script will:

1. Back up any existing `~/.config/herdr/config.toml` (timestamped).
2. Symlink `~/.config/herdr/config.toml` to this repo's `config.toml`.
3. Validate it with `herdr config check`.
4. Reload a running herdr server with `herdr server reload-config`.

It's idempotent - re-run any time.

## Requirements

- [herdr](https://herdr.dev/docs/install/)

## tmux -> herdr

| tmux | herdr |
| --- | --- |
| session | workspace (sidebar) |
| window | tab |
| pane | pane |
| recon | Goto picker (`<p> g`) and the sidebar's agent list |
| resurrect / continuum | built in - the herdr server keeps everything running |

## Cheat sheet

Prefix is `Ctrl-b` (default). Below, `<p>` = `Ctrl-b`. Press `<p> ?` in herdr for every active binding; `/` filters. Keys marked *tmux alias* are added by this config.

### Workspaces and session

| Keys | Action |
| --- | --- |
| `<p> w` | Workspace picker |
| `Cmd+Ctrl+k/j` or `Ctrl+Alt+k/j` | Previous / next workspace without prefix (up / down the sidebar) |
| `<p> g` / `<p> a` *(tmux alias)* | Goto picker: every agent and terminal, with status |
| `<p> N` | New workspace |
| `<p> W` / `<p> $` *(tmux alias)* | Rename workspace |
| `<p> D` | Close workspace |
| `<p> b` | Toggle sidebar |
| `<p> q` / `<p> d` *(tmux alias)* | Detach (leave everything running) |

### Tabs

| Keys | Action |
| --- | --- |
| `<p> c` | New tab |
| `<p> n` / `<p> p` | Next / previous tab |
| `Cmd+Ctrl+h/l` or `Ctrl+Alt+h/l` *(tmux alias)* | Previous / next tab without prefix |
| `<p> 1` … `<p> 9` | Jump to tab by number |
| `<p> T` / `<p> ,` *(tmux alias)* | Rename tab |
| `<p> X` | Close tab |

### Panes

| Keys | Action |
| --- | --- |
| `<p> v` / `<p> \|` *(tmux alias)* | Split right |
| `<p> -` | Split down |
| `<p> h/j/k/l` | Move between panes |
| `<p> H/J/K/L` | Swap panes |
| `<p> Tab` / `<p> Shift-Tab` | Cycle panes |
| `<p> z` | Toggle zoom |
| `<p> x` | Close pane |
| `<p> r` | Resize mode |

### Copy mode

| Keys | Action |
| --- | --- |
| `<p> [` | Enter copy mode |
| `v` or `Space` | Begin selection |
| `y` or `Enter` | Copy selection |
| `/` / `?`, then `n` / `N` | Search forward / backward, repeat |
| `q` or `Esc` | Exit |
| Mouse drag | Copy without entering copy mode |

### Tools

| Keys | Action |
| --- | --- |
| `<p> ?` | Keybinding help |
| `<p> s` | Settings |
| `<p> R` | Reload config |

## Uninstall

```sh
rm ~/.config/herdr/config.toml
```
