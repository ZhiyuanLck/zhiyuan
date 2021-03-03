autoload -U colors && colors
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
local prompt_path="%{$fg_bold[blue]%}%/"
PROMPT="$prompt_path
$ret_status%{$reset_color%}"

# show conda environment name
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda ...ENVS)
