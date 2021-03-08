#!/usr/bin/env bash

sudo apt install gcc make git libncurses5 libncurses5-dev

if [[ -d $HOME/github/zsh ]]; then
  git clone --depth 1 https://hub.fastgit.org/zsh-users/zsh $HOME/github/zsh
else
  cd $HOME/github/zsh
  git pull
fi
cd $HOME/github/zsh
make distclean
autoheader
autoconf
./configure --prefix=$HOME/.local
make -j16
make install
