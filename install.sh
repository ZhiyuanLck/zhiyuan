#!/usr/bin/env bash

zhiyuan=$HOME/.config/zhiyuan
source $zhiyuan/log.sh
rm -f $zhiyuan/LOG

echo "installing necessary packages..."
./package.sh

echo "configuring git..."
git config --global user.name "ZhiyuanLck"
git config --global user.email "lichangkai225@qq.com"

echo "updating submodules..."
git submodule update --init --recursive

echo "configuring zsh..."
./zsh/bootstrap.zsh

echo "configuring alacritty..."
local alacritty_dir=~/.config/alacritty
local alacritty_config=$zhiyuan/alacritty/alacritty.yml
mkdir -p $alacritty_dir
[[ -e $alacritty_config ]] && cp $alacritty_config $alacritty_dir

echo "clone repo diary..."
mkdir -p ~/daily
if [[ -d ~/daily/diary ]]; then
  log "~/daily/diary existed"
else
  git clone git@github.com:ZhiyuanLck/diary.git
  err "clone repo diary failed"
fi
