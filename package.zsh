#!/usr/bin/env zsh

# Package  Ubuntu Arch
# basetool x      o

zhiyuan=$HOME/.config/zhiyuan
fpath=( $zhiyuan/zsh/functions $fpath)
autoload -Uz os

packages=(git curl wget zsh
  alacritty xclip ncdu tree
)

if os "Ubuntu"; then
  sudo apt install -y git curl wget zsh xclip ncdu tree
elif os "Arch"; then
  sudo pacman -S $packages
fi
