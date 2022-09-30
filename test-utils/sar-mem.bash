#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

export SAR_MEM_PID=
SAR_MEM_CMD="sar -r 1"
function start_sar_mem()
{
    local filepath=${1}
    ssh ${TEST_SSH_ACCOUNT} ${SAR_MEM_CMD} > ${filepath} &
    SAR_MEM_PID=$!
    #echo $SAR_MEM_PID
}
export AVERAGE_MEM_GB=
function calc_sar_mem()
{
    local filepath=${1}
    AVERAGE_MEM_GB=`tail -n +4 ${filepath} | awk '{print $4}' | awk 'BEGIN{sum=0.0; count=0;} {count++; sum+=$1;} END {print sum / count / 1024 / 1024 }' `
}

function finish_sar_mem()
{
    local filepath=${1}
    kill -s TERM ${SAR_MEM_PID}
    wait -n ${SAR_MEM_PID}
    calc_sar_mem ${filepath}
}

