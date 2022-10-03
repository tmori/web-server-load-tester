select 
    relname as table_name, 
    (relpages*8192.0)/1024.0/1024.0 as total_mb 
from 
    pg_class;
