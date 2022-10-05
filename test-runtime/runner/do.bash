#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}

if [ $# -ne 3 ]
then
    terror "Usage: $0 <impl> <id> <repeat_id>"
    exit 1
fi
IMPL_ORG=${1}

IMPL=`echo ${IMPL_ORG} | awk -F\( '{print $1}'`
IMPL_ARGS=`echo ${IMPL_ORG} | awk -F\( '{print $2}' | awk -F\) '{print $1}' | sed -s 's/:/ /g'`
ID=${2}
REPEAT_ID=${3}

# env check
if [ -f ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash ]
then
    :
else
    terror "ERROR: ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash is not found"
    exit 1
fi

#tlog "START DO"
bash ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash ${ID} ${REPEAT_ID} ${IMPL_ARGS}
#tlog "END DO"
