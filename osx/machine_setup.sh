#!/bin/sh
# Usage: bash < <(curl -s https://gist.github.com/raw/965142/install.sh)

if [ ! -d "/Developer/Applications/Xcode.app" ]; then
  echo "Please install Xcode first. Exiting."  
  exit 1
fi

# Have sudo ask us for our password before we kick everything off so we can walk away.
sudo echo "Here we go..."

echo "Installing Homebrew..."
ruby -e "$(curl -fsSLk https://gist.github.com/raw/323731/install_homebrew.rb)"
brew install git

echo "Installing npm"
bash < <(curl http://npmjs.org/install.sh | sh)

echo "Installing RVM..."
bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
source $HOME/.rvm/scripts/rvm

echo "Installing Ruby 1.9.2..."
rvm install 1.9.2
rvm --default use 1.9.2

echo "Installing other Homebrew packages..."
brew install wget
brew install tree
brew install ec2-api-tools
brew install gawk
brew install htop
brew install ctags
brew install ngrep
brew install mongodb
brew install pidof
brew install rabbitmq
brew install cmake
brew install growlnotify
brew install jslint
brew install ack
brew install ffmpeg
brew install scala
brew install erlang
brew install node
brew install mysql
brew install tmux

unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo "Installing dotfiles..."
/usr/local/bin/git clone git@github.com:kacy/dotfiles.git ~/.dotfiles
(cd ~/.dotfiles && rake)
sudo chsh -s /usr/local/bin/zsh $(whoami)

echo "Installing RubyGems..."
gem install rails
gem install sinatra
gem install jekyll
gem install capistrano
gem install sass
gem install boom
gem install jslint
gem install chef
gem install knife-ec2
gem install fog
gem install json
gem install parallel
gem install rake
gem install rest-client
gem install rspec
gem install ruby-debug
gem install selenium-client

echo "Installing Pow..."
curl get.pow.cx | sh

echo "Installing MacVim..."
brew install macvim
sudo ln -s $(brew --prefix macvim)/MacVim.app /Applications

echo "Installing iTerm..."
curl -s http://iterm2.googlecode.com/files/iTerm2-1_0_0_20111020.zip > /tmp/iterm.zip
unzip /tmp/iterm.zip
sudo mv iTerm.app /Applications

echo "Installing TextMate..."
curl -s http://dl.macromates.com/TextMate_1.5.10_r1631.zip > /tmp/textmate.zip
unzip /tmp/textmate.zip
sudo mv TextMate.app /Applications

echo "Installing Sidestep"
curl -s http://cloud.github.com/downloads/chetan51/sidestep/Sidestep.zip > /tmp/sidestep.zip
unzip /tmp/sidestep.zip
sudo mv Sidestep.app /Applications

echo "Done. Now go download these apps if you want:"
echo "- Alfred"
echo "- Dropbox"
echo "- BusySync"
echo "- 1Password"
echo "- Adium"
echo "- Skype"
echo "- Hipchat"
echo "- Chrome"
echo "- Spotify"
echo "- Rdio"
echo "- Mono"
echo "- MonoDevelop"
echo "- Truecrypt"
echo "- Sequel Pro"
echo "- Little Snitch"
