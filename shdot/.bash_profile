###set -x             # Debug mode
set -o nounset     # Strict var declare
set -o errexit     # Exit on error
######################################## BASH PROFILE ############################################
#### Bash specific settings for login shells [local graphical desktop login, su - or bash --login/-l,
#### and remote ssh login with user:password]. In desktop, this file will be sourced ONLY ONCE at startup.
#### You need to source this file EXPLICITLY during normal terminal [non-login] usage.
#### Extra bash profiles are stored in /etc/profile.d/*.bash

case $- in
	hB | *h*B*)
	if [ -z ${BASH_PROFILE+x} ]; then
		export BASH_PROFILE='$HOME/.bash_profile initialized.'
	else
		unset BASH_PROFILE
	fi
	;;
	-- | *)
	exit
	;;
esac

###############################################################################################
set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell

## If Not loaded, load the basic, essential one-time profile [shared among sh/dash/bash/zsh/csh etc].
[ -z ${SH_PROFILE+x} ] && [ -r "${HOME}/.profile" ] && . ${HOME}/.profile

## This PS1 checking separates non-interactive and interactive configurations apart.
## Most running scripts and programs are under non-interactive non-login shells.
## Keep configuration above this line simple and essential to avoid various errors.
[ -z "$PS1" ] && return || shopt -s checkwinsize

alias reloadx="echo 'Reloading .bash_profile' && . $HOME/.bash_profile"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
# Beautify the bash prompt
[ -r "$HOME/.bash_prompt" ] && . "$HOME/.bash_prompt"

## For more user specific bash profiles, source them accordingly.
if [ -d "${HOME}/.profiles.d" ]; then
  for bpf in ${HOME}/.profiles.d/*.bash; do
    [ -r ${bpf} ] && . ${bpf}
  done
  unset bpf
fi

# If possible, add tab completion for many more commands
if [ -f "/etc/bash_completion" ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export BASH_PROFILE='$HOME/.bash_profile reloaded.'
