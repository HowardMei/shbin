###set -x             # Debug mode
set -o nounset     # Strict var declare
set -o errexit     # Exit on error
################################### SHELL INIT PROCESS #######################################
#### Bash specific settings for non-login shells [new local or old ssh terminal/tab, most 
#### running scripts/programs] after login procedure. 

case $- in
	hB | *h*B*)
	if [ -z ${BASH_RC+x} ]; then
		export BASH_RC='$HOME/.bashrc initialized.'
	else
		unset BASH_RC
	fi
	;;
	-- | *)
	exit
	;;
esac

## This PS1 checking separates non-interactive and interactive configurations apart.
## Most running scripts and programs are under non-interactive non-login shells.
## Keep configuration above this line simple and essential to avoid various errors.
[ -z "$PS1" ] && return 

## Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

###############################################################################################
set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
alias reloadx='echo "Reloading $HOME/.bashrc" && . $HOME/.bashrc'
export BASH_RC="$HOME/.bashrc reloaded."
