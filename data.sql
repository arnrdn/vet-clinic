/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon',TO_DATE('03/02/2020', 'DD/MM/YYYY'), 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon',TO_DATE('15/11/2018', 'DD/MM/YYYY'), 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu',TO_DATE('07/01/2021', 'DD/MM/YYYY'), 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon',TO_DATE('12/05/2017', 'DD/MM/YYYY'), 5, true, 11);
