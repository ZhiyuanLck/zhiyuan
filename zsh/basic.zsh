export TERM=xterm-256color
export EDITOR=vim

# 历史命令
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# 自动补全
autoload -Uz compinit && compinit

# ls color
eval `dircolors $HOME/.config/zhiyuan/ls/color` > /dev/null
