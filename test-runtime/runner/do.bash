#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <impl>"
    exit 1
fi

IMPL=${1}
echo "#START DO"
bash ${TEST_IMPL_DIR}/runner/do/${IMPL}-do.bash
echo "#END DONE"
