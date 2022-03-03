/*Queries that provide answers to the questions from all projects.*/

/* select all names which ends with mon */
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species from animals;
ROLLBACK;
SELECT species from animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species from animals;
COMMIT;
SELECT species from animals;

BEGIN;
DELETE FROM animals
SELECT COUNT(*) FROM ANIMALS;
ROLLBACK;
SELECT COUNT(*) FROM ANIMALS;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '01/01/2022';
SAVEPOINT savepoint_1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO savepoint_1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(name) FROM animals;
SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT SUM(escape_attempts) FROM animals WHERE neutered = true;
SELECT SUM(escape_attempts) FROM animals WHERE neutered = false;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '01/01/1990' AND '31/12/2000';

/* Write queries (using JOIN) to answer the following questions: */
/* What animals belong to Melody Pond? */
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.id = 1;

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT animals.name,full_name FROM owners LEFT JOIN animals ON animals.owner_id=owners.id;

/* How many animals are there per species? */
SELECT COUNT(*), species.name FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.* FROM animals LEFT JOIN owners ON animals.owner_id = owners.id LEFT JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape */
SELECT animals.* FROM animals LEFT JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.name) AS total FROM owners LEFT JOIN animals ON animals.owner_id=owners.id GROUP BY owners.full_name ORDER BY total DESC LIMIT 1;

-- Write queries to answer the following: --
-- Who was the last animal seen by William Tatcher? --
SELECT vets.name, animals.name, date_of_visit FROM vets JOIN visits ON vets.id=visits.vets_id JOIN animals ON animals.id= visits.animals_id WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see? --
SELECT COUNT(*) as total_animals from vets JOIN visits ON vets.id = visits.vets_id WHERE name='Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties. --
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON specializations.vets_id = vets.id LEFT JOIN species ON specializations.species_id = species.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. --
SELECT animals.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '01/02/2020' AND '30/08/2020';
-- What animal has the most visits to vets? --
SELECT animals.name, COUNT(*) as total FROM animals JOIN visits ON visits.animals_id = animals.id GROUP BY animals.name ORDER BY total DESC LIMIT 1;
-- Who was Maisy Smith's first visit? --
SELECT vets.name, animals.name, date_of_visit FROM vets JOIN visits on vets.id = visits.vets_id JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit. --
-- Here I finally realized that I can no longer live with writing SQL code in one line --
SELECT date_of_visit, animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY date_of_visit
DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species? --
SELECT COUNT(*)
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
JOIN specializations ON specializations.vets_id = visits.vets_id
WHERE animals.species_id != specializations.species_id;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most. --
SELECT species.name, COUNT(visits.animals_id)
FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name;