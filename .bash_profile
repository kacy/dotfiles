[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=$(/usr/libexec/java_home)
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
