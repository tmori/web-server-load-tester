#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}
if [ $# -ne 1 ]
then
    terror "Usage: $0 <id>"
    exit 1
fi
ID=${1}

tlog "ID=${ID}:DONE TEST..."
