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

/* create vets table */
CREATE TABLE vets (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(255), age INT, date_of_graduation DATE, PRIMARY KEY(id));

/* Create a "join table" called specializations to handle this relationship. */
CREATE TABLE specializations (species_id INT, vets_id INT, CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id), CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id));

/* Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. */
CREATE TABLE visits (animals_id INT,vets_id INT, date_of_visit DATE, CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id), CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id));

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX index_animals_id ON visits(animals_id);
CREATE INDEX index_vets_id ON visits(vets_id);
CREATE INDEX owners_email_asc ON owners(email ASC);


