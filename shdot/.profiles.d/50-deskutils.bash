set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
alias resharevb='killall VBoxClient && VBoxClient-all'
alias folder='__folder() { local p=$(pwd); nautilus ${p} >/dev/null 2>&1 || thunar ${p} >/dev/null 2>&1; unset -f __folder; }; __folder'
alias markd='__markd() { local fn="$(pwd)/${1}"; haroopad -f ${fn} >/dev/null 2>&1; unset -f __markd; }; __markd'
alias subl='__subl() { local fn="$(pwd)/${1}"; sublime_text ${fn} >/dev/null 2>&1; unset -f __subl; }; __subl'
