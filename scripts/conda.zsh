#!/usr/bin/env zsh

zhiyuan=$HOME/.config/zhiyuan
fpath=( $zhiyuan/zsh/functions $fpath)
autoload -Uz backup rich && rich

# 初始化conda
std "try to init conda"
parent=( $HOME $HOME/program $HOME/software )
conda=( miniconda3 anaconda3 Anaconda3 )
bin="bin/conda"
_break=false
for p in $parent; do
  for c in $conda; do
    b=$p/$c/$bin
    if [[ -f $b ]]; then
      conda_bin=$b
      std "find conda binary: $b"
      _break=true
      break
    fi
  done
  if $_break; then break; fi
done

if [[ -n $conda_bin ]]; then
  $conda_bin init zsh
  backup $HOME/.condarc condarc
  cat << 'EOF' > $HOME/.condarc
changeps1: False
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
EOF
fi
