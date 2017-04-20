#!/bin/sh

if [ $# -ne 2 ]
then
    echo "Please specify two files!" 1>&2
    echo "example: $0 file1 file2" 1>&2
    echo "This will swap two files" 1>&2
    exit 0
fi

temp="$1.bak"

mv $1 $temp
mv $2 $1
mv $temp $2
exit 0
