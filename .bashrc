set -o nounset     # Strict var declare
set -o errexit     # Exit on error
################################### SHELL INIT PROCESS #######################################
#### Bash specific settings for non-login shells [new local or old ssh terminal/tab, most 
#### running scripts/programs]
#### and remote ssh login]. In desktop environment, this file will be sourced ONLY ONCE during startup.
#### You need to source this file EXPLICITLY during normal terminal [non-login] usage.
#### This is a single user profile, global bash profiles are stored in /etc/profile.d/
unset BASH_RC
export BASH_RC='Loaded Once'


## This PS1 checking separates non-interactive and interactive configurations apart.
## Most running scripts and programs are under non-interactive non-login shells.
## Keep configuration above this line simple and essential to avoid various errors.
[ -z "$PS1" ] && return 

# Append to the Bash history file and Erase duplicates
shopt -s histappend
# Limit the history size to prevent info leakage
export HISTSIZE=128
export HISTFILESIZE=128
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:cls:history"
export AUTOFEATURE=true autotest

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

# Always enable colored ls and grep output
export CLICOLOR="1"
export PS1="\[\033[33m\][\u@\H:\[\033[32m\]\w\[\033[33m\]]\n$\[\033[0m\]"
if echo "hi" | grep --color=auto i >/dev/null 2>&1; then
    export GREP_OPTIONS="--color=auto"
    export GREP_COLOR="1;33"
fi
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

## Load bash aliases everytime creating a new tab or running a program.
[ -r "${HOME}/.bash_aliases" ] && . ${HOME}/.bash_aliases

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -r "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

alias reloadx="echo 'Reloading .bash_profile & .bashrc' && . $HOME/.bash_profile && . $HOME/.bashrc"

## For more user specific bash resource configurations, source them everytime creating a new tab or running a program.
## Configure programs environment here, like rvm, gvm and nvm etc.
if [ -d "${HOME}/.profiles.d" ]; then
  for pf in ${HOME}/.profiles.d/*.bashrc; do
    [ -r ${pf} ] && . ${pf} 
  done
  unset pf
fi


###############################################################################################
set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
