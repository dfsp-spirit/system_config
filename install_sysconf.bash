#!/bin/sh

# make sure this script is executed in the correct directory
if [ ! -f bash_profile ]; then
  echo 'ERROR: Execute this script from its directory.'
  exit 1
fi

if [ ! -d ~/bin ]; then
  mkdir ~/bin/
fi
cp -r bin/* ~/bin/

cp ./bash_profile ~/.bash_profile
cp ./bashrc ~/.bashrc
cp ./condarc ~/.condarc

# vim setup
if [ ! -d ~/.vim/colors ]; then
  mkdir -p  ~/.vim/colors
fi
cp vimrc ~/.vimrc
cp tools/solarized/solarized.vim ~/.vim/colors/

# ssh setup, shortcuts for hosts
if [ ! -d ~/.ssh/ ]; then
  mkdir -p  ~/.ssh
fi
cp ssh_config ~/.ssh/
