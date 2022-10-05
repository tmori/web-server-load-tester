if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi
source test-utils/csv-reader.bash
source test-utils/perf/perf.bash
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
echo $TEST_ITEM
TEST_ITEM_NAME=`echo ${TEST_ITEM} | awk -F\/ '{print $NF}' | awk -F. '{print $1}'`

function init_test_result()
{
    if [ -d ${TEST_RESULTPATH} ]
    then
        :
    else
        mkdir ${TEST_RESULTPATH}
    fi
    echo "TestNo,Throuput,ResTime,disk_usage_MB,table_MB,cpu_usage,mem_GB,b_cpu_idle,a_cpu_idle,b_mem_GB,a_mem_GB" > ${TEST_RESULTPATH}/${TEST_ITEM_NAME}-result.csv
}
function save_test_result()
{
    local TestNo=${1}
    RES_TIME_SEC=`echo ${RES_TIME_MSEC} | awk '{print $1/1000.0}'`
    CPU_USAGE=`echo "${BEFORE_CPU_IDLE} ${AFTER_CPU_IDLE}" | awk '{print $1 - $2}'`
    MEM_GB=`echo "${BEFORE_MEM_GB} ${AFTER_MEM_GB}" | awk '{print $2 - $1}'`
    TABLE_MB=`echo "${BEFORE_TABLE_MB} ${AFTER_TABLE_MB}" | awk '{print $2 - $1}'`
    echo "${TestNo},${THROUGHPUT},${RES_TIME_SEC},${DISK_USAGE},${TABLE_MB},${CPU_USAGE},${MEM_GB},${BEFORE_CPU_IDLE},${AFTER_CPU_IDLE},${BEFORE_MEM_GB},${AFTER_MEM_GB}" >> ${TEST_RESULTPATH}/${TEST_ITEM_NAME}-result.csv
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
    perf_init ${TestNo}

    # setup
    bash test-runtime/controller/setup.bash ${Setup} ${TestNo}

    perf_prepare ${TestNo}

    # do test
    perf_do ${TestNo}
    WAIT_PIDS=""
    for id in `seq ${Multiplicity}`
    do
        bash test-runtime/test-runner.bash ${Prepare} ${Do} ${Done} ${DoRepeatNum} ${id} ${TestNo} &
        WAIT_PIDS="$! ${WAIT_PIDS}"
    done
    wait -n ${WAIT_PIDS}

    perf_done ${TestNo}
    save_test_result ${TestNo}

    # teardown
    bash test-runtime/controller/teardown.bash ${TearDown} ${TestNo}
    log_save ${TestNo}
}

tlog "OPTION: TEST_SAR_ENABLE=${TEST_SAR_ENABLE}"
tlog "OPTION: DB_TYPE=${DB_TYPE}"
tlog "OPTION: TEST_TARGET_TOOL_DIR=${TEST_TARGET_TOOL_DIR}"
tlog "OPTION: TEST_SSH_ACCOUNT=${TEST_SSH_ACCOUNT}"
tlog "OPTION: TEST_DISK_DEV=${TEST_DISK_DEV}"
init_test_result
csv_foreach ${TEST_ITEM} do_test_item
