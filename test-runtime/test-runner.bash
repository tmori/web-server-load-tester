#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

if [ $# -ne 6 ]
then
    echo "Usage: $0 <prepare> <do> <done> <do-repeat-num> <id> <testNo>"
    exit 1
fi

PREPARE=${1}
DO=${2}
DONE=${3}
DO_REPEAT_NUM=${4}
ID=${5}
TEST_NO=${6}
DIRPATH=`pwd`/`dirname ${0}`

# env check
bash ${DIRPATH}/test-env-check.bash
if [ $? -ne 0 ]
then
    exit 1
fi

# do test
PERF_LOGPATH=${TEST_PERFPATH}/item-${TEST_NO}/response_time-${ID}.txt

bash ${DIRPATH}/runner/prepare.bash ${PREPARE} ${ID}
for repeat_id in `seq ${DO_REPEAT_NUM}`
do
    (time -p bash ${DIRPATH}/runner/do.bash ${DO}  ${ID} ${repeat_id}) 2>> ${PERF_LOGPATH}
done
bash ${DIRPATH}/runner/done.bash ${DONE}  ${ID}
