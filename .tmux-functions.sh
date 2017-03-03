apply_theme() {
  case "$1" in
    powerline_patched_font)
      left_separator=''
      left_separator_black=''
      right_separator=''
      right_separator_black=''
      session_symbol=''
      ;;
    powerline)
      left_separator='|'
      left_separator_black=' '
      right_separator='|'
      right_separator_black=' '
      ;;
  esac

  case "$1" in
    powerline*)

      # panes
      pane_border_fg=colour238        # light gray
      pane_active_border_fg=colour39  # light blue

      tmux set -g pane-border-style fg=$pane_border_fg \; set -g pane-active-border-style fg=$pane_active_border_fg
      #uncomment for fat borders
      #tmux set -ga pane-border-style bg=$pane_border_fg \; set -ga pane-active-border-style bg=$pane_active_border_fg

      display_panes_active_colour=colour39 # light blue
      display_panes_colour=colour39        # light blue
      tmux set -g display-panes-active-colour $display_panes_active_colour \; set -g display-panes-colour $display_panes_colour

      # messages
      message_fg=colour16   #black
      message_bg=colour226  #yellow
      message_attr=bold
      tmux set -g message-style fg=$message_fg,bg=$message_bg,$message_attr

      # windows mode
      mode_fg=colour16   #black
      mode_bg=colour226  #yellow
      mode_attr=bold
      tmux setw -g mode-style fg=$mode_fg,bg=$mode_bg,$mode_attr

      # status line
      status_fg=colour253 # white
      status_bg=colour232 # dark gray
      tmux set -g status-style fg=$status_fg,bg=$status_bg

      session_fg=colour16  # black
      session_bg=colour226 # yellow
      status_left="#[fg=$session_fg,bg=$session_bg,bold] ❐ #S #[fg=$session_bg,bg=$status_bg,nobold]$left_separator_black"
      tmux set -g status-left-length 32 \; set -g status-left "$status_left"

      window_status_fg=colour245 # light gray
      window_status_bg=colour232 # dark gray
      window_status_format="#I #W"
      tmux setw -g window-status-style fg="$window_status_fg",bg="$window_status_bg" \; setw -g window-status-format "$window_status_format"

      window_status_current_fg=colour16 # black
      window_status_current_bg=colour39 # light blue
      window_status_current_format="#[fg=$window_status_bg,bg=$window_status_current_bg]$left_separator_black#[fg=$window_status_current_fg,bg=$window_status_current_bg,bold] #I $left_separator #W #[fg=$window_status_current_bg,bg=$status_bg,nobold]$left_separator_black"
      tmux setw -g window-status-current-format "$window_status_current_format"
      tmux set -g status-justify left

      window_status_activity_fg=default
      window_status_activity_bg=default
      window_status_activity_attr=underscore
      tmux setw -g window-status-activity-style fg=$window_status_activity_fg,bg=$window_status_activity_bg,$window_status_activity_attr

      time_date_fg=colour245  # light gray
      time_date_bg=colour232  # dark gray
      whoami_fg=colour254     # white
      whoami_bg=colour160     # red
      host_fg=colour16        # black
      host_bg=colour254       # white
      status_right="${tmux_conf_battery:-#(cut -c3- ~/.tmux.conf | sh -s battery ${tmux_conf_battery_symbol:-block} ${tmux_conf_battery_symbol_count:-auto})} #[fg=$time_date_fg,nobold]$right_separator %R $right_separator %d %b #[fg=$whoami_bg,bg=$time_date_bg,nobold]$right_separator_black#[fg=$whoami_fg,bg=$whoami_bg,nobold] #(whoami) $right_separator_black#[fg=$host_fg,bg=$host_bg,bold] #h "
      tmux set -g status-right-length 64 \; set -g status-right "$status_right"

      # clock
      clock_mode_colour=colour39  # light blue
      tmux setw -g clock-mode-colour $clock_mode_colour
      ;;
  esac
}

circled_digit() {
  circled_digits='⓪①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳'
  if [ $1 -lt 20 ] 2>/dev/null ; then
    echo ${circled_digits:$1:1}
  else
    echo $1
  fi
}

maximize_pane() {
  tmux -q -L swap-pane-test -f /dev/null new-session -d \; new-window \; new-window \; swap-pane -t :1 \; kill-session || { tmux display 'your tmux version has a buggy swap-pane command - see ticket #108, fixed in upstream commit 78e783e'; exit; }
  __current_pane=$(tmux display -p '#{pane_id}')

  __dead_panes=$(tmux list-panes -s -F '#{pane_dead} #{pane_id} #{pane_title}' | grep -o '^1 %.\+%.\+$' || true)
  __restore=$(echo "${__dead_panes}" | sed -n -E -e "s/^1 ${__current_pane} \[\+\](%[0-9]+)$/tmux swap-pane -s \1 -t ${__current_pane} \; kill-pane -t ${__current_pane}/p" -e "s/^1 (%[0-9]+) \[\+\]${__current_pane}$/tmux swap-pane -s \1 -t ${__current_pane} \; kill-pane -t \1/p" )

  if [ x"${__restore}" = x ] ; then
    [ x"$(tmux list-panes | wc -l | sed 's/^ *//g')" = x1 ] && tmux display "Can't maximize with only one pane" && return
    __window=$(tmux new-window -P "exec maximized+ 2> /dev/null | tmux setw remain-on-exit on && printf '\033]2;%s\033\\' [+]${__current_pane}")
    __window=${__window%.*}

    __guard=100
    while ( [ x"$(tmux list-panes -t ${__window} -F '#{session_name}:#{window_index} #{pane_dead}')" != x"${__window} "1 ] && [ x"${__guard}" != x0 ] ) ; do sleep 0.01 ; _guard=$((__guard - 1)) ; done
    if [ x"${__guard}" = 0 ] ; then
      exit 1
    fi

    __new_pane=$(tmux display -p '#{pane_id}')
    tmux setw remain-on-exit off \; swap-pane -s "${__current_pane}" -t "${__new_pane}"
  else
    ${__restore}
  fi
}

toggle_mouse() {
  old=$(tmux show -g -w | grep mode-mouse | cut -d' ' -f2)
  new=""

  if [ "$old" = "on" ] ; then
    new="off"
  else
    new="on"
  fi

  tmux set -g mode-mouse $new \;\
       set -g mouse-resize-pane $new \;\
       set -g mouse-select-pane $new \;\
       set -g mouse-select-window $new \;\
       display "mouse: $new"
}

battery() {
  battery_symbol=$1
  battery_symbol_count=$2
  if [ $battery_symbol_count = auto ]; then
    columns=$(tmux display -p '#{client_width}' || echo 80)
    if [ $columns -ge 80 ]; then
      battery_symbol_count=10
    else
      battery_symbol_count=5
    fi
  fi
  battery_full_fg=colour160
  battery_full_bg=colour16
  battery_empty_fg=colour254
  battery_empty_bg=colour16

  battery_symbol_heart_full=♥
  battery_symbol_heart_empty=♥
  battery_symbol_block_full=◼
  battery_symbol_block_empty=◻
  eval battery_symbol_full='$battery_symbol_'"$battery_symbol"'_full'
  eval battery_symbol_empty='$battery_symbol_'"$battery_symbol"'_empty'

  uname_s=$(uname -s)
  if [ $uname_s = Darwin ]; then
    batt=$(pmset -g batt)
    percentage=$(echo $batt |egrep -o [0-9]+%) || return
    charge="${percentage%%%} / 100"
  elif [ $uname_s = Linux ]; then
    batpath=/sys/class/power_supply/BAT0
    if [ ! -d $batpath ]; then
      batpath=/sys/class/power_supply/BAT1
    fi
    batfull=$batpath/energy_full
    batnow=$batpath/energy_now
    if [ ! -r $batfull -o ! -r $batnow ]; then
      return
    fi
    charge="$(cat $batnow) / $(cat $batfull)" || return
  fi

  full=$(printf %.0f $(echo "$charge * $battery_symbol_count" | bc -l))
  [ $full -gt 0 ] && \
    printf '#[fg=%s,bg=%s]' $battery_full_fg $battery_full_bg && \
    printf "%0.s$battery_symbol_full" $(seq 1 $full)
  empty=$(($battery_symbol_count - $full))
  [ $empty -gt 0 ] && \
    printf '#[fg=%s,bg=%s]' $battery_empty_fg $battery_empty_bg && \
    printf "%0.s$battery_symbol_empty" $(seq 1 $empty)
}
