if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi
source test-utils/csv-reader.bash

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

function do_test_item()
{
    line=$1
    Multiplicity=`csv_read ${TEST_ITEM} ${line} Multiplicity`
    Setup=`csv_read ${TEST_ITEM} ${line} SetUp`
    TearDown=`csv_read ${TEST_ITEM} ${line} TearDown`
    Prepare=`csv_read ${TEST_ITEM} ${line} Prepare`
    Do=`csv_read ${TEST_ITEM} ${line} Do`
    Done=`csv_read ${TEST_ITEM} ${line} Done`
    DoRepeatNum=`csv_read ${TEST_ITEM} ${line} DoRepeatNum`

    # setup
    bash test-runtime/controller/setup.bash ${Setup}

    # do test
    for i in `seq ${Multiplicity}`
    do
        bash test-runtime/test-runner.bash ${Prepare} ${Do} ${Done} ${DoRepeatNum} &
    done
    wait
    
    # teardown
    bash test-runtime/controller/teardown.bash ${TearDown}
}

csv_foreach ${TEST_ITEM} do_test_item
