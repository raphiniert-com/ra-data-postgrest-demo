DROP USER MAPPING IF EXISTS for api SERVER i2b2;
CREATE USER MAPPING for api
SERVER i2b2
OPTIONS (user :'fdw_i2b2_user', password :'fdw_i2b2_pw');