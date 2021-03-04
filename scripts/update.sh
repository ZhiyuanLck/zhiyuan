#!/usr/bin/env bash

echo "enter $zhiyuan"
cd $zhiyuan
echo "updating..."
git submodule update --remote --rebase
