#!/bin/bash
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

function log_init()
{
    rm -f ${TEST_LOGPATH}/test.log
}

function tlog()
{
    echo "INFO: `date` : $*" | tee -a ${TEST_LOGPATH}/test.log
}

function terror()
{
    echo "ERROR: `date` : $*" | tee -a ${TEST_LOGPATH}/test.log
}

function log_save()
{
    test_no=${1}
    mv ${TEST_LOGPATH}/test.log ${TEST_LOGPATH}/test-${test_no}.log
}
