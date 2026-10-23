#!/usr/bin/env bash
# Symlink every file under home/ into $HOME, one link per file, so local-only
# files can sit next to the links. Existing files are moved into
# ~/.dotfiles-backup/<timestamp>/ before they are replaced.
#
# Usage: ./install.sh [--dry-run] [--uninstall]

set -euo pipefail

repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
src="$repo/home"
backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
dry_run=0
uninstall=0

usage() { echo "usage: $0 [--dry-run] [--uninstall]"; }

for arg in "$@"; do
  case "$arg" in
    -n | --dry-run) dry_run=1 ;;
    -u | --uninstall) uninstall=1 ;;
    -h | --help) usage; exit 0 ;;
    *) usage >&2; exit 1 ;;
  esac
done

run() {
  echo "$*"
  [ "$dry_run" -eq 1 ] || "$@"
}

if [ "$uninstall" -eq 0 ]; then
  run git -C "$repo" submodule update --init
fi

cd "$src"
find . \( -type f -o -type l \) -print0 | sort -z | while IFS= read -r -d '' rel; do
  rel=${rel#./}
  file="$src/$rel"
  target="$HOME/$rel"
  linked=0
  [ "$(readlink "$target" 2>/dev/null)" = "$file" ] && linked=1

  if [ "$uninstall" -eq 1 ]; then
    [ "$linked" -eq 1 ] && run rm "$target"
    continue
  fi

  [ "$linked" -eq 1 ] && continue
  if [ -e "$target" ] || [ -L "$target" ]; then
    run mkdir -p "$(dirname "$backup/$rel")"
    run mv "$target" "$backup/$rel"
  fi
  [ -d "$(dirname "$target")" ] || run mkdir -p "$(dirname "$target")"
  run ln -s "$file" "$target"
done
