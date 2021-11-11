#!/bin/bash

if [[ ! -d "$HOME/bin" ]]
then
    mkdir "$HOME/bin"
    echo -e "export PATH=$PATH:$HOME/bin" >> "$HOME/.$(basename $SHELL)rc"
fi

if [[ ! -d "$HOME/Projets" ]]
then
    mkdir "$HOME/Projets"
fi

export PATH=$PATH:$HOME/bin
cp ./.updatestatus.sh "$HOME/bin/updatestatus"
cp ./.setstatus.sh "$HOME/bin/setstatus"

