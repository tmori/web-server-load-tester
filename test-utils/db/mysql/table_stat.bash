#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <exec-dir>"
    exit 1
fi
EXEC_DIR=${1}
cd ${EXEC_DIR}

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

if [  -z MYSQL_DB_NAME ]
then
    echo "ERROR: can not found MYSQL_DB_NAME env"
    exit 1
fi

SQL=`bash test-utils/template_engine/mo test-utils/db/mysql/template/table_stat_sql.tpl`
mysql -u ${MYSQL_USER} -D ${MYSQL_DB_NAME} --password=${MYSQL_PASSWD} -s -N -e "${SQL}" | \
    awk 'BEGIN{sum=0.0}{print $1 " " $2 " " $3 " " $4; sum+=$2}END{print "TOTLA_SIZE_MB " sum}' 

