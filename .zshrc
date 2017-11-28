source ~/.aliases

ZSH=$HOME/.zsh
EDITOR=vim

DISABLE_AUTO_TITLE=true #keeps zsh from appearing in tmux title

PATH=/usr/local/bin:/usr/local/sbin:$PATH         # Machine
PATH=/usr/local/share/python:$PATH                # Python
#PATH=/usr/local/Cellar/php/5.3.6/bin:$PATH        # PHP
#PATH=$HOME/.rbenv/bin:$PATH                       # Ruby Gems
PATH=/opt/vagrant/bin:$PATH                       # Vagrant
#PATH=/usr/local/heroku/bin:$PATH                  # Heroku
#PATH=/usr/local/go/bin:$PATH                      # Go
#PATH=$HOME/Code/bin:$PATH                         # My Go
#PATH=$HOME/Code/Work/virb/scripts/tools/bin:$PATH # Virb tools
#PATH=$HOME/.bin:$PATH                             # My tools
RTB=~/Development/perfect-audience/rtb
PATH=$PATH:~/Development/perfect-audience/rtb/scripts
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

for file ($ZSH/modules/**/*.zsh) source $file

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

TERM=xterm-256color

# Solve problem with backspace in vim
stty erase "^?"


# Path to your oh-my-zsh configuration.
#ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

#source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/Users/user/.rvm/gems/ruby-1.9.3-p392/bin:/Users/user/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/user/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/user/.rvm/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/user/bin

#bindkey '' backward-delete-char
#bindkey '^[[3~' delete-char
