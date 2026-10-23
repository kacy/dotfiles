# Environment shared by every shell. Sourced from .zshenv, .zprofile and
# .profile, so it must stay POSIX sh and safe to run twice.

export EDITOR=vim
command -v nvim >/dev/null 2>&1 && EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=less
export LESS=-R

# Move a directory to the front of PATH if it exists.
path_prepend() {
  [ -d "$1" ] || return 0
  PATH=$(printf '%s' ":$PATH:" | sed "s|:$1:|:|g; s|^:||; s|:$||")
  PATH="$1${PATH:+:$PATH}"
}

# Homebrew on Apple silicon, Intel macOS, or Linux.
if [ -z "${HOMEBREW_PREFIX:-}" ]; then
  for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [ -x "$brew" ]; then
      eval "$("$brew" shellenv)"
      break
    fi
  done
  unset brew
fi
if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  path_prepend "$HOMEBREW_PREFIX/sbin"
  path_prepend "$HOMEBREW_PREFIX/bin"
fi

path_prepend "$HOME/go/bin"
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.local/bin"
export PATH
unset -f path_prepend
