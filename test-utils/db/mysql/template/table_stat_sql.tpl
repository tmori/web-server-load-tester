select 
    table_name, (data_length+index_length)/1024/1024 as total_mb, 
    data_length/1024/1024 as size_mb, 
    index_length/1024/1024 as index_mb 
from 
    information_schema.tables 
where 
    table_schema = "{{MYSQL_DB_NAME}}";
