#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <impl>"
    exit 1
fi

IMPL=${1}
echo "#START PREPARE"
bash ${TEST_IMPL_DIR}/runner/prepare/${IMPL}-prepare.bash
echo "#END PREPARE"
