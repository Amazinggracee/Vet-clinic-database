/* Database schema to keep the structure of entire database. */

CREATE TABLE animals
(
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-----------------------------------------------
-----------------------------------------------

ALTER TABLE animals ADD species VARCHAR(255);

-----------------------------------------------
-----------------------------------------------

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR,
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR
);

-- Add a new primary key column
ALTER TABLE animals ADD COLUMN new_id SERIAL PRIMARY KEY;

-- Drop the existing primary key constraint
ALTER TABLE animals DROP COLUMN id;

-- Rename the new primary key column to id
ALTER TABLE animals RENAME COLUMN new_id TO id;

-- Remove the species column
ALTER TABLE animals DROP COLUMN species;

-- Add the species_id column as a foreign key referencing the species table
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add the owner_id column as a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);