#!/bin/sh
# Compress all all PDF files in a directory with XZ.

find . -type f -name "*.pdf" -exec xz {} \;
