#!/bin/bash

for file in *.jpg
do
    filename=$(basename "$file")
    filename="${filename%.*}"
    mkdir "$filename"
    echo "Creating                                      \"$filename/\" directory"
    cp "$file" "$filename/"
    cd "$filename"
    echo "- Change directory:                            \""`pwd`"\""
    png_file=`echo "$file" | sed 's/\.\w*$/.png/'`
    echo "-- Convert \"$file\" to             \"$png_file\""
    /usr/bin/convert "$file" png:"$png_file"
    echo "--- Creating cover_small.png (100x100)"
    /usr/bin/convert -scale 100x100 "$png_file" "cover_small.png"
    echo "--- Creating cover_medium.png (200x200)"
    /usr/bin/convert -scale 200x200 "$png_file" "cover_medium.png"
    echo "--- Moving \"$png_file\" to cover_large.png"
    mv "$png_file" cover_large.png
    echo "--- Removing \"c$file\""
    rm "$file"
    cd ..
    echo "-- Return base directory:                      \""`pwd`"\""
    echo "- Moving \"$filename\" to \"../$filename\""
    mv "$filename" "../$filename"
    echo "DONE"
    echo "------------------------------------------------------------------------------"
done
