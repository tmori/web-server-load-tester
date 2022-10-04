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

if [  -z POSTGRES_DB_NAME ]
then
    echo "ERROR: can not found MYSQL_DB_NAME env"
    exit 1
fi

SQL=`bash test-utils/template_engine/mo test-utils/db/postgresql/template/table_stat_sql.tpl`
export PGPASSWORD=${POSTGRES_PASSWD}
psql -h localhost -U ${POSTGRES_USER} -d ${POSTGRES_DB_NAME} -t  -c "${SQL}" | \
    awk -F\| 'BEGIN{sum=0.0}{print $1 " " $2; sum+=$2}END{print  "TOTLA_SIZE_MB " sum}'
export PGPASSWORD=
