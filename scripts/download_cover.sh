#!/bin/sh
MUSICDIR=$(xdg-user-dir MUSIC)
# fetch new art
beet fetchart

# resize covers
find "$MUSICDIR" -iname "cover.jpg" |
    find . -type f -iname 'cover.jpg' -exec bash -c '
  for file do
    EXTENSION="${file##*.}"
    FILENAME="${file%.*}"
    NEW_MED_NAME="${FILENAME}_med.${EXTENSION}"
    NEW_SMALL_NAME="${FILENAME}_small.${EXTENSION}"
    if [ ! -f "${NEW_MED_NAME}" ]; then
        convert "${file}" -adaptive-resize 200x200 "${NEW_MED_NAME}"
    fi
    if [ ! -f "${NEW_SMALL_NAME}" ]; then
       convert "${file}" -adaptive-resize 100x100 "${NEW_SMALL_NAME}"
    fi
  done
' bash {} +
