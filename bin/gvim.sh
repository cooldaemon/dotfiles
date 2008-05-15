#!/bin/sh

VI_COMMAND=/Applications/MacPorts/Vim/Vim.app

if [ $# = 0 ]
    open -a $VI_COMMAND
then
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

