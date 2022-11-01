show databases;
use sys;

show tables like 'schema%';

select * from schema_auto_increment_columns;

select * from schema_index_statistics;

select * from sys.version;

select * from sys.host_summary_by_file_io;

select * from sys.host_summary;

show create view sys.session;

show tables like '%list';

select * from sys.processlist;

show tables like '%session';

select * from sys.session;

-- information schema

use information_schema;

show tables;

select * from information_schema.keywords;

select * from information_schema.tables
where table_schema = 'company'
and Engine is not null;

select * from information_schema.CHECK_CONSTRAINTS;

select * from information_schema.referential_CONSTRAINTS
where constraint_schema = 'company';