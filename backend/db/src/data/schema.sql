drop schema if exists data cascade;
create schema data;
set search_path = data, public;

\ir documents.sql
\ir search.sql
\ir drug_specifications.sql