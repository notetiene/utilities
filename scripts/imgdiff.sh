#!/bin/sh
## TODO: check for arguments
# 1 - URL
if [ ! $1 ]; then
  echo "Usage: $0 <url> [-t filetype] [-d dir]}"
  exit 1
fi
wget -r -A.
