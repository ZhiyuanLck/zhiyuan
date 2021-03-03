#!/usr/bin/env bash

export zhiyuan=~/.config/zhiyuan

git submodule update --init --recursive

./zsh/bootstrap.zsh
