autoload -Uz colors && colors

ret_status="%(?:%F{85}➜ :%F{196}➜ )%f"
prompt_path="%F{211}%/%f"
_conda() {
  if [[ -n $CONDA_DEFAULT_ENV ]]; then
    echo "%F{36}($CONDA_DEFAULT_ENV)%f "
  fi
}

precmd() {
  ps1_left="$(_conda)$prompt_path" # to be completed
  local left=$((COLUMNS - #ps1_left % $COLUMNS))
  PROMPT="%B$ps1_left${(l:$left:: :)$(date +'%T')}
$ret_status%b"
}
