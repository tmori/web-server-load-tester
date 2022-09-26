#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

if [ $# -ne 4 ]
then
    echo "Usage: $0 <prepare> <do> <done> <do-repeat-num>"
    exit 1
fi

PREPARE=${1}
DO=${2}
DONE=${3}
DO_REPEAT_NUM=${4}
DIRPATH=`pwd`/`dirname ${0}`

# env check
bash ${DIRPATH}/test-env-check.bash
if [ $? -ne 0 ]
then
    exit 1
fi

# do test
bash ${DIRPATH}/runner/prepare.bash ${PREPARE}
for i in `seq ${DO_REPEAT_NUM}`
do
    bash ${DIRPATH}/runner/do.bash ${DO}
done
bash ${DIRPATH}/runner/done.bash ${DONE}
