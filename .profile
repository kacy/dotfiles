# Identify OS and Machine -----------------------------------------
export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"

export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export TERM=xterm-color

export EDITOR="vim"

#JAVA_HOME=/usr/local/java/
#export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"

source ~/.bashrc
source ~/.ec2
source ~/.aliases

# Change prompt display
export PS1="\[\e[0;36m\][\h:\w]\$ \[\e[m\]"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"






