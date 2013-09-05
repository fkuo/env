#!/bin/bash

# get directory of this script
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $dir

# git
cp gitconfig ~/.gitconfig

# shell
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
cp fred.zsh-theme ~/.oh-my-zsh/themes/fred.zsh-theme
cp zshrc ~/.zshrc
mkdir ~/bin
cp pbcopy ~/bin/pbcopy
cp pbpaste ~/bin/pbpaste
cp fix-ntp.sh ~/bin/fix-ntp.sh
cp profile ~/.profile

git clone git://github.com/joelthelion/autojump.git
cd autojump && ./install.sh
cd ..


# node, npm, and node stuff
mkdir node-latest-install
cd node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure
sudo make install
cd ..
sudo curl https://npmjs.org/install.sh | sh
sudo curl https://raw.github.com/creationix/nvm/master/install.sh | sh

sudo npm install -g nodeunit
git clone https://github.com/creationix/nvm.git ~/.nvm
git clone https://github.com/joyent/node-manta.git ~/node-manta


# vim
cp vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

source ~/.profile
