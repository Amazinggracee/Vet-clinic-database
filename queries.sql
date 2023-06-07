/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".

SELECT *
FROM animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-----------------------------------------------
-----------------------------------------------
BEGIN TRANSACTION;

-- Update the species column to 'unspecified' for all animals
UPDATE animals SET species = 'unspecified';

-- Verify the change
SELECT *
FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the species column went back to the state before the transaction
SELECT *
FROM animals;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = '';

--Verify that changes
SELECT *
FROM animals;

-- Begin the transaction
BEGIN TRANSACTION;

-- Delete all records from the animals table
DELETE FROM animals;

-- Verify that the records have been deleted
SELECT *
FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the deleted records have been restored
SELECT *
FROM animals;

--Delete all animals born after Jan 1st, 2022.
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Begin the transaction
BEGIN;
SAVEPOINT my_savepoint;

ROLLBACK TO SAVEPOINT my_savepoint;

--UPDATE
UPDATE animals
SET weight_kg = weight_kg * -1;

BEGIN;
    SAVEPOINT my_savepoint;

ROLLBACK
TO SAVEPOINT my_savepoint;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;


--Here are the queries to answer the questions:

--1.How many animals are there?
SELECT COUNT(*) AS animal_count
FROM animals;

--2. How many animals have never tried to escape?
SELECT COUNT(*) AS never_tried_escape_count
FROM animals
WHERE escape_attempts = 0;

--3. What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight
FROM animals;

--4. Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;

--5. What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

--6. What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


