drop schema if exists api cascade;
create schema api;
set search_path = api, public;

-- this role will be used as the owner of the views in the api schema
-- it is needed for the definition of the RLS policies
drop role if exists api;
create role api;
grant api to current_user; -- this is a workaround for RDS where the master user does not have SUPERUSER priviliges  

-- our endpoints
\ir fdw.sql
\ir fhirbase.sql
\ir search.sql
\ir entities.sql
\ir drug_specifications.sql