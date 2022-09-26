#!/bin/bash

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

exit 0
