####################################### SHELL PROFILE #########################################
#### Fall back profile for login shells [docker login, su - or *sh --login/-l and ssh login]. 
#### In bash or most desktop linux, this file will NOT be sourced during user login session
#### unless .bash_profile or .bash_login sources this file EXPLICITLY. We do it in .bash_profile.
#### One-time setup was done by .profile (or .bash_profile), and per-shell/subshell by .bashrc.
#### Extra profiles are stored in /etc/profile.d/*.sh


if [ -z ${SH_PROFILE+x} ]; then
	export SH_PROFILE='$HOME/.profile initialized.'
else
	unset SH_PROFILE
fi

## Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH
[ -d "/opt/bin" ] && export PATH="/opt/bin:${PATH}"
[ -d "/opt/sbin" ] && export PATH="/opt/sbin:${PATH}"
[ -d "/opt/shbin" ] && export PATH="/opt/shbin:${PATH}"
[ -d "${HOME}/.shbin" ] && export PATH="${HOME}/.shbin:${PATH}"
[ -d "/opt/app/bin" ] && export PATH="/opt/app/bin:${PATH}"

## This PS1 checking separates non-interactive and interactive configurations apart.
## Most running scripts and programs are under non-interactive non-login shells.
## Keep configuration above this line simple and essential to avoid various errors.
[ -z "$PS1" ] && return 

export PS1="[${USER}]:$"

# Don't check mail when opening terminal.
unset MAILCHECK
# Define some basic aliases and functions
unalias -a
# Enable aliases to be sudo’ed
alias sudo='sudo '
alias su='su - '
alias mkdir='mkdir -p'
# Mv all current files and folders one dir up and omit the parent dir
alias what='type -a'
alias unsetall='unset all;set +o nounset'
alias cls='clear_console || clear;set +o nounset'
alias clr='reset;clear_console || clear;set +o nounset'
# List all files colorized in long format
alias ll="ls -lph --color"
alias lt='ll -t'
alias ls="command ls --color"
alias lu='du -ach --time --max-depth=1'
alias reloadx='echo "Reloading $HOME/.profile" && . $HOME/.profile'
alias memclr='free -mh;sync;echo 3 > /proc/sys/vm/drop_caches;free -mh'
alias path='echo -e ${PATH//:/\\n}'

###############################################################################################

## For more user specific dash profiles, source them accordingly.
if [ -d "${HOME}/.profiles.d" ]; then
  for dpf in ${HOME}/.profiles.d/*.sh; do
    [ -r ${dpf} ] && . ${dpf}
  done
  unset dpf
fi

export SH_PROFILE='$HOME/.profile reloaded.'
