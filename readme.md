# shbin: Usefull binary tools to enhance the minimal *nix sh/bash environment for daily tasks.

## Installation:
     Step1: Copy shbin into $HOME/.shbin
     Step2: export PATH="$HOME/.shbin:$PATH"
     OR
     Step1: Copy shbin into $HOME/.shbin or mv shbin /opt/xbin
     Step2:
     cp bashrc $HOME/.bashrc
     cp bash_profile $HOME/.bash_profile
     cp bash_prompt $HOME/.bash_prompt
     Step3: . $HOME/.bashrc

## Usage: shbin help shbin
     shbin version
     shbin list
     shbin help
     shbin show

## Docker cmd helpers:
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
    Some utility functions come from online sources but lost the record of the origins
    due to many refactors before git tracking. Thanks for all the original authors.

## Testing: TBD. It's recommended for development environment only though it's quite mature.
   shbin is suitable for sh/bash environment. Use shbin/shc if you're not sure about the shell type.

## Contribute: currently not actively managed. Please fork as you wish and send pull requests.
   Issues support are limited in bugfixes. New features requests might not be accepted.

## License: Apache 2.0 License
