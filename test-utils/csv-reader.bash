#!/bin/bash
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}

function csv_foreach()
{
    local test_item=${1}
    local callback=${2}
    tail -n +2 ${test_item} > .tmp.txt 
    for LINE in `cat .tmp.txt`
    do
        ${callback} ${LINE}
    done
    rm -f .tmp.txt
}

function csv_col2id()
{
    local test_item=${1}
    local colname=${2}
    HEAD=`head -n 1 ${test_item} | sed -s 's/,/ /g'`

    id=1
    for col in ${HEAD}
    do
        if [ "${col}" = "${colname}" ]
        then
            return $id
        fi
        id=$((id + 1))
    done
    terror "Invalid colname=${colname}"
    exit -1
}

function csv_read()
{
    local test_item=${1}
    local line=${2}
    local colname=${3}

    csv_col2id ${test_item} ${colname}
    colid=${?}
    value=`echo ${line} | awk -v col=${colid} -F, '{print $col}'`
    echo $value
}
