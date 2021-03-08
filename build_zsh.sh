#!/usr/bin/env bash

sudo apt install gcc make git libncurses5 libncurses5-dev
sudo apt remove zsh zsh-common

if [[ -d $HOME/github/zsh ]]; then
  git clone --depth 1 https://hub.fastgit.org/zsh-users/zsh $HOME/github/zsh
else
  cd $HOME/github/zsh
  git pull
fi
cd $HOME/github/zsh
autoheader
autoconf
./configure
make -j16
sudo make install
