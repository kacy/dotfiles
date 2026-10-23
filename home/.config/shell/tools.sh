# Hooks for optional tools. Pass the shell name: `. tools.sh zsh` or `. tools.sh bash`.
# Each tool is skipped when it is not installed.

command -v mise >/dev/null 2>&1 && eval "$(mise activate "$1")"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init "$1")"
command -v fzf >/dev/null 2>&1 && eval "$(fzf --"$1" 2>/dev/null)"
true
