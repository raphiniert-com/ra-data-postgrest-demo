drop type if exists handle_action;
CREATE TYPE handle_action AS ENUM ('update', 'create');

drop function if exists handle_bundle(jsonb);
CREATE OR REPLACE FUNCTION handle_bundle(bundle jsonb, action handle_action)
RETURNS jsonb
AS $$
	import json
	bun = json.loads(bundle)
	if bun.get("resourceType") != "Bundle":
		plpy.error("Not a Bundle")
	entry = bun.get("entry")
	if len(entry) < 1:
		plpy.error("No content in Bundle")
	created_resources = []
	for s in entry:
		resource = json.dumps(s["resource"])
		sql = plpy.prepare("select fhirbase.fhirbase_" + action + "($1::jsonb) as result", ["jsonb"])
		r = plpy.execute(sql, [resource])
		created_resources.append(json.loads(r[0]["result"]))
	return json.dumps(created_resources)
$$ security definer language 'plpython3u';
