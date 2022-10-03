#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <len>"
    exit 1
fi
LEN=${1}

cat /dev/urandom  | base64 | fold -w ${LEN} | head -n 1

