#!/bin/bash

#cd /mnt/project/work/test/web-server-load-tester
#/bin/bash $*
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi
if [  -z TEST_SSH_ACCOUNT ]
then
    echo "ERROR: can not found TEST_SSH_ACCOUNT env"
    exit 1
fi

ssh ${TEST_SSH_ACCOUNT} cd ${TEST_TARGET_TOOL_DIR} && /bin/bash ${@:1}

