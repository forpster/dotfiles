#!/bin/sh

GIT_CMD="git fetch -ap && git pull"

while getopts ":m" opt; do
    case $opt in
        m)
            echo "Enabled switching everything to master"
            GIT_CMD="git checkout master && git fetch -ap && git pull"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            echo "\t-m to switch all branches to master before pulling"
            exit 1
            ;;
    esac
done

# pull all the things
cd ~/rapid7
for dir in `find * -maxdepth 0 -type d -print`;
do
    if [ -e $dir/.git ]
    then
        (cd $dir && /bin/echo -n "$dir " && git branch | grep \* | cut -d ' ' -f2- && echo && eval $GIT_CMD)
    fi
done

(cd ~/src/dotfiles && eval $GIT_CMD)

# bundle update some of the things
#echo "cukesrc bundle update"
#cd ~/rapid7/nexpose/src/internal/private/cucumber && bundle update
#echo "vuln-tools bundle update"
#cd ~/rapid7/vuln-tools/ && bundle update
