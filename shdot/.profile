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



###############################################################################################


export SH_PROFILE='$HOME/.profile reloaded.'
