#!/usr/bin/env zsh


zhiyuan=$HOME/.config/zhiyuan
# copy error output
exec 2> >(tee $zhiyuan/LOG >&2)
fpath=( $zhiyuan/zsh/functions $fpath)
autoload -Uz backup has_cmd rich && rich

# 是否是在服务器上安装
if (( $ZSH_VERSION < 5.8 )); then
  zparseopts -D -E s=_server
else
  zparseopts -D -E -F s=_server
fi
MODE_LOCAL() {
  [[ ${#_server} = 0 ]]
}

if ! MODE_LOCAL; then
  mkdir -p Downloads
fi

rm -f $zhiyuan/LOG # 删除之前的log

$zhiyuan/package.zsh "$@"

std "configuring git..."
git config --global user.name "ZhiyuanLck"
git config --global user.email "lichangkai225@qq.com"

std "updating submodules..."
git submodule update --init --recursive

std "configuring zsh..."
$zhiyuan/zsh/bootstrap.zsh "$@"


if MODE_LOCAL; then
  std "configuring alacritty..."
  alacritty_dir=$HOME/.config/alacritty
  alacritty_config=$zhiyuan/alacritty/alacritty.yml
  mkdir -p $alacritty_dir
  [[ -e $alacritty_config ]] && cp $alacritty_config $alacritty_dir

  std "clone repo diary..."
  mkdir -p $HOME/daily
  diary="$HOME/daily/diary"
  if [[ -d $diary ]]; then
    log "$diary existed"
  else
    git clone git@github.com:ZhiyuanLck/diary.git $diary
    err "clone repo diary failed"
  fi
fi

std "clone repo note..."
mkdir -p $HOME/daily
note="$HOME/daily/note"
if [[ -d $note ]]; then
  log "$note existed"
else
  git clone git@github.com:ZhiyuanLck/note.git $note
  err "clone repo note failed"
fi

# 配置tmux
std "backup old .tmux.conf"
backup $HOME/.tmux.conf tmux
cp $zhiyuan/tmux/.tmux.conf $HOME/.tmux.conf
if [[ -d $HOME/.tmux/plugins/tpm ]]; then
  log "$HOME/.tmux/plugins/tpm existed"
else
  git clone https://hub.fastgit.org/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  bash $HOME/.tmux/plugins/tpm/bin/install_plugins
fi

# 配置rime
if MODE_LOCAL; then
fi

# 标注log文件类型
modeline="vim: ft=log"
[[ -f $zhiyuan/LOG ]] && sed -i "1s/^/# $modeline\n/" $zhiyuan/LOG
