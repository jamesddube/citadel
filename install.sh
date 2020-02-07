#!/bin/bash

mkdir -p  ${HOME}/.certbot/{certificates,config}

cp -rv . ${HOME}/.certbot/

chmod +x ${HOME}/.certbot/certbot.sh

FILE=/usr/local/bin/certbot

if [ -f "$FILE" ]; then
    sudo rm -v $FILE
fi

sudo ln -s ${HOME}/.certbot/certbot.sh /usr/local/bin/certbot

echo "certbot installed...."
