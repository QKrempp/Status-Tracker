#!/bin/bash

if [[ "$(pwd)" == $HOME/Projets* ]]
then
#     echo "Projet custom: $(pwd)"
    PROJECT_FILE=$(pwd)
else
#     echo "Projet par défaut"
    PROJECT_FILE=$(readlink -f "$HOME/Projets")
fi

while getopts ":f:" option
do
    case $option in
        f)  # Specify a file to work in
            PROJECT_FILE=$(readlink -f $OPTARG);;
        \?) # Invalid option
            echo "Error: Invalid option"
            exit;;
    esac
done

find . -type f -name '.status' -print0 | while IFS= read -r -d '' file; do
    file=$(readlink -f "$file")
    STATE=$(cat "$file")
    if [[ $STATE == "done" ]]
    then
        COLOR="green"
    elif [[ $STATE == "broken" ]]
    then
        COLOR="red"
    elif [[ $STATE == "wip" ]]
    then
        COLOR="yellow"
    else
        echo "Error: Invalid status"
        exit
    fi
    echo -e "[Desktop Entry]\nIcon=folder-$COLOR" > "$(dirname "$file")/.directory"
    if [[ "$(dirname "$file")" != $PROJECT_FILE ]]
    then
        UPPERDIR=$(readlink -f "$(dirname "$file")/..")
        echo "file: $file"
        echo "Upper directory: $UPPERDIR"
        while [[ $UPPERDIR != $PROJECT_FILE ]]
        do
            echo "On remonte: $UPPERDIR depuis $file"
            if [[ -a "$UPPERDIR/.status" ]]
            then
                if [[ $(cat "$UPPERDIR/.status") == $STATE ]]
                then
                    echo -e "[Desktop Entry]\nIcon=folder-$COLOR" > "$UPPERDIR/.directory"
                    echo "$STATE" > "$UPPERDIR/.status"
                else
                    echo -e "[Desktop Entry]\nIcon=folder-yellow" > "$UPPERDIR/.directory"
                    echo "wip" > "$UPPERDIR/.status"
                fi
            fi
            UPPERDIR=$(readlink -f "$UPPERDIR/..")
        done
    fi
done


# find . -type f -name ".status" -print0 | while IFS= read -r -d '' file
# do
#     echo "file: $file"
#     if [[ -a "$file" ]]
#     then
#         if [[ $(cat "$file") == "done" ]]
#         then
#             echo -e "[Desktop Entry]\nIcon=folder-green" > "$(dirname "$file")/.directory"
#             UPPERDIR=$(readlink -f "$(dirname $file)/..")
#             while [[ $UPPERDIR != $PROJECT_FILE ]]
#             do
#                 echo "On remonte: $UPPERDIR depuis $file"
#                 if [[ -a "$UPPERDIR/.status" ]]
#                 then
#                     if [[ $(cat "$UPPERDIR/.status") == "done" ]]
#                     then
#                         echo -e "[Desktop Entry]\nIcon=folder-green" > "$UPPERDIR/.directory"
#                     else
#                         echo "wip" > "$UPPERDIR/.status"
#                         echo -e "[Desktop Entry]\nIcon=folder-yellow" > "$UPPERDIR/.directory"
#                     fi
#                 else
#                     echo "done" > "$UPPERDIR/.status"
#                     echo -e "[Desktop Entry]\nIcon=folder-green" > "$UPPERDIR/.directory"
#                 fi
#                 UPPERDIR=$(readlink -f "$UPPERDIR/..")
#             done
#         elif [[ $(cat "$file") == "broken" ]]
#         then
#             echo -e "[Desktop Entry]\nIcon=folder-red" > "$(dirname "$file")/.directory"
#             UPPERDIR=$(readlink -f "$(dirname $file)/..")
#             while [[ $UPPERDIR != $PROJECT_FILE ]]
#             do
#                 echo "On remonte: $UPPERDIR depuis $file"
#                 if [[ -a "$UPPERDIR/.status" ]]
#                 then
#                     if [[ $(cat "$UPPERDIR/.status") == "broken" ]]
#                     then
#                         echo -e "[Desktop Entry]\nIcon=folder-red" > "$UPPERDIR/.directory"
#                     else
#                         echo "wip" > "$UPPERDIR/.status"
#                         echo -e "[Desktop Entry]\nIcon=folder-yellow" > "$UPPERDIR/.directory"
#                     fi
#                 else
#                     echo "broken" > "$UPPERDIR/.status"
#                     echo -e "[Desktop Entry]\nIcon=folder-red" > "$UPPERDIR/.directory"
#                 fi
#                 UPPERDIR=$(readlink -f "$UPPERDIR/..")
#             done
#         elif [[ $(cat "$file") == "wip" ]]
#         then
#             echo -e "[Desktop Entry]\nIcon=folder-yellow" > "$UPPERDIR/.directory"
#             UPPERDIR=$(readlink -f "$UPPERDIR/..")
#             while [[ $UPPERDIR != $PROJECT_FILE ]]
#             do
#                 echo "On remonte: $UPPERDIR depuis $file"
#                 if [[ -a "$UPPERDIR/.status" ]]
#                 then
#                     echo "wip" > "$UPPERDIR/.status"
#                     echo -e "[Desktop Entry]\nIcon=folder-yellow" > "$UPPERDIR/.directory"
#                 fi
#                 UPPERDIR=$(readlink -f "$UPPERDIR/..")
#             done
#         fi
#         echo "Fichier $file actualisé!"
#     fi
# done
