-- Create the table
CREATE TABLE data.drug_specifications (
    id SERIAL PRIMARY KEY,
    atc VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL
);