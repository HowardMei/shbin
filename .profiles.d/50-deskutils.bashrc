
alias resharevb='killall VBoxClient && VBoxClient-all'
alias folder='__folder() { local p=$(pwd); nautilus ${p} >/dev/null 2>&1; unset -f __folder; }; __folder'
alias markd='__markd() { local fn="$(pwd)/${1}"; haroopad -f ${fn} >/dev/null 2>&1; unset -f __markd; }; __markd'
alias ifreset='sudo ifdown -a && sudo ifup -a'
