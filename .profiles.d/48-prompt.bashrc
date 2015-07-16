[ -z "$(which git)" ] && return

if [ "$COLORTERM" = "gnome-*" ] && [ "$TERM" = "xterm" ] && infocmp "gnome-256color" >/dev/null 2>&1; then
    export TERM="gnome-256color"
elif [ ! "$TERM" = "dumb" ] && infocmp "xterm-256color" >/dev/null 2>&1; then
    export TERM="xterm-256color"
fi

if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [ $(tput colors) -ge 256 ] 2>/dev/null; then
      _MAGENTA=$(tput setaf 9)
      _GREEN=$(tput setaf 190)
      _ORANGE=$(tput setaf 172)
      _BLUE=$(tput setaf 153)
      _GREEN=$(tput setaf 190)
      _PURPLE=$(tput setaf 141)
      _CYAN=$(tput setaf 6)
      _WHITE=$(tput setaf 256)
      _GREY=$(tput setaf 8)
    else
      _MAGENTA=$(tput setaf 1)
      _GREEN=$(tput setaf 2)
      _ORANGE=$(tput setaf 3)
      _BLUE=$(tput setaf 4)
      _PURPLE=$(tput setaf 5)
      _CYAN=$(tput setaf 6)
      _WHITE=$(tput setaf 7)
      _GREY=$(tput setaf 8)
    fi
    _BOLD=$(tput bold)
    _ENDCL=$(tput sgr0)
else
    _MAGENTA="\033[31m"
    _GREEN="\033[32m"
    _ORANGE="\033[33m"
    _BLUE="\033[34m"
    _PURPLE="\033[35m"
    _CYAN="\033[36m"
    _WHITE="\033[37m"
    _GREY="\033[90m"
    _BOLD=""
    _ENDCL="\033[0m"
fi


parse_git_dirty () {
  [ "$(git status 2> /dev/null | tail -n1 | cut -c 1-17)" != "nothing to commit" ] && echo "*"
}

parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}


export PS1="\s-\$"
export PS1="\[$_BOLD\]\[$_ORANGE\]\u@\H:\[$_GREEN\]\w\[$_MAGENTA\] \$([[ -n \$(git branch 2>/dev/null) ]] && echo \"[\")\$(parse_git_branch)\$([[ -n \$(git branch 2>/dev/null) ]] && echo \"]\")\n$\[$_ENDCL\]"
export PS2="\[$_ORANGE\]$ \[$_ENDCL\]"

