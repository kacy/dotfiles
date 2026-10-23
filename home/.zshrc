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

# Prompt: a green arrow (red after a failed command), the directory, and the
# git branch in green when clean or yellow with ✗ when dirty.
autoload -U colors && colors
setopt prompt_subst

function git_prompt_branch {
  echo -n "($(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}'))"
}

function git_prompt_dirty {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  if [[ -z $(git status --porcelain 2>/dev/null) ]]; then
    echo "%{$fg[green]%}$(git_prompt_branch)%{$reset_color%}"
  else
    echo "%{$fg[yellow]%}$(git_prompt_branch)✗%{$reset_color%}"
  fi
}

ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ $(git_prompt_dirty) % %{$reset_color%}'

source "$HOME/.config/shell/aliases.sh"
source "$HOME/.config/shell/tools.sh" zsh

# Machine-specific settings that stay out of the repo.
[[ -r $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"
true
