#!/bin/sh

VI_COMMAND=/Applications/MacVim.app

if [ $# = 0 ]
then
    open -a $VI_COMMAND
else
    while [ $# != 0 ]
    do
        if [ ! -e $1 ]
        then
            touch $1
        fi
        open -a $VI_COMMAND $1
        shift
    done
fi

exit

