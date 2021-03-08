#!/usr/bin/env zsh

# basetool
# git curl wget zsh xclip ncdu tree tmux fzf
# Package  Ubuntu Arch
# basetool x      o

zhiyuan=$HOME/.config/zhiyuan
fpath=( $zhiyuan/zsh/functions $fpath)
autoload -Uz os

packages=( git curl wget zsh
  alacritty xclip ncdu tree tmux fzf aria2
)

if os "Ubuntu"; then
  sudo apt install -y git curl wget zsh xclip ncdu tree tmux fzf aria2
elif os "Arch"; then
  sudo pacman -S $packages
fi
