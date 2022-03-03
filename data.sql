/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon',TO_DATE('03/02/2020', 'DD/MM/YYYY'), 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon',TO_DATE('15/11/2018', 'DD/MM/YYYY'), 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu',TO_DATE('07/01/2021', 'DD/MM/YYYY'), 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon',TO_DATE('12/05/2017', 'DD/MM/YYYY'), 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander',TO_DATE('08/02/2020', 'DD/MM/YYYY'), 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon',TO_DATE('15/11/2022', 'DD/MM/YYYY'), 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle',TO_DATE('02/04/1993', 'DD/MM/YYYY'), 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon',TO_DATE('12/06/2005', 'DD/MM/YYYY'), 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon',TO_DATE('07/06/2005', 'DD/MM/YYYY'), 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom',TO_DATE('13/10/1998', 'DD/MM/YYYY'), 3, true, 17);


INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);


INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/* Set species_id column */
BEGIN;
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
SELECT * FROM animals; /* to check if changes has applied */
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;
SELECT * FROM animals; /* to check if changes has applied */
COMMIT;

/* Set owner_id column */
BEGIN;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
SELECT * FROM animals; /* to check if changes has applied */
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
SELECT * FROM animals; /* to check if changes has applied */
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
SELECT * FROM animals; /* to check if changes has applied */
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Plantmon', 'Blossom');
SELECT * FROM animals; /* to check if changes has applied */
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
SELECT * FROM animals; /* to check if changes has applied */
COMMIT;

-- Insert the following data for vets: --
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000. --
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, TO_DATE('23/04/2000', 'DD/MM/YYYY'));
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019. --
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, TO_DATE('17/01/2019', 'DD/MM/YYYY'));
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981. --
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, TO_DATE('04/05/1981', 'DD/MM/YYYY'));
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008. --
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, TO_DATE('08/06/2008', 'DD/MM/YYYY'));

/* Insert the following data for specialties:
Vet William Tatcher is specialized in Pokemon.
Vet Stephanie Mendez is specialized in Digimon and Pokemon.
Vet Jack Harkness is specialized in Digimon. */
INSERT INTO specializations (species_id, vets_id) VALUES (1,1),(2,3),(1,3),(2,4);

-- Insert the following data for visits: --
-- Agumon -1- visited William Tatcher -1- on May 24th, 2020. --
-- Agumon -1- visited Stephanie Mendez -3- on Jul 22th, 2020. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1,1,TO_DATE('24/05/2020', 'DD/MM/YYYY')), (1,3,TO_DATE('22/07/2020', 'DD/MM/YYYY'));
-- Gabumon -2- visited Jack Harkness -4- on Feb 2nd, 2021. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (2,4,TO_DATE('02/02/2021', 'DD/MM/YYYY'));
-- Pikachu -3- visited Maisy Smith -2- on Jan 5th, 2020. --
-- Pikachu visited Maisy Smith on Mar 8th, 2020. --
-- Pikachu visited Maisy Smith on May 14th, 2020. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3,2,TO_DATE('05/01/2020', 'DD/MM/YYYY')), (3,2,TO_DATE('08/03/2020', 'DD/MM/YYYY')), (3,2,TO_DATE('14/05/2020', 'DD/MM/YYYY'));
-- Devimon -4- visited Stephanie Mendez -3- on May 4th, 2021. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (4,3,TO_DATE('04/05/2021', 'DD/MM/YYYY'));
-- Charmander -5- visited Jack Harkness -4- on Feb 24th, 2021. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (5,4,TO_DATE('24/02/2021', 'DD/MM/YYYY'));
-- Plantmon -11- visited Maisy Smith -2- on Dec 21st, 2019. --
-- Plantmon visited William Tatcher -1- on Aug 10th, 2020. --
-- Plantmon visited Maisy Smith on Apr 7th, 2021. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (11,2,TO_DATE('21/12/2019', 'DD/MM/YYYY')), (11,1,TO_DATE('10/09/2020', 'DD/MM/YYYY')), (11,2,TO_DATE('07/04/2021', 'DD/MM/YYYY'));
-- Squirtle -7- visited Stephanie Mendez -3- on Sep 29th, 2019. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (7,3,TO_DATE('29/09/2019', 'DD/MM/YYYY'));
-- Angemon -8- visited Jack Harkness -4- on Oct 3rd, 2020. --
-- Angemon visited Jack Harkness -4- on Nov 4th, 2020. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8,4,TO_DATE('03/10/2020', 'DD/MM/YYYY')), (8,4,TO_DATE('04/11/2020', 'DD/MM/YYYY'));
-- Boarmon -9- visited Maisy Smith -2- on Jan 24th, 2019. --
-- Boarmon visited Maisy Smith on May 15th, 2019. --
-- Boarmon visited Maisy Smith on Feb 27th, 2020. --
-- Boarmon visited Maisy Smith on Aug 3rd, 2020. --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9,2,TO_DATE('24/01/2019', 'DD/MM/YYYY')), (9,2,TO_DATE('15/05/2019', 'DD/MM/YYYY')), (9,2,TO_DATE('27/02/2020', 'DD/MM/YYYY')), (9,2,TO_DATE('03/08/2020', 'DD/MM/YYYY'));
-- Blossom -10- visited Stephanie Mendez -3-  on May 24th, 2020. --
-- Blossom visited William Tatcher -1- on Jan 11th, 2021.  --
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10,3,TO_DATE('24/05/2020', 'DD/MM/YYYY')), (10,1,TO_DATE('11/01/2021', 'DD/MM/YYYY'));
