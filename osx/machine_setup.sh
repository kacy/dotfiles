#!/bin/sh
# Usage: bash < <(curl -s https://gist.github.com/raw/965142/install.sh)

if [ ! -d "/Developer/Applications/Xcode.app" ]; then
  echo "Please install Xcode first. Exiting."  
  exit 1
fi

# Have sudo ask us for our password before we kick everything off so we can walk away.
sudo echo "Here we go..."

echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Homebrew Cask"
brew tap caskroom/cask

echo "Installing RVM..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

source $HOME/.rvm/scripts/rvm

echo "Installing Ruby 1.9.3..."
rvm install 1.9.3
rvm --default use 1.9.3

echo "Installing other Homebrew packages..."
brew install git

brew install ack
brew install ansible
brew install autoconf
brew install automake
brew install awless
brew install awscli
brew install bash
brew install bash-completion
brew install boost
brew install boot2docker
brew install cairo
brew install cloog-ppl015
brew install cloog@0.15
brew install cmake
brew install ctags
brew install czmq
brew install delve
brew install ec2-api-tools
brew install emacs
brew install expat
brew install faac
brew install ffmpeg
brew install flac
brew install fontconfig
brew install fontforge
brew install fpp
brew install freetype
brew install gawk
brew install gcc46
brew install gcc@4.6
brew install gdbm
brew install gettext
brew install glib
brew install gmp
brew install gmp4
brew install gmp@4
brew install gnupg
brew install go
brew install gobject-introspection
brew install grails
brew install grep
brew install harfbuzz
brew install heroku-toolbelt
brew install htop-osx
brew install icu4c
brew install irssi
brew install jpeg
brew install kubernetes-cli
brew install lame
brew install leiningen
brew install libav
brew install libebml
brew install libevent
brew install libffi
brew install libgpg-error
brew install libksba
brew install libmagic
brew install libmatroska
brew install libmpc08
brew install libmpc@0.8
brew install libogg
brew install libpng
brew install libtiff
brew install libtool
brew install libvo-aacenc
brew install libvorbis
brew install libyaml
brew install maven
brew install mkvtoolnix
brew install mongodb
brew install mpfr2
brew install mpfr@2
brew install mysql
brew install nmap
brew install npm
brew install node
brew install openssl
brew install ossp-uuid
brew install pango
brew install pcre
brew install phantomjs
brew install pidof
brew install pixman
brew install pkg-config
brew install portaudio
brew install portmidi
brew install postgresql
brew install ppl011
brew install ppl@0.11
brew install python
brew install qt5
brew install readline
brew install reattach-to-user-namespace
brew install redis
brew install scala
brew install sqlite
brew install terraform
brew install tmux
brew install tree
brew install truecrack
brew install wget
brew install x264
brew install xvid
brew install xz
brew install zeromq

brew cask install 1password
brew cask install alfred
brew cask install atom
brew cask install caffeine
brew cask install dash
brew cask install docker
brew cask install dropbox
brew cask install flux
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cask install hyper
brew cash install iterm2
brew cask install java
brew cask install java8
brew cask install little-snitch
brew cask install macvim
brew cask install postico
brew cask install rvm
brew cask install sequel-pro
brew cask install sabnzbd
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install transmit
brew cask install vagrant
brew cask install virtualbox
brew cask install visual-studio-code
brew cask install vlc

echo "Installing dotfiles..."
/usr/local/bin/git clone git@github.com:kacy/dotfiles.git ~/.dotfiles
(cd ~/.dotfiles && rake)
sudo chsh -s /usr/local/bin/zsh $(whoami)

echo "Installing RubyGems..."
gem install aws-sdk
gem install bundler
gem install rails
gem install sinatra
gem install jekyll
gem install sass
gem install jslint
gem install json
gem install parallel
gem install rake
gem install rest-client
gem install rspec
gem install ruby-debug

echo "You still need to go to the App Store:\n
