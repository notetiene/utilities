#!/usr/bin/env bash
filename="$1"
while IFS="," read f1 f2
do
    wget -O "$f1" "$f2"
done < "$filename"
