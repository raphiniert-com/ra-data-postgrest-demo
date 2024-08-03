CREATE VIEW api.zombo_document_search AS 
  SELECT 
    zdb.score(ctid), zdb.highlight(ctid, 'search_text') as search_text_highlighted, *
  FROM 
    data.search_container 
  WHERE 
    search_container ==>
      dsl.fuzzy('search_text', current_setting('request.header.query', true)
    );

ALTER VIEW api.zombo_document_search OWNER TO api;