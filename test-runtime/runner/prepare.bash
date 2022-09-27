#!/bin/bash
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}

if [ $# -ne 2 ]
then
    terror "Usage: $0 <impl> <id>"
    exit 1
fi
IMPL=${1}
ID=${2}

if [ -f ${TEST_IMPL_DIR}/runner/prepare/${IMPL}-prepare.bash ]
then
    :
else
    terror "ERROR: ${TEST_IMPL_DIR}/runner/prepare/${IMPL}-prepare.bash is not found"
    exit 1
fi

#tlog "START PREPARE"
bash ${TEST_IMPL_DIR}/runner/prepare/${IMPL}-prepare.bash ${ID}
#tlog "END PREPARE"
