# 移动
bindkey "^H" backward-char
bindkey "^L" forward-char

# 历史搜索
bindkey "^[k" history-substring-search-up
bindkey "^[j" history-substring-search-down

# 自动提示
bindkey '^[l' autosuggest-accept
bindkey '^[m' autosuggest-execute

# fzf
# C-T 复制文件路径
# M-c cd到制定目录
# C-R 复制历史命令
source $HOME/.config/zhiyuan/zsh/plugins/fzf/key-bindings.zsh

autopair-init
