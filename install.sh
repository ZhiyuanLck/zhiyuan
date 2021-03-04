#!/usr/bin/env bash

export zhiyuan=~/.config/zhiyuan

echo "updating submodules..."
git submodule update --init --recursive

echo "configuring zsh..."
./zsh/bootstrap.zsh
