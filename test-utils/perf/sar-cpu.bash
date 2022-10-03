#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

export SAR_CPU_PID=
SAR_CPU_CMD="sar -p 1"
function start_sar_cpu()
{
    local filepath=${1}
    ssh ${TEST_SSH_ACCOUNT} ${SAR_CPU_CMD} > ${filepath} &
    SAR_CPU_PID=$!
}
export AVERAGE_CPU_IDLE=
function calc_sar_cpu()
{
    local filepath=${1}
    AVERAGE_CPU_IDLE=`tail -n +4 ${filepath} | awk '{print $NF}' | awk 'BEGIN{sum=0.0; count=0;} {count++; sum+=$1;} END {print sum / count }' `
}

function finish_sar_cpu()
{
    local filepath=${1}
    kill -s TERM ${SAR_CPU_PID}
    wait -n ${SAR_CPU_PID}
    calc_sar_cpu ${filepath}
}

