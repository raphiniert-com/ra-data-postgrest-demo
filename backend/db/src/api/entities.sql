CREATE VIEW api.documents AS 
  SELECT 
   *
  FROM 
    data.documents;

ALTER VIEW api.documents OWNER TO api;

CREATE VIEW api.visits AS 
  SELECT 
    encounter_num,
    patient_num,
    start_date,
    end_date,
    inout_cd
  FROM 
    i2b2data.visit_dimension;

ALTER VIEW api.visits OWNER TO api;


create view api.patients AS 
  select 
    'NAME FROM TC' as name,
    patient_num,
    birth_date::date,
    replace(sex_cd, 'DEM|SEX:', '') as sex,
    count(subject) as doc_count
  from i2b2data.patient_dimension
      left join data.documents on replace(subject->>'reference', 'Patient/', '') :: int = patient_num
  group by patient_num, birth_date, sex;

ALTER VIEW api.patients OWNER TO api;

create materialized view api.observations as
  SELECT
    of2.patient_num,
    of2.encounter_num,
    m.c_dimcode as dimcode,
    d.concept_cd as concept_code,
    case 	when of2.valtype_cd = 'N' then of2.nval_num :: text
        when of2.valtype_cd = 'T' then of2.tval_char :: text
        else 'N/A'
    end as value,
    ROW_NUMBER () OVER (
      PARTITION BY patient_num
      ORDER BY
        encounter_num
    ) as id
  FROM i2b2data.concept_dimension d
    JOIN i2b2meta.i2b2 m ON d.concept_path = m.c_dimcode
    join i2b2data.observation_fact of2 using (concept_cd)
  where 
    concept_cd not like 'DEM|AGE:_'
    and concept_cd not like 'DEM|SEX:_'
    and concept_cd not like 'SYS|ID:%'
    and concept_cd not like 'DEM|RACE:@'
    and concept_cd not like 'DEM|VITAL:@';

ALTER materialized VIEW api.observations OWNER TO api;