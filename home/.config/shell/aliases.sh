# Aliases and functions loaded by zsh. Kept POSIX so any shell can source it.

alias ..='cd ..'
alias ...='cd ../..'
alias back='cd -'
alias reload='exec "$SHELL" -l'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias l='eza -la --git'
  alias ll='eza -l --git'
  alias lt='eza --tree --level=2'
else
  if ls --color=auto -d . >/dev/null 2>&1; then
    alias ls='ls --color=auto'
  else
    alias ls='ls -G'
  fi
  alias l='ls -lah'
  alias ll='ls -lFh'
fi

alias grep='grep --color=auto'
alias e='$EDITOR'
alias v='$EDITOR'
alias t='tmux new-session -A -s main'
alias whatismyip='curl -fsS https://ifconfig.me; echo'

# git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcam='git commit --amend'
alias gd='git diff'
alias gf='git fetch'
alias gl="git log --graph --pretty=format:'%C(red)%h%C(reset) %an: %s %C(yellow)%d%C(reset) %C(green)(%cr)%C(reset)' --abbrev-commit"
alias gm='git merge --no-ff'
alias gpull='git pull --rebase --prune'
alias gpush='git push origin HEAD'
alias gs='git status -sb'

case "$(uname -s)" in
  Darwin)
    alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
    alias emptytrash='rm -rf ~/.Trash/*'
    alias showhidden='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
    alias hidehidden='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
    ;;
  Linux)
    alias open='xdg-open'
    ;;
esac

extract() {
  if [ ! -f "$1" ]; then
    echo "extract: '$1' is not a file" >&2
    return 1
  fi
  case "$1" in
    *.tar | *.tar.* | *.tgz | *.tbz2 | *.txz) tar xf "$1" ;;
    *.zip) unzip "$1" ;;
    *.7z) 7z x "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.xz) unxz "$1" ;;
    *.zst) unzstd "$1" ;;
    *)
      echo "extract: unknown archive type: '$1'" >&2
      return 1
      ;;
  esac
}
