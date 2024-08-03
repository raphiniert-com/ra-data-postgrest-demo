\echo # Loading roles privilege

-- this file contains the privileges of all aplications roles to each database entity
-- if it gets too long, you can split it one file per entity ore move the permissions
-- to the file where you defined the entity

-- specify which application roles can access this api (you'll probably list them all)
grant usage on schema api to anonymous, webuser;

grant usage on FOREIGN DATA WRAPPER postgres_fdw to anonymous, webuser;
grant usage on FOREIGN SERVER i2b2 TO anonymous, webuser;

grant usage on schema api to anonymous, webuser;
grant usage on schema i2b2data to anonymous, webuser;
grant usage on schema i2b2meta to anonymous, webuser;


-- set privileges to functions
grant execute on function api.fhirbase_create(text) to webuser;
grant execute on function api.fhirbase_update(text) to webuser;
grant execute on function api.insert_bundle(text) to webuser;
grant execute on function api.update_bundle(text) to webuser;

-- set privileges to data entities
grant select, insert, update, delete ON data.search_container TO api;
grant select, insert, update, delete on data.documents to api;
grant select, insert, update, delete on data.drug_specifications to api;
GRANT SELECT ON ALL TABLES IN SCHEMA i2b2data TO api;
GRANT SELECT ON ALL TABLES IN SCHEMA i2b2meta TO api;
GRANT usage, SELECT on data.drug_specifications_id_seq to webuser;

-- set privileges to views
grant select on api.zombo_document_search to webuser;
grant select on api.documents to webuser;
grant select on api.visits to  webuser;
grant select on api.patients to webuser;
grant select on api.observations to webuser;
grant select, insert, update, delete on api.drug_specifications to webuser;
-------------------------------------------------------------------------------
