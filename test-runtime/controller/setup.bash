#!/bin/bash
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}

if [ $# -ne 2 ]
then
    terror "Usage: $0 <impl> <TestNo>"
    exit 1
fi
IMPL_ORG=${1}

IMPL=`echo ${IMPL_ORG} | awk -F\( '{print $1}'`
IMPL_ARGS=`echo ${IMPL_ORG} | awk -F\( '{print $2}' | awk -F\) '{print $1}' | sed -s 's/,/ /g'`

TEST_NO=${2}
#tlog "START SETUP"
bash ${TEST_IMPL_DIR}/controller/setup/${IMPL}-setup.bash ${TEST_NO} ${IMPL_ARGS}
#tlog "END SETUP"

