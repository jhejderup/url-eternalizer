#!/bin/bash

## Check if a file is provided
if [[ $# -eq 0 ]]; then
    echo "ERR -- File is missing!"
    exit 1
fi

if [[ "${1:0:1}" != / && "${1:0:2}" != ~[/a-z] ]]
then
    echo "ERR -- If you intended to pass a host directory, use absolute path!"
    exit 1
fi

## Build image if it doesnt exist
if [[ "$(docker images -q url-eternalizer:0.1 2> /dev/null)" == "" ]]; then
  echo "Bulding url-eternalizer:0.1 image"
  docker build --tag url-eternalizer:0.1 .
else
    echo "Using pre-built url-eternalizer:0.1 image"
fi

FILE_NAME=$(basename -- "$1")
CONVERTED_FILE="${1}.eternal"

## Convert the file
echo "RUN -- url_eternalizer.rb"
docker run -it --rm -v "$1":/"$FILE_NAME" url-eternalizer:0.1 "$FILE_NAME" > $CONVERTED_FILE
echo "DONE -- url_eternalizer.rb"