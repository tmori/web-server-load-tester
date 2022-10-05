#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <base>"
    exit 1
fi
BASE=${1}

expr ${RANDOM} % ${BASE} \+ 1
