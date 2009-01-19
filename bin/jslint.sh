#!/bin/sh

if [ ! -f $1 -o  ! -r $1 ]; then
  echo "Usage: $0 [JavaScript Source File]";
  exit 1
fi

js ~/bin/js/jslint.js $1 `cat $1`
exit 0

