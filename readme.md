# shbin: sh/sash scripted binary tools with minimal dependency to enhance the *nix sh/bash environment.

## Installation:
     Auto: bash -c "$(curl -sSL https://github.com/HowardMei/shbin/raw/refs/heads/master/install.sh)" 
     Manually:
        Step1: Copy shbin into /opt/shbin OR ~/.shbin
                        cp -rf shbin ~/.shbin 
                chmod a+x -R ~/.shbin
        Step2: Copy all dotfiles in shdot into ~/ 
                        cp -rf shdot/.* ~/
        Step3: . $HOME/.bash_profile
        Step4: Copy conf files in shsec to /etc/...

## Usage: shbin help shbin
     shbin version
     shbin list
     shbin help
     shbin show
     shbin ext
     
You may enable or disable extensions by running: 
	shbin ext filedir dockerkt

## Docker cmd helpers in ext.dockerkt:
    shbin list do*
    dorun: interactive bash runner
           dorun mubiic/ubdeose:en_US1.0 bash "shbin -v;doimg"
    dolsi: list all the images key info, check the usage using
            shbin help dolsi
    dollc: list all the containers key info
    donsh: log into the running container without ssh using nesenter/exec
            shbin show donsh
    doclr: bulk remove the docker images using glob matching:
            doclr mubiic/*
    docls: doclr plus <none> images cleaning
    dostc/dokic: stop/kill the running containers
    dormi/dormc: remove images/containers by id or name
    doget: bulk pull images from the docker registry/hub
    The power lies in the cmd combinations like:
        dorun debian:jessie bash "sleep 120"&
        donsh $(dollc -ri debian:jessie)

## Credits:
    Some utility functions come from online sources but I lost the record of the origins
    due to many refactors before git tracking. Thanks for all the original authors.
    References: 
    https://github.com/koalaman/shellcheck
    https://github.com/HariSekhon/DevOps-Bash-tools    
    https://github.com/AverageJoesHosting/HostingToolkit-Scripts
    https://github.com/awesome-lists/awesome-bash
    https://github.com/dylanaraps/pure-sh-bible  
    https://github.com/mathiasbynens/dotfiles
    https://github.com/gauchocode/brolit-shell 
    https://github.com/konstruktoid/hardening 
    https://github.com/wbfoss/Ubuntu-Security-Hardening-Script  
    https://github.com/Miraitowa700/Best-practice/blob/main/Service/SSH%20Security%20Practice.md


## Testing: TBD. It's recommended for development environment only and take your own risk.
   shbin is suitable for sh/bash environment. It requires only sed, awk, grep, cut, tr, sort,
   head, tail, find and optionally curl [for pubip] etc.

## Contribute: currently not actively managed. Please fork as you wish and send pull requests.
   Issues support are limited in bugfixes. New features requests might not be accepted.

## License: Apache 2.0 License
