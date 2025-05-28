#!/usr/bin/env bash
shdot_dir=$(dirname "$(realpath "$0")")
echo "Copying shdot files from ${shdot_dir} to ${HOME}"
cp -f "${shdot_dir}"/.bash* "${HOME}"/
cp -f "${shdot_dir}"/.git* "${HOME}"/
cp -f "${shdot_dir}"/.input* "${HOME}"/
cp -rf "${shdot_dir}"/.profile* "${HOME}"/