if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi
source test-utils/csv-reader.bash
source ${TEST_LOGGER}

if [ $# -ne 1 ]
then
    echo "Usage: $0 <test-item>"
    exit 1
fi
# env check
bash test-runtime/test-env-check.bash
if [ $? -ne 0 ]
then
    exit 1
fi


TEST_ITEM=${1}

function calc_average_response_time_msec()
{
    local filepath=${1}
    cat ${filepath}/response_time-* | grep real | awk 'BEGIN{count=0; sum=0.0}{count++;sum+=$2} END{print (sum/count) * 1000.0 }'
}

function do_test_item()
{
    line=$1
    TestNo=`csv_read ${TEST_ITEM} ${line} No`
    Multiplicity=`csv_read ${TEST_ITEM} ${line} Multiplicity`
    Setup=`csv_read ${TEST_ITEM} ${line} SetUp`
    TearDown=`csv_read ${TEST_ITEM} ${line} TearDown`
    Prepare=`csv_read ${TEST_ITEM} ${line} Prepare`
    Do=`csv_read ${TEST_ITEM} ${line} Do`
    Done=`csv_read ${TEST_ITEM} ${line} Done`
    DoRepeatNum=`csv_read ${TEST_ITEM} ${line} DoRepeatNum`

    log_init
    
    # setup
    bash test-runtime/controller/setup.bash ${Setup}

    if [ -d ${TEST_PERFPATH}/item-${TestNo} ]
    then
        rm -f ${TEST_PERFPATH}/item-${TestNo}/*.txt
    else
        mkdir ${TEST_PERFPATH}/item-${TestNo}
    fi
    DO_NUM=`expr ${Multiplicity} \* ${DoRepeatNum}`
    START_MS=`echo $(($(date +%s%N)/1000000))`
    
    # do test
    for id in `seq ${Multiplicity}`
    do
        bash test-runtime/test-runner.bash ${Prepare} ${Do} ${Done} ${DoRepeatNum} ${id} ${TestNo} &
    done
    wait
    END_MS=`echo $(($(date +%s%N)/1000000))`

    # set perf info
    ELAPS_MS=$(expr $END_MS - $START_MS)
    THROUGHPUT=`echo "${ELAPS_MS}" | awk -v mul=${DO_NUM} '{print (mul / $1) * 1000.0 }'`
    RES_TIME_MSEC=`calc_average_response_time_msec ${TEST_PERFPATH}/item-${TestNo}`
    echo "${ELAPS_MS}"      > ${TEST_PERFPATH}/item-${TestNo}/elaps_ms.txt
    echo "${THROUGHPUT}"    > ${TEST_PERFPATH}/item-${TestNo}/throughput.txt
    echo "${RES_TIME_MSEC}" > ${TEST_PERFPATH}/item-${TestNo}/response-time_ms.txt
    tlog "ELAPS MS = $ELAPS_MS"
    tlog "THROUGHPUT = $THROUGHPUT"
    tlog "RES_TIME_MSEC = $RES_TIME_MSEC"

    # teardown
    bash test-runtime/controller/teardown.bash ${TearDown}

    log_save ${TestNo}
}

csv_foreach ${TEST_ITEM} do_test_item
