#!/bin/bash
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}

if [ $# -ne 1 ]
then
    terror "Usage: $0 <impl>"
    exit 1
fi

IMPL=${1}
#tlog "START DONE"
bash ${TEST_IMPL_DIR}/runner/done/${IMPL}-done.bash
#tlog "END DONE"
