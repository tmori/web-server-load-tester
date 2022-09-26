#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <impl>"
    exit 1
fi

IMPL=${1}
echo "#START DONE"
bash ${TEST_IMPL_DIR}/runner/done/${IMPL}-done.bash
echo "#END DONE"
