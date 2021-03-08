#!/usr/bin/env bash

sudo apt install gcc make git
sudo apt remove zsh zsh-common

git clone --depth 1 https://hub.fastgit.org/zsh-users/zsh $HOME/github/zsh
cd $HOME/github/zsh
./configure && make -j16
sudo make install
