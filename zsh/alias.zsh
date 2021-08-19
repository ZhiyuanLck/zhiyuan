alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias ls='ls --color=always'
alias ll='ls -lh'

# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete'
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gps='git push'
alias gpo='git push -u origin master'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gsma='git submodule add'
alias gsmu='git submodule update --init --recursive'

# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }


# 重载
alias reload="source $HOME/.zshrc"

# 自定义脚本
zy() {
  local script=$zhiyuan/scripts/$1
  if [[ -f $script ]]; then
    $script ${@:2} # 丢掉第一个参数
  else
    echo "$script not found"
  fi
}

# mkdir && cd
mk() {
  mkdir -p $1 && cd $1
}

# ncdu
if has_cmd ncdu; then alias du="ncdu"; fi

# 防止不小心reboot
reboot() {
  vared -p 'Reboot? [y/N]: ' -c _reboot
  [[ $_reboot == 'y' ]] && /sbin/reboot
}

# 一次运行
one() {
  nohup "$@" >/dev/null 2>&1 &
}

# texdoc nohup
if has_cmd texdoc; then
  texdoc() {
    one texdoc "$@"
  }
fi

# note
alias note='vim $HOME/daily/note/$(cd $HOME/daily/note && fzf)'

# vim
cvim() {
  if [[ $# -eq 0 ]]; then
    if git rev-parse --show-toplevel 2> /dev/null; then
      dir=$(git rev-parse --show-toplevel)
      vim $(cd $dir && fzf)
    else
      vim $(fzf)
    fi
  elif [[ -f $1 ]]; then
    vim $1
  elif [[ -d $1 ]]; then
    vim $(cd $1 && fzf)
  else
    vim "$@"
  fi
}

# chmode
alias chm='sudo chmod +x'

# go to root
zr() {
  if git rev-parse --show-toplevel 2> /dev/null; then
    cd $(git rev-parse --show-toplevel)
  fi
}

zssh() {
  if [[ $1 = "v100" ]]; then
    ip="10.184.17.12"
  elif [[ $1 = "2080" ]]; then
    ip="10.184.17.2"
  else
    exit 1
  fi
  ssh -X \
    -L 16006:127.0.0.1:6006 \
    -L 16007:127.0.0.1:6007 \
    -L 16008:127.0.0.1:6008 \
    -L 16009:127.0.0.1:6009 \
    -L 16010:127.0.0.1:6010 \
    lck@$ip
}

gcl() {
  git clone --depth 1 "https://hub.fastgit.org/$1"
}
