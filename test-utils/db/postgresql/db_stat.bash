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
    echo "ERROR: can not found POSTGRES_DB_NAME env"
    exit 1
fi

SQL=`bash test-utils/template_engine/mo test-utils/db/postgresql/template/db_stat_sql.tpl`
export PGPASSWORD=${POSTGRES_PASSWD}
psql -h localhost -U ${POSTGRES_USER} -d ${POSTGRES_DB_NAME} -t  -c "${SQL}" | \
    awk '{if (NF > 0) {print "TOTAL_SIZE_MB " ($NF/1024.0/1024.0) } }'
export PGPASSWORD=
