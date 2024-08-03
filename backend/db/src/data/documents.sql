create or replace view data.documents as
select
	id as fhir_id,
	txid,
	convert_from(encode(decode(document->'attachment'->>'data' , 'base64'), 'escape') :: BYTEA, 'utf-8') as document,
	resource->'subject' as subject,
  resource,
  replace(resource->'subject'->>'reference', 'Patient/', '') :: int as patient_id
from (
	select jsonb_array_elements(resource->'content') as document, id, txid, resource
	from fhirbase.documentreference
) as fhir_resource;
