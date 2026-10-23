# dotfiles

Shell, git, tmux and vim configuration for Linux and macOS.

## Layout

- `home/` mirrors `$HOME`. `install.sh` symlinks each file in it to the same
  path under your home directory.
- `home/.config/shell/` holds the shell setup that `.zshrc` loads: `env.sh`
  (environment and `PATH`), `aliases.sh`, and `tools.sh` (hooks for mise,
  zoxide and fzf). zsh is the main shell, so the repo has no
  `.bashrc` and bash keeps the one the OS ships.
- `vendor/oh-my-tmux` is Oh my tmux (`gpakosz/.tmux`), pinned as a git
  submodule. `home/.config/tmux/tmux.conf` is a symlink to its main config,
  which should never be edited. Settings go in
  `home/.config/tmux/tmux.conf.local`.
- `macos/` holds a `Brewfile` and a `defaults.sh` script for new Macs.

## Install

```sh
git clone https://github.com/kacy/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh --dry-run   # show what would change
./install.sh
```

`install.sh` fetches the Oh my tmux submodule, then links individual files,
not directories, so local files can live next to the links. It moves any file
it would replace into `~/.dotfiles-backup/<timestamp>/`. Running it again is
safe. `./install.sh --uninstall` removes the links and leaves everything else
alone.

On a new Mac, run these before `install.sh`:

```sh
brew bundle --file=macos/Brewfile
macos/defaults.sh
```

On Linux, install the same tools with your package manager. The shell config
works without any of them and skips the ones that are missing.

## Local overrides

Machine-specific settings go in these files, which the repo does not track:

| File | Loaded by |
| --- | --- |
| `~/.zshrc.local` | zsh |
| `~/.config/git/config.local` | git, for a work email or signing key |
| `~/.config/tmux/local.conf` | tmux, from `tmux.conf.local` |

## Updating Oh my tmux

```sh
git submodule update --remote vendor/oh-my-tmux
diff vendor/oh-my-tmux/.tmux.conf.local home/.config/tmux/tmux.conf.local
```

Copy any new upstream options from the template into `tmux.conf.local`, then
commit the submodule bump.
