#!/usr/bin/env bash

log() {
  echo "${BRed}$1{Color_Off}"
  echo $1 >> $zhiyuan/LOG
}

err() {
  [[ $? -ne 0 ]] && log $1
}
