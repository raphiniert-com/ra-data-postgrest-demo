drop schema if exists fhirbase cascade;
create schema fhirbase;
set search_path = fhirbase, public;

\ir fhirbase-4.0.0.sql
\ir handle_bundle.sql