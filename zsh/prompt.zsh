autoload -Uz colors && colors

ret_status="%(?:%F{150}➜ :%F{196}➜ )%f"
prompt_path="%F{109}%/%f"
_conda() {
  if [[ -n $CONDA_DEFAULT_ENV ]]; then
    echo "%F{150}($CONDA_DEFAULT_ENV)%f "
  fi
}

precmd() {
  local ps1_left="$(_conda)${prompt_path}" # to be completed
  local ps1_date=$(date +"%T")
  local zero='%([BSUbfksu]|([FK]|){*})'
  local left_width=${#${(S%%)ps1_left//$~zero/}}
  local left_width=$((left_width % COLUMNS))
  local remain_width=$((COLUMNS - left_width))
  local right_width=${#${(S%%)ps1_date//$~zero/}}
  if [[ $remain_width -lt $right_width ]]; then
    PROMPT="%B$ps1_left
$ps1_date
$ret_status%b"
  else
    PROMPT="%B$ps1_left${(l:$remain_width:: :)ps1_date}
$ret_status%b"
  fi
}
