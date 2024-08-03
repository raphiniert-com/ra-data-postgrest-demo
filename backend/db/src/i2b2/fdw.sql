create extension if not exists postgres_fdw;

drop server if exists i2b2;
create server i2b2 
 FOREIGN DATA WRAPPER postgres_fdw
 OPTIONS (
  dbname 'i2b2', 
  host :'fdw_i2b2_host', 
  port :'fdw_i2b2_port');

DROP USER MAPPING IF EXISTS for superuser SERVER i2b2;
CREATE USER MAPPING for superuser
SERVER i2b2
OPTIONS (user :'fdw_i2b2_user', password :'fdw_i2b2_pw');


IMPORT FOREIGN SCHEMA :"fdw_i2b2_schema" FROM SERVER i2b2 INTO i2b2data;
IMPORT FOREIGN SCHEMA "i2b2metadata" FROM SERVER i2b2 INTO i2b2meta;