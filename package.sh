#!/usr/bin/env bash

if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
  OS=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
else
  OS=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
fi

packages=(git curl wget zsh
  alacritty xclip
)

if [[ $OS == "Ubuntu" ]]; then
  sudo apt install -y git curl wget zsh xclip
elif [[ $OS == "Arch" ]]; then
  sudo pacman -S $packages
fi

# Package  Ubuntu Arch
# basetool x      o
