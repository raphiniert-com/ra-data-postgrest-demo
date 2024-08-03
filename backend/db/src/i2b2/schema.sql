drop schema if exists i2b2data cascade;
drop schema if exists i2b2meta cascade;

create schema i2b2data;
create schema i2b2meta;

set search_path = i2b2data, i2b2meta, public;

\ir fdw.sql