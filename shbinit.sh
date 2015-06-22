__ScriptType="server"
__ScriptUser="$(id -un 2>/dev/null || whoami 2>/dev/null)"
__ScriptDir="$(pwd)"

usage() {
    echo "shbinit usage: shbinit [server|desktop] [-u | --users user1 user2 ... userN]"
    echo "curl -#SL https://init.mvtocloud.com/shinit/shbinit.sh | sudo bash -s -- desktop"
    echo "curl -#SL https://init.mvtocloud.com/shinit/shbinit.sh | sudo sh -s -- vagrant"
    echo "curl -#SL https://init.mvtocloud.com/shinit/shbinit.sh | sudo sh -s -- -d -u howardmei"
    echo "curl -#SL https://init.mvtocloud.com/shinit/shbinit.sh | sudo bash -s -- howardmei devops"
    echo "curl -#SL https://init.mvtocloud.com/shinit/shbinit.sh | sudo bash -s -- desktop --users howardmei cheeyic malcolmwu"
}

if [ $# -lt 1 ]; then
    __HomeEnvUser="$(echo ${__ScriptUser} | tr -d 'root' | tr -d ' ' | tr -d '\n')"
elif [ $# -eq 1 ]; then
    case "$1" in
        -h | --help | help | --usage | usage)
        usage && exit 0
        ;;
        -s | --server | server)
            __ScriptType="server"
        ;;
        -d | --desktop | desktop)
            __ScriptType="desktop"
        ;;
        -- | *)
            __HomeEnvUser="${1}"
        ;;
    esac
elif [ $# -ge 2 ]; then
    case "$1" in
        -u | --user | --users)
            shift
            __HomeEnvUser="$@"
        ;;
        -s | --server | server)
            __ScriptType="server"
            shift
            case "$1" in
                -u | --user | --users)
                    shift
                    __HomeEnvUser="$@"
                ;;
                -- | *)
                    __HomeEnvUser="$@"
                ;;
            esac
        ;;
        -d | --desktop | desktop)
            __ScriptType="desktop"
            shift
            case "$1" in
                -u | --user | --users)
                    shift
                    __HomeEnvUser="$@"
                ;;
                -- | *)
                    __HomeEnvUser="$@"
                ;;
            esac
        ;;
        -- | *)
            __HomeEnvUser="$@"
        ;;
    esac
fi

__ScriptTmp="$(mktemp -d)"
__ScriptBase="https://init.mvtocloud.com/shinit"
__ScriptFile="shbin-latest.tar.gz"
__ScriptTag="$(date '+%Y%m%d')"
__ScriptUrl="${__ScriptBase}/${__ScriptType}/${__ScriptFile}?tag=${__ScriptTag}"

#######################################################################################################################

iscommand() {
    command -v "$@" > /dev/null 2>&1
}

yesbash() {
    if [ -n "$_" ] && [ -n "$(echo "$_" | grep -i "/bash" 2>/dev/null)" ]; then
        return 0
    elif [ -x "$(which bash)" ]; then
        return 0
    elif [ -x "/bin/bash" ]; then
        return 0
    elif [ -x "/usr/bin/bash" ]; then
        return 0
    else
        return 1
    fi
}

#######################################################################################################################
echo "Installation Begins: shbinit will use the latest shbin tarball from ${__ScriptUrl}"

if iscommand curl; then
    curl -#SL "${__ScriptUrl}" -o "${__ScriptTmp}/shbin.tar.gz" || exit 1
elif iscommand wget; then
    wget -cnvq "${__ScriptUrl}" -O "${__ScriptTmp}/shbin.tar.gz" || exit 1
else
    echo "Please install curl/wget and ca-certificates before using this script. Exiting ..." >&2
    exit 0
fi

if [ ! -f "${__ScriptTmp}/shbin.tar.gz" ]; then
    echo "No ${__ScriptTmp}/shbin.tar.gz is found. Please check the downloading status. Exiting ..." >&2
    exit 1
else
    cd "${__ScriptTmp}" && tar xzvf shbin.tar.gz
    if [ ! -d "${__ScriptTmp}/shbin" ]; then
        echo "Tarball ${__ScriptTmp}/shbin.tar.gz extraction failed. Maybe the tarball is broken. Exiting ..." >&2
        exit 1
    fi
fi

if iscommand sudo && sudo -n uptime 2>&1 | grep -iq load; then
    echo "Run shbinit as SUPERUSER ${__ScriptUser} to install shbin[${__ScriptType}] into /opt/shbin"
    if [ -x "/opt/shbin/shbin" ]; then
        echo
        echo "Found following /opt/shbin/shbin present:" && /opt/shbin/shbin
        echo "It will be replaced by the latest version of shbin."
        echo
        \rm -rf /opt/shbin
    fi
    [ -d "${__ScriptTmp}/shbin" ] && sudo mv -f "${__ScriptTmp}/shbin" /opt/shbin && sudo chmod 0755 -R /opt/shbin
    [ -x "/opt/shbin/shbin" ] && echo "The latest shbin has been installed successfully:" && export PATH="/opt/shbin:$PATH" && /opt/shbin/shbin
    if yesbash; then
        echo "Installing dotfiles like .bash_* and .git* into /root"
        sudo cp -f ${__ScriptTmp}/.bash* /root/
        sudo cp -f ${__ScriptTmp}/.git* /root/
        sudo cp -f ${__ScriptTmp}/.inputrc /root/.inputrc
    fi
    if yesbash && [ -n "${__HomeEnvUser}" ]; then
        curuser=${__ScriptUser}
        for curuser in ${__HomeEnvUser}; do
            if [ -d "/home/${curuser}" ]; then
                echo "Installing dotfiles like .bash* and .git* into /home/${curuser}"
                sudo cp -f ${__ScriptTmp}/.bash* /home/${curuser}/ && sudo chown ${curuser} /home/${curuser}/.bash*
                sudo cp -f ${__ScriptTmp}/.git* /home/${curuser}/ && sudo chown ${curuser} /home/${curuser}/.git*
                sudo cp -f ${__ScriptTmp}/.inputrc /home/${curuser}/.inputrc && sudo chown ${curuser} /home/${curuser}/.inputrc
            else
                echo "No /home/${curuser} is found, skipping dotfiles installation for NONUSER ${curuser}"
            fi
        done
    fi
else
    echo "Run shbinit as USER ${__ScriptUser} to install shbin[${__ScriptType}] into /home/${__ScriptUser}/.shbin"
    yesbash || echo "and install bash dotfiles to ${HOME} skipping all other home dir of ${__HomeEnvUser}"
    [ -d "/home/${__ScriptUser}" ] && tar -C "/home/${__ScriptUser}/" xzvf "${__ScriptTmp}/shbin.tar.gz"
    if [ -f "/home/${__ScriptUser}/shbin/shbin" ]; then
        echo "Moving from /home/${__ScriptUser}/shbin to /home/${__ScriptUser}/.shbin"
        mv -f "/home/${__ScriptUser}/shbin" "/home/${__ScriptUser}/.shbin"
        "/home/${__ScriptUser}/.shbin"/shbin
        [ -x "/opt/shbin/shbin" ] && echo "The latest shbin has been installed successfully:" && export PATH="/opt/shbin:$PATH" && /opt/shbin/shbin
    fi
fi

\rm -rf ${__ScriptTmp}

cd ${__ScriptDir}
unset -f iscommand yesbash
echo "Load the new $HOME/.bash_profile to use shbin"
