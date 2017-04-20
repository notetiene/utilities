#!/bin/sh
# org-annotation-helper -- pass a remember-url to emacs
#
# Author: Geert Kloosterman <g.j.kloosterman@gmail.com>
# Date: Sat Nov 19 22:33:18 2005

if [ -z "$1" ]; then
    echo "$0: Error: no arguments given!" 1>&2
    exit 1
fi

# To test uncomment following line
#echo $1 >> /tmp/remember.out

emacsclient --eval "(progn (bzg/org-annotation-helper \"$1\" ) nil)"