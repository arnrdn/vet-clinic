/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

/* create animals table */
CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL, PRIMARY KEY(id));

/* add column species to the animals table */
ALTER TABLE animals ADD COLUMN species VARCHAR(255);

/* create owners table */
CREATE TABLE owners (id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(255), age INT, PRIMARY KEY(id));

/* create species table */
CREATE TABLE species (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(255), PRIMARY KEY(id));

/* remove column species */
ALTER TABLE animals DROP species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
SELECT * FROM animals;

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);
SELECT * FROM animals;