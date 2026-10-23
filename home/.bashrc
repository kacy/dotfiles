# bash setup. zsh is the main shell; this keeps bash usable with the same
# environment and aliases.

. "$HOME/.config/shell/env.sh"

[[ $- == *i* ]] || return

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend checkwinsize globstar

for completion in /usr/share/bash-completion/bash_completion "${HOMEBREW_PREFIX:-/nonexistent}/etc/profile.d/bash_completion.sh"; do
  if [[ -r $completion ]]; then
    . "$completion"
    break
  fi
done
unset completion

PS1='\[\e[0;36m\][\h:\w]\$ \[\e[m\]'

. "$HOME/.config/shell/aliases.sh"
. "$HOME/.config/shell/tools.sh" bash

# Machine-specific settings that stay out of the repo.
[[ -r $HOME/.bashrc.local ]] && . "$HOME/.bashrc.local"
true
