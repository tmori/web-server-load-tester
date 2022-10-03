#!/bin/bash

export WEB_SERVER_URL=192.168.11.52
export TOP_DIR=`pwd`
export TEST_TARGET=sample
export TEST_IMPL_DIR=${TOP_DIR}/test-impl/${TEST_TARGET}
export TEST_ITEM_DIR=${TOP_DIR}/test-item/${TEST_TARGET}
export TEST_RNTM_DIR=${TOP_DIR}/test-runtime
export TEST_LOGGER=${TOP_DIR}/test-logger/simple-logger.bash
export TEST_LOGPATH=${TOP_DIR}/log
export TEST_PERFPATH=${TOP_DIR}/log/perf
export TEST_RESULTPATH=${TOP_DIR}/test-result/${TEST_TARGET}

# Options
#export TEST_SAR_ENABLE=TRUE
#export TEST_TARGET_TOOL_DIR=${TOP_DIR}
#export TEST_SSH_ACCOUNT=tmori@192.168.11.52
#export TEST_DISK_DEV=/dev/sdb5

# DB options
#export DB_TYPE=mysql

#export MYSQL_DB_NAME=exment_database
#export MYSQL_USER=exment_user
#export MYSQL_PASSWD=secret
#export MYSQL_DB_DATA_DIR=/var/lib/mysql

#export POSTGRES_DB_NAME=mattermost
#export POSTGRES_USER=mmuser
#export POSTGRES_PASSWD=mmuser-password
#export POSTGRES_DB_DATA_DIR=/var/lib/postgresql/14/main
