#!/bin/bash

export MATTERMOST_PHP_TOPDIR=/root/workspace
export MATTERMOST_PHP_TESTDIR=${MATTERMOST_PHP_TOPDIR}/mattermost-test
export MATTERMOST_RS_TOPDIR=${MATTERMOST_PHP_TOPDIR}/load-test-resource

export WEB_SERVER_URL=192.168.11.52
export TOP_DIR=`pwd`
export TEST_TARGET=mattermost
export TEST_IMPL_DIR=${MATTERMOST_RS_TOPDIR}/test-impl/${TEST_TARGET}
export TEST_ITEM_DIR=${MATTERMOST_RS_TOPDIR}/test-item/${TEST_TARGET}
export TEST_RNTM_DIR=${TOP_DIR}/test-runtime
export TEST_LOGGER=${TOP_DIR}/test-logger/simple-logger.bash
export TEST_LOGPATH=${MATTERMOST_RS_TOPDIR}/log
export TEST_PERFPATH=${MATTERMOST_RS_TOPDIR}/log/perf
export TEST_RESULTPATH=${MATTERMOST_RS_TOPDIR}/test-result/${TEST_TARGET}

# Options
export TEST_SAR_ENABLE=TRUE
export TEST_TARGET_TOOL_DIR=/mnt/project/work/mattermost/mattermost-load-tester/web-server-load-tester
export TEST_SSH_ACCOUNT=tmori@192.168.11.52
export TEST_DISK_DEV=/dev/sdb5

# DB options
export DB_TYPE=postgresql

#export MYSQL_DB_NAME=exment_database
#export MYSQL_USER=exment_user
#export MYSQL_PASSWD=secret
#export MYSQL_DB_DATA_DIR=/var/lib/mysql

export POSTGRES_DB_NAME=mattermost
export POSTGRES_USER=mmuser
export POSTGRES_PASSWD=mmuser-password
export POSTGRES_DB_DATA_DIR=/var/lib/postgresql/14/main

# TODO SSH SETTING COMMANDS
# cd /root
# ssh-keygen -t rsa (all return)
# ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@<host ipaddr>

# TOOL OPTIONS
export MATTERMOST_TOOL_DIR=/mnt/project/work/mattermost/mattermost-load-tester/mattermost-initializer
export MATTERMOST_ROOT_USER=root
export MATTERMOST_ROOT_PASSWD=Password-999

export MATTERMOST_DB_BKP_TOOL_DIR=${MATTERMOST_TOOL_DIR}/db-backup-restore
export MATTERMOST_DB_BKP_DIR=/mnt/project/work/mattermost/mattermost-load-tester/php/hako/load-test-resource/backup
