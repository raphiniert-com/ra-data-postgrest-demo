CREATE MATERIALIZED VIEW data.search_container AS
 SELECT 
      row_number() over (order by txid, entry_type) as id, * -- see: https://www.postgresqltutorial.com/postgresql-row_number/
    FROM (
      select txid, document as search_text, subject, 'documents' as entry_type
      from data.documents
    ) as tmp;

CREATE TYPE idx_es_search_type AS (
  id bigint,
  search_text text,
  subject jsonb,
  entry_type text
);

DROP INDEX IF EXISTS idx_es_search;
CREATE INDEX idx_es_search 
  ON data.search_container 
  USING zombodb ((
    ROW(
      data.search_container.id,
      data.search_container.search_text,
      data.search_container.subject,
      data.search_container.entry_type) :: idx_es_search_type
    )) WITH (url='http://es01:9200/');