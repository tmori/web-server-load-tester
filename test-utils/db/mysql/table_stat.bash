#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

if [  -z MYSQL_DB_NAME ]
then
    echo "ERROR: can not found MYSQL_DB_NAME env"
    exit 1
fi

if [ $# -ne 1 ]
then
    echo "Usage: $0 <table_size_results_file>"
    exit 1
fi

TABLE_SIZE_RESULT_FILE=${1}

SQL=`bash test-utils/template_engine/mo test-utils/db/mysql/template/table_stat_sql.tpl`
mysql -u ${MYSQL_USER} -D ${MYSQL_DB_NAME} --password=${MYSQL_PASSWD} -s -N -e "${SQL}" > ${TABLE_SIZE_RESULT_FILE}
cat ${TABLE_SIZE_RESULT_FILE} | awk 'BEGIN{sum=0.0}{sum+=$2}END{print "TOTLA_SIZE_MB " sum}' >> ${TABLE_SIZE_RESULT_FILE}
