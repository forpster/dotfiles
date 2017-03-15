#!/bin/sh

# pull all the things
cd ~/rapid7
for dir in `find * -maxdepth 0 -type d -print`;
do
    if [ -e $dir/.git ]
    then
        (cd $dir && /bin/echo -n "$dir " && git branch | grep \* | cut -d ' ' -f2- && echo && git fetch -ap && git pull)
    fi
done

# bundle update some of the things
echo "cukesrc bundle update"
cd ~/rapid7/nexpose/src/internal/private/cucumber && bundle update
echo "vuln-tools bundle update"
cd ~/rapid7/vuln-tools/ && bundle update
