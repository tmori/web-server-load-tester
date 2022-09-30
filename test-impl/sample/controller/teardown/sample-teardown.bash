#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

if [ $# -ne 1 ]
then
    echo "Usage: $0"
    exit 1
fi
TEST_NO=${1}

source ${TEST_LOGGER}

tlog "TEARDOWN TEST..."
