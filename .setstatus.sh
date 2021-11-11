#!/bin/bash

if [[ "$(pwd)" == /home/$USER/Projets* ]]
then
    PROJECT_FILE=.
else
    PROJECT_FILE=~/Projets
fi

while getopts ":f:" option
do
    case $option in
        f)  # Specify a file to work in
            PROJECT_FILE=$OPTARG;;
        \?) # Invalid option
            echo "Error: Invalid option"
            exit;;
    esac
done

if [[ $1 == "done" || $1 == "broken" || $1 == "wip" ]]
then
    echo $1 > "$PROJECT_FILE/.status"
else
    echo "Error: Unknown status"
fi
