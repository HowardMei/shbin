set +o nounset     # Don't mess up the auto completion
set +o errexit     # Don't mess up the interactive shell
[ -d "/opt/bin" ] && export PATH="/opt/bin:${PATH}"
[ -d "/opt/sbin" ] && export PATH="/opt/sbin:${PATH}"
[ -d "/opt/app/bin" ] && export PATH="/opt/app/bin:${PATH}"

[ -d "/opt/shbin" ] && export PATH="/opt/shbin:${PATH}"
[ -d "${HOME}/.shbin" ] && export PATH="${HOME}/.shbin:${PATH}"


