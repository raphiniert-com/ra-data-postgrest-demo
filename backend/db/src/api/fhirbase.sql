create or replace function fhirbase_create(payload text) returns json as $$
begin
	-- required in order to call fihrbase functions due to its design
	PERFORM set_search_path('fhirbase, api, public');

	return fhirbase.fhirbase_create(payload :: jsonb);
end
$$ security definer language plpgsql;
-- by default all functions are accessible to the public, we need to remove that and define our specific access rules
revoke all privileges on function fhirbase_create(text) from public;


create or replace function fhirbase_update(payload text) returns json as $$
begin
	-- required in order to call fihrbase functions due to its design
	PERFORM set_search_path('fhirbase, api, public');

	return fhirbase.fhirbase_update(payload :: jsonb);
end
$$ security definer language plpgsql;
-- by default all functions are accessible to the public, we need to remove that and define our specific access rules
revoke all privileges on function fhirbase_update(text) from public;

create or replace function insert_bundle(payload text) returns jsonb as $$
begin
	-- required in order to call fihrbase functions due to its design
	PERFORM set_search_path('fhirbase, api, public');

	return fhirbase.handle_bundle(payload :: jsonb, 'create');
end
$$ security definer language plpgsql;
-- by default all functions are accessible to the public, we need to remove that and define our specific access rules
revoke all privileges on function insert_bundle(text) from public;

create or replace function update_bundle(payload text) returns json as $$
begin
	-- required in order to call fihrbase functions due to its design
	PERFORM set_search_path('fhirbase, api, public');

	return fhirbase.handle_bundle(payload :: jsonb, 'update');
end
$$ security definer language plpgsql;
-- by default all functions are accessible to the public, we need to remove that and define our specific access rules
revoke all privileges on function update_bundle(text) from public;

