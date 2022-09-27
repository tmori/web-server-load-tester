#!/bin/bash

export WEB_SERVER_URL=192.168.11.52
export TOP_DIR=`pwd`
export TEST_TARGET=sample
export TEST_IMPL_DIR=${TOP_DIR}/test-impl/${TEST_TARGET}
export TEST_ITEM_DIR=${TOP_DIR}/test-item/${TEST_TARGET}
export TEST_RNTM_DIR=${TOP_DIR}/test-runtime
export TEST_LOGGER=${TOP_DIR}/test-logger/simple-logger.bash
export TEST_LOGPATH=${TOP_DIR}/log
