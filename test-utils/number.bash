#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 <len> <number>"
    exit 1
fi
LEN=${1}
NUMBER=${2}

printf "%0${LEN}d\n"  ${NUMBER}
