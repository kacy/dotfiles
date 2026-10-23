# macOS runs path_helper from /etc/zprofile after .zshenv, which pushes system
# directories ahead of ours. Running env.sh again restores the order.
. "$HOME/.config/shell/env.sh"
