set -o nounset     # Strict var declare
set -o errexit     # Exit on error
######################################## BASH PROFILE ############################################
#### Bash specific settings for login shells [local graphical desktop login, su - or bash --login/-l,
#### and remote ssh login]. In desktop environment, this file will be sourced ONLY ONCE during startup.
#### You need to source this file EXPLICITLY during normal terminal [non-login] usage.
#### This is a single user profile, global bash profiles are stored in /etc/profile.d/
unset BASH_PROFILE
export BASH_PROFILE='Loaded Once'
## Load basic, essential profile [shared among sh/dash/bash/zsh/csh etc].
[ -r "${HOME}/.profile" ] && . ${HOME}/.profile

## Load non-login resource configurations once.
[ -z "${BASH_RC}" ] && [ -r "${HOME}/.bashrc" ] && . ${HOME}/.bashrc

## This PS1 checking separates non-interactive and interactive configurations apart.
## Most running scripts and programs are under non-interactive non-login shells.
## Keep configuration above this line simple and essential to avoid various errors.
[ -z "$PS1" ] && return || shopt -s checkwinsize

alias reloadx="echo 'Reloading .bash_profile' && . $HOME/.bash_profile"

# Beautify the bash prompt
[ -r "$HOME/.bash_prompt" ] && . "$HOME/.bash_prompt"

## For more user specific bash profiles, source them accordingly.
if [ -d "${HOME}/.profiles.d" ]; then
  for pf in ${HOME}/.profiles.d/*.profile; do
    [ -r ${pf} ] && . ${pf}
  done
  unset pf
fi

# If possible, add tab completion for many more commands
if [ -f "/etc/bash_completion" ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

###############################################################################################
set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
