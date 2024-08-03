CREATE VIEW api.drug_specifications AS 
  SELECT 
   *
  FROM 
    data.drug_specifications;

ALTER VIEW api.drug_specifications OWNER TO api;