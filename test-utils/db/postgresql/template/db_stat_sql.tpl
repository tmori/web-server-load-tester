select
    datname, pg_database_size(datname) 
from 
    pg_database 
where 
    datname='{{POSTGRES_DB_NAME}}';
