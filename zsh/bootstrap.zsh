#!/usr/bin/env zsh

zhiyuan=$HOME/.config/zhiyuan
main_dir=$zhiyuan/zsh
fpath=( $main_dir/functions $fpath)
autoload -Uz has_cmd backup
autoload -Uz rich && rich

# 是否是在服务器上安装
zparseopts -D -E -F s=_server
MODE_LOCAL() {
  [[ ${#_server} = 0 ]]
}

# fzf key-bindings
std "downloading fzf zsh key-bindings..."
fzf_dir=$main_dir/plugins/fzf
fzf_key=$fzf_dir/key-bindings.zsh
mkdir -p $fzf_dir
curl -o $fzf_key https://raw.fastgit.org/junegunn/fzf/master/shell/key-bindings.zsh

# command not found
std "downloading zsh plugin command-not-found"
cnf_dir=$main_dir/plugins/command-not-found
cnf=$cnf_dir/command-not-found.zsh
mkdir -p $cnf_dir
curl -o $cnf https://raw.fastgit.org/ohmyzsh/ohmyzsh/master/plugins/command-not-found/command-not-found.plugin.zsh

# 写入zshrc
std "backup old .zshrc and generating new"
backup $HOME/.zshrc zshrc
echo "source $main_dir/init.zsh" > $HOME/.zshrc

if MODE_LOCAL; then
  # 初始化tex
  $zhiyuan/scripts/init-tex
  # 初始化python
  $zhiyuan/scripts/init-py
fi

# 切换默认shell
std "setting zsh to default shell..."
[[ ! $SHELL =~ "zsh" ]] && chsh -s $(which zsh)
zsh
