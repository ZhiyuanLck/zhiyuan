export TERM=xterm-256color
export EDITOR=vim

# 历史命令
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# 自动补全
autoload -Uz compinit && compinit

# latex
if [[ -n "$TEX" ]]; then
  export PATH=$TEX/bin/x86_64-linux:$PATH
  export MANPATH=$TEX/texmf-dist/doc/man:$MANPATH
  export INFOPATH=$TEX/texmf-dist/doc/info:$INFOPATH
fi
