#!/usr/bin/env zsh

local main_dir=$zhiyuan/zsh

# fzf key-bindings
echo "downloading fzf zsh key-bindings..."
local fzf_dir=$main_dir/plugins/fzf
local fzf_key=$fzf_dir/key-bindings.zsh
mkdir -p $fzf_dir
curl -o $fzf_key https://raw.fastgit.org/junegunn/fzf/master/shell/key-bindings.zsh

# command not found
echo "downloading zsh plugin command-not-found"
local cnf_dir=$main_dir/plugins/command-not-found
local cnf=$cnf_dir/command-not-found.zsh
mkdir -p $cnf_dir
curl -o $cnf https://raw.fastgit.org/ohmyzsh/ohmyzsh/master/plugins/command-not-found/command-not-found.plugin.zsh

# 备份
echo "backup old .zshrc and generating new"
[[ -e ~/.zshrc ]] && cp ~/.zshrc ~/.zshrc.bak
echo "source $main_dir/init.zsh" > ~/.zshrc

# 初始化conda
if command -v conda &> /dev/null; then
  echo "configuring zsh conda..."
  conda int zsh
fi

# 切换默认shell
echo "setting zsh to default shell..."
[[ ! $SHELL =~ "zsh" ]] && chsh -s $(which zsh)
zsh
