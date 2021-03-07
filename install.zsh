#!/usr/bin/env zsh

zhiyuan=$HOME/.config/zhiyuan
fpath=( $zhiyuan/zsh/functions $fpath)
autoload -Uz has_cmd rich && rich

rm -f $zhiyuan/LOG # 删除之前的log

std "installing necessary packages..."
./package.zsh

std "configuring git..."
git config --global user.name "ZhiyuanLck"
git config --global user.email "lichangkai225@qq.com"

std "updating submodules..."
git submodule update --init --recursive

std "configuring zsh..."
./zsh/bootstrap.zsh

std "configuring alacritty..."
alacritty_dir=$HOME/.config/alacritty
alacritty_config=$zhiyuan/alacritty/alacritty.yml
mkdir -p $alacritty_dir
[[ -e $alacritty_config ]] && cp $alacritty_config $alacritty_dir

std "clone repo diary..."
mkdir -p $HOME/daily
if [[ -d $HOME/daily/diary ]]; then
  log "$HOME/daily/diary existed"
else
  git clone git@github.com:ZhiyuanLck/diary.git
  err "clone repo diary failed"
fi

# 标注log文件类型
modeline="vim: ft=log"
[[ -f $zhiyuan/LOG ]] && sed -i "1s/^/# $modeline\n/" $zhiyuan/LOG
