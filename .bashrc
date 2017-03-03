export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
export GREP_COLOR='00;38;5;226'
export GREP_OPTIONS='--color=auto'

export SHELL='/bin/zsh'

alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors


export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:~/bin
export AWS_CLOUDWATCH_HOME=/Users/kacy/Development/CloudWatch-1.0.13.4/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home
export PATH=$PATH:$AWS_CLOUDWATCH_HOME/bin:$JAVA_HOME
export RTB=~/Development/perfect-audience/rtb
export PATH=$PATH:~/Development/perfect-audience/rtb/scripts

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
