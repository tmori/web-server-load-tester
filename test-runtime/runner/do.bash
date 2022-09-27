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
IMPL=${1}
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
bash ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash ${ID} ${REPEAT_ID}
#tlog "END DO"
