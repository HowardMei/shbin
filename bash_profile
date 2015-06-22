export TERM="${TERM:=xterm}"
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
[ -d "/opt/bin" ] && export PATH="/opt/bin:$PATH"
[ -d "/opt/sbin" ] && export PATH="/opt/sbin:$PATH"
[ -d "/opt/shbin" ] && export PATH="/opt/shbin:$PATH"
## Prefer US English and use UTF-8
#export LANG="en_US"
#export LC_ALL="en_US.UTF-8"

# Don't check mail when opening terminal.
unset MAILCHECK

# Append to the Bash history file and Erase duplicates
shopt -s histappend
# Limit the history size to prevent info leakage
export HISTSIZE=18
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
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
export PS1="\[\033[33m\][\u@\H:\[\033[32m\]\w\[\033[33m\]]$\[\033[0m\]"
if echo "hi" | grep --color=auto i >/dev/null 2>&1; then
    export GREP_OPTIONS="--color=auto"
    export GREP_COLOR="1;33"
fi
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'



# Define some basic aliaes and functions
unalias -a
# Enable aliases to be sudo’ed
alias sudo='sudo '
alias su='su - '
alias mkdir='mkdir -p'
# Mv all current files and folders one dir up and omit the parent dir
alias mvup='find . -mindepth 1 -maxdepth 1 -exec mv -t.. -- {} +'
alias what='type -a'
alias unsetall='unset all;set +o nounset'
alias cls='clear;set +o nounset'
alias clr='reset;clear;set +o nounset'
# List all files colorized in long format
alias ll="ls -lph --color"
alias lt='ll -t'
# List all files colorized in long format, including dot files
alias la="ls -lpha --color"
alias ld='__lsdir() { local p="$1";ls --almost-all -lhd $(realpath ${p:-$(pwd)})/*/ 2>/dev/null; unset -f __lsdir; }; __lsdir'
alias lf='__lsf() { local p="$1";ls --almost-all -lha $(realpath ${p:-$(pwd)}) 2>/dev/null | grep -v ^d | grep -v ^l; unset -f __lsf; }; __lsf'
alias lh='__lshidden() { local p="$1";ls --almost-all -d $(realpath ${p:-$(pwd)})/.??* 2>/dev/null; unset -f __lshidden; }; __lshidden'
alias lhf='__lsfhidden() { local p="$1";ls --almost-all -lhd $(realpath ${p:-$(pwd)})/.??* 2>/dev/null | grep -v ^d; unset -f __lsfhidden; }; __lsfhidden'
alias lhd='__lsdirhidden() { local p="$1";ls --almost-all -lhd $(realpath ${p:-$(pwd)})/.??*/ 2>/dev/null; unset -f __lsdirhidden; }; __lsdirhidden'
alias ls="command ls --color"
alias lu='du -ach --time --max-depth=1'
alias reload=". $HOME/.bash_profile"
alias reloadx='dotload'
alias memclr='free -mh;sync;echo 3 > /proc/sys/vm/drop_caches;free -mh'
alias hisp='__lshis() { local p="$*";history | estrip -u | grep -i "${p:-""}" | grep -v grep | grep -v hisp; unset -f __lshis; }; __lshis'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias geois='whois $(pubip) 2>/dev/null | efilters -rl "^country: *" | estrips -r "^country: *" | head -1'
## get top process eating memory
alias memtop='__memls() { local p="$1"; ps -e -o pid,uname,comm,cmd,pmem,pcpu --sort=-pmem,-pcpu | head -n ${p:=11}; unset -f __memls; }; __memls'
## get top process eating cpu ##
alias cputop='__cpuls() { local p="$1"; ps -e -o pid,uname,comm,cmd,pcpu,pmem --sort=-pcpu,-pmem | head -n ${p:=11}; unset -f __cpuls; }; __cpuls'
alias pstop='__psls() { local p="$1"; watch -n 0.1 "ps -e -o pid,uname,comm,cmd,pcpu,pmem --sort=-pcpu,-pmem | head -n ${p:=11}"; unset -f __psls; }; __psls'
alias psa='__pslsa() { local p="$1"; ps -e -o pid,uname,comm,pcpu,pmem,etime,cmd --sort=-pcpu,-pmem | head -n ${p:=101}; unset -f __pslsa; }; __pslsa'
alias psp='__pslsp() { local p="$@"; local ptot="$(ps -e -o pid,uname,comm,pcpu,pmem,etime,cmd --sort=-pcpu,-pmem)";local phead="$(echo "$ptot" | head -1)";local pbody="$(echo "$ptot" | sed '1d' | grep -i ${p:-""} | grep -v grep)";echo "$phead";echo "$pbody";unset -f __pslsp; }; __pslsp'
alias vex='__vex() { [ $# -eq 1 ] && [ "$1" == "-q" ] && [ -r "bin/activate" ] && deactivate && return 0;[ -r "${!#}/bin/activate" ] && cd "${!#}" && . bin/activate || virtualenv "$@";[ -d "${!#}" ] && cd "${!#}";[ -r "bin/activate" ] && . bin/activate; unset -f __vex; }; __vex'


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Beautify the bash prompt
[ -r "$HOME/.bash_prompt" ] && . "$HOME/.bash_prompt"

# If possible, add tab completion for many more commands
[ -r "/etc/bash_completion" ] && . "/etc/bash_completion"

###############################################################################################
set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
