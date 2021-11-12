#!/usr/bin/env zsh

# basetool
# git curl wget zsh xclip ncdu tree tmux fzf
# Package  Ubuntu Arch
# basetool x      o

zhiyuan=$HOME/.config/zhiyuan
fpath=( $zhiyuan/zsh/functions $fpath)
autoload -Uz install_ppa os rich && rich

# 是否是在服务器上安装
if (( ${ZSH_VERSION[1,3]} < 5.8 )); then
  zparseopts -D -E s=_server
else
  zparseopts -D -E -F s=_server
fi
MODE_LOCAL() {
  [[ ${#_server} = 0 ]]
}

common_packages=( git curl wget zsh
  xclip ncdu tree tmux fzf aria2 lua5.2
  gcc cmake make ctags global clangd
  flameshot
)
server_packages=( git curl wget zsh tree tmux aria2 lua5.2 gcc cmake make ctags global)
arch_packages=( alacritty base-devel ripgrep yay )
yay_packages=( lazygit )

if os "Ubuntu"; then
  # add ppa
  std "add ppas..."
  if MODE_LOCAL; then
    install_ppa aslatter/ppa       # alacritty
  fi
  install_ppa lazygit-team/release # lazygit
  install_ppa x4121/ripgrep        # ripgrep
  std "update apt sources..."
  sudo apt update

  std ""
  if MODE_LOCAL; then
    sudo apt install -y alacritty
  fi
  sudo apt install -y lazygit ripgrep

  # base tool
  if MODE_LOCAL; then
    sudo apt install -y $common_packages
  fi
  sudo apt install -y $server_packages
elif os "Arch"; then
  sudo pacman -Syu
  sudo pacman -S $common_packages
  sudo pacman -S $arch_packages
  yay -S $yay_packages
fi
