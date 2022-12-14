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

IMPL=${1}
TEST_NO=${2}
#tlog "START TEARDOWN"
bash ${TEST_IMPL_DIR}/controller/teardown/${IMPL}-teardown.bash ${TEST_NO}
#tlog "END TEARDOWN"
