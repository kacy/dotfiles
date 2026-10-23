# Interactive zsh setup. Environment variables live in ~/.config/shell/env.sh.

typeset -U path

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history hist_ignore_dups hist_find_no_dups hist_ignore_space
setopt hist_reduce_blanks share_history

# Options
setopt auto_cd correct complete_in_word always_to_end interactive_comments auto_menu
bindkey -e
REPORTTIME=10
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Completion
zcache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
[[ -d $zcache ]] || mkdir -p "$zcache"
[[ -n $HOMEBREW_PREFIX ]] && fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
autoload -Uz compinit
compinit -i -d "$zcache/zcompdump"
zmodload -i zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$zcache"
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:functions' ignored-patterns '_*'
unset zcache

# Fallback prompt for machines without starship.
if (( ! $+commands[starship] )); then
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' formats ' %F{yellow}(%b)%f'
  precmd_functions+=(vcs_info)
  setopt prompt_subst
  PROMPT='%(?.%F{green}.%F{red})➜%f %F{cyan}%~%f${vcs_info_msg_0_} '
fi

source "$HOME/.config/shell/aliases.sh"
source "$HOME/.config/shell/tools.sh" zsh

# Machine-specific settings that stay out of the repo.
[[ -r $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"
true
