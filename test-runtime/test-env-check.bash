#!/bin/bash

if [ $# -ne 1 ]
then
    echo "ERROR: $0 <impl> is not set"
    exit 1
fi
IMPL=${1}

if [ -z ${TEST_IMPL_DIR} ]
then
    echo "ERROR: TEST_IMPL_DIR is not set"
    exit 1
fi

if [ -d ${TEST_IMPL_DIR} ]
then
    :
else
    echo "ERROR: ${TEST_IMPL_DIR} is not found"
    exit 1
fi

if [ -f ${TEST_IMPL_DIR}/runner/prepare/${IMPL}-prepare.bash ]
then
    :
else
    echo "ERROR: ${TEST_IMPL_DIR}/runner/prepare/${IMPL}-prepare.bash is not found"
    exit 1
fi

if [ -f ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash ]
then
    :
else
    echo "ERROR: ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash is not found"
    exit 1
fi


if [ -f ${TEST_IMPL_DIR}/runner/done/${IMPL}-done.bash ]
then
    :
else
    echo "ERROR: ${TEST_IMPL_DIR}/runner/done/${IMPL}-done.bash is not found"
    exit 1
fi

exit 0
