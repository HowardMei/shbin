set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
[ -z "${BASH_RC}" ] && return 

# Define full featured bash aliaes and functions
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
alias ll="ls -lph --color --group-directories-first"
alias lt='ll -t'
# List all files colorized in long format, including dot files
alias la="ls -lpha --color --group-directories-first"
alias ld='__lsdir() { local p="$1";ls --almost-all -lhd $(realpath ${p:-$(pwd)})/*/ 2>/dev/null; unset -f __lsdir; }; __lsdir'
alias lf='__lsf() { local p="$1";ls --almost-all -lha $(realpath ${p:-$(pwd)}) 2>/dev/null | grep -v ^d | grep -v ^l; unset -f __lsf; }; __lsf'
alias lh='__lshidden() { local p="$1";ls --almost-all -d $(realpath ${p:-$(pwd)})/.??* 2>/dev/null; unset -f __lshidden; }; __lshidden'
alias lhf='__lsfhidden() { local p="$1";ls --almost-all -lhd $(realpath ${p:-$(pwd)})/.??* 2>/dev/null | grep -v ^d; unset -f __lsfhidden; }; __lsfhidden'
alias lhd='__lsdirhidden() { local p="$1";ls --almost-all -lhd $(realpath ${p:-$(pwd)})/.??*/ 2>/dev/null; unset -f __lsdirhidden; }; __lsdirhidden'
alias ls="command ls --color --group-directories-first"
alias lu='du -ach --time --max-depth=1'
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


## echo "$BASH_SOURCE mark#2"
