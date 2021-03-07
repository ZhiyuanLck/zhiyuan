#!/usr/bin/env zsh

zhiyuan=$HOME/.config/zhiyuan
main_dir=$zhiyuan/zsh
fpath=( $main_dir/functions $fpath)
autoload -Uz has_cmd backup
autoload -Uz rich && rich

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

# 备份
std "backup old .zshrc and generating new"
backup $HOME/.zshrc zshrc
echo "source $main_dir/init.zsh" > $HOME/.zshrc

# 设置tex路径
std "try to init texlive"
parent=( /usr/local $HOME/.local )
for p in $parent; do
  texlive=$p/texlive
  if [[ -d $texlive ]]; then
    texlive=$texlive/$(ls $texlive | grep -E "^20[0-9]{2}$")
    if [[ -n $texlive ]]; then
      std "find texlive path: $texlive"
      cat << EOF >> $HOME/.zshrc

export PATH=$texlive/bin/x86_64-linux:\$PATH
export MANPATH=$texlive/texmf-dist/doc/man:\$MANPATH
export INFOPATH=$texlive/texmf-dist/doc/info:\$INFOPATH
EOF
      break
    fi
  fi
done

# 初始化conda
zsh $zhiyuan/scripts/conda.zsh

# 切换默认shell
std "setting zsh to default shell..."
[[ ! $SHELL =~ "zsh" ]] && chsh -s $(which zsh)
zsh
