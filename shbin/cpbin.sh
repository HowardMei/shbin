#!/usr/bin/env bash
shbin_dir=$(dirname "$(realpath "$0")")

if [ $# -lt 1 ]; then
    cp -rf "${shbin_dir}" "${HOME}"/.shbin
    echo "Copying shbin files from ${shbin_dir} to ${HOME}/.shbin"
else 
    cp -rf "${shbin_dir}" "$1"
    echo "Copying shbin files from ${shbin_dir} to $1"
fi