#!/usr/bin/env bash

export zhiyuan=~/.config/zhiyuan

echo "updating submodules..."
git submodule update --init --recursive

echo "configuring zsh..."
./zsh/bootstrap.zsh

echo "configuring alacritty..."
local alacritty_dir=~/.config/alacritty
local alacritty_config=$zhiyuan/alacritty/alacritty.yml
mkdir -p $alacritty_dir
[[ -e $alacritty_config ]] && cp $alacritty_config $alacritty_dir
