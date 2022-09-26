#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

if [ $# -ne 1 ]
then
    echo "Usage: $0 <impl>"
    exit 1
fi

IMPL=${1}
DIRPATH=`pwd`/`dirname ${0}`

# env check
bash ${DIRPATH}/test-env-check.bash ${IMPL}
if [ $? -ne 0 ]
then
    exit 1
fi

# do test
bash ${DIRPATH}/runner/prepare.bash ${IMPL}
bash ${DIRPATH}/runner/do.bash ${IMPL}
bash ${DIRPATH}/runner/done.bash ${IMPL}
