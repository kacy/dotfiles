ZSH=$HOME/.zsh
EDITOR=vim

DISABLE_AUTO_TITLE=true #keeps zsh from appearing in tmux title

PATH=/usr/local/bin:/usr/local/sbin:$PATH         # Machine
PATH=/usr/local/share/python:$PATH                # Python
PATH=/opt/vagrant/bin:$PATH                       # Vagrant
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

for file ($ZSH/modules/**/*.zsh) source $file

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

TERM=xterm-256color

# Solve problem with backspace in vim
stty erase "^?"

plugins=(git)

# Customize to your needs...
export PATH=$PATH:/Users/user/.rvm/gems/ruby-1.9.3-p392/bin:/Users/user/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/user/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/user/.rvm/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/user/bin
source ~/.aliases

source /etc/bashrc_fitbit
export PATH=$HOME/.local/bin:$PATH
