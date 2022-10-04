#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source test-utils/perf/sar-mem.bash
source test-utils/perf/sar-cpu.bash

export BEFORE_CPU_IDLE=0
export AFTER_CPU_IDLE=0
export BEFORE_MEM_GB=0
export AFTER_MEM_GB=0
export THROUGHPUT=0
export RES_TIME_MSEC=0
export BEFORE_TABLE_MB=0
export AFTER_TABLE_MB=0

function perf_init()
{
    local TestNo=${1}
    if [ -d ${TEST_PERFPATH}/item-${TestNo} ]
    then
        rm -f ${TEST_PERFPATH}/item-${TestNo}/*.txt
    else
        mkdir ${TEST_PERFPATH}/item-${TestNo}
    fi
}

function calc_average_response_time_msec()
{
    local filepath=${1}
    cat ${filepath}/response_time-* | grep real | awk 'BEGIN{count=0; sum=0.0}{count++;sum+=$2} END{print (sum/count) * 1000.0 }'
}
DO_NUM=
START_MS=
END_MS=
function perf_start()
{
    local Multiplicity=${1}
    local DoRepeatNum=${2}
    DO_NUM=`expr ${Multiplicity} \* ${DoRepeatNum}`
    START_MS=`echo $(($(date +%s%N)/1000000))`
}
function perf_end()
{
    local TestNo=${1}
    END_MS=`echo $(($(date +%s%N)/1000000))`
    ELAPS_MS=$(expr $END_MS - $START_MS)
    THROUGHPUT=`echo "${ELAPS_MS}" | awk -v mul=${DO_NUM} '{print (mul / $1) * 1000.0 }'`
    RES_TIME_MSEC=`calc_average_response_time_msec ${TEST_PERFPATH}/item-${TestNo}`
    echo "${ELAPS_MS}"      > ${TEST_PERFPATH}/item-${TestNo}/elaps_ms.txt
    echo "${THROUGHPUT}"    > ${TEST_PERFPATH}/item-${TestNo}/throughput.txt
    echo "${RES_TIME_MSEC}" > ${TEST_PERFPATH}/item-${TestNo}/response-time_ms.txt
    tlog "ELAPS MS = $ELAPS_MS"
    tlog "THROUGHPUT = $THROUGHPUT"
    tlog "RES_TIME_MSEC = $RES_TIME_MSEC"
}

function sar_start()
{
    local TestNo=${1}
    if [ -z "${TEST_SAR_ENABLE}" ]
    then
        :
    else
        start_sar_mem ${TEST_PERFPATH}/item-${TestNo}/sar_mem.txt
        start_sar_cpu ${TEST_PERFPATH}/item-${TestNo}/sar_cpu.txt
    fi
}
function sar_end()
{
    local TestNo=${1}
    local filename=${2}
    if [ -z $TEST_SAR_ENABLE ]
    then
        :
    else
        finish_sar_mem ${TEST_PERFPATH}/item-${TestNo}/sar_mem.txt
        finish_sar_cpu ${TEST_PERFPATH}/item-${TestNo}/sar_cpu.txt
        echo "MEM_GB=${AVERAGE_MEM_GB}" > ${TEST_PERFPATH}/item-${TestNo}/${filename}
        echo "CPU_IDLE=${AVERAGE_CPU_IDLE}" >> ${TEST_PERFPATH}/item-${TestNo}/${filename}
        tlog "MEM_GB=${AVERAGE_MEM_GB}"
        tlog "CPU_IDLE=${AVERAGE_CPU_IDLE}"
    fi
}
function disk_check_start()
{
    local TestNo=${1}
    if [ -z ${TEST_DISK_DEV} ]
    then
        :
    else
        bash test-utils/remote_command.bash df ${TEST_DISK_DEV} > ${TEST_PERFPATH}/item-${TestNo}/before_df.txt
    fi
    if [ -z ${DB_TYPE} ]
    then
        :
    else
        bash test-utils/remote_script.bash ${TEST_TARGET_TOOL_DIR}/test-utils/db/${DB_TYPE}/table_stat.bash ${TEST_TARGET_TOOL_DIR} > ${TEST_PERFPATH}/item-${TestNo}/before_table.txt
    fi
}

export DISK_USAGE=0
function disk_check_end()
{
    local TestNo=${1}
    local filename=${2}
    if [ -z ${TEST_DISK_DEV} ]
    then
        :
    else
        bash test-utils/remote_command.bash df ${TEST_DISK_DEV} > ${TEST_PERFPATH}/item-${TestNo}/after_df.txt
        BEFORE=`grep ${TEST_DISK_DEV} ${TEST_PERFPATH}/item-${TestNo}/before_df.txt | awk '{print $3}'` 
        AFTER=`grep ${TEST_DISK_DEV} ${TEST_PERFPATH}/item-${TestNo}/after_df.txt | awk '{print $3}'` 
        USAGE=`expr ${AFTER} \- ${BEFORE}`
        DISK_USAGE=`echo ${USAGE} | awk '{print $1 / 1024 }'`
        echo "DISK_MB=${DISK_USAGE}" > ${TEST_PERFPATH}/item-${TestNo}/${filename}
        tlog "DISK_MB=${DISK_USAGE}"
    fi
    if [ -z ${DB_TYPE} ]
    then
        :
    else
        bash test-utils/remote_script.bash ${TEST_TARGET_TOOL_DIR}/test-utils/db/${DB_TYPE}/table_stat.bash ${TEST_TARGET_TOOL_DIR} > ${TEST_PERFPATH}/item-${TestNo}/after_table.txt
    fi
}

function perf_prepare()
{
    local TestNo=${1}
    sar_start ${TestNo}
    sleep 10
    disk_check_start ${TestNo}
    sar_end ${TestNo} before_sar.txt
    BEFORE_CPU_IDLE=${AVERAGE_CPU_IDLE}
    BEFORE_MEM_GB=${AVERAGE_MEM_GB}
}

function perf_do()
{
    local TestNo=${1}
    sar_start ${TestNo}
    perf_start ${Multiplicity} ${DoRepeatNum}
}
function perf_done()
{
    local TestNo=${1}
    perf_end ${TestNo}
    sar_end ${TestNo} after_sar.txt
    AFTER_CPU_IDLE=${AVERAGE_CPU_IDLE}
    AFTER_MEM_GB=${AVERAGE_MEM_GB}
    disk_check_end ${TestNo} disk_usage.txt
    if [ -z ${DB_TYPE} ]
    then
        :
    else
        BEFORE_TABLE_MB=`grep TOTLA_SIZE_MB ${TEST_PERFPATH}/item-${TestNo}/before_table.txt | awk '{print $2}'`
        AFTER_TABLE_MB=`grep TOTLA_SIZE_MB ${TEST_PERFPATH}/item-${TestNo}/after_table.txt | awk '{print $2}'`
    fi
}
