/*
<COVID-19 Analysis SQL Project>
Before starting in this SCL script, I did some basic preprocessing of the dataset before uploading them into my own SQL database using the upload wizard.
*/

-- DATA CLEANNING --

-- First table: coviddeaths --
-- Checking to see if all data are correctly being imported for the death table
SELECT COUNT(*)
FROM coviddeaths;
SELECT *
FROM coviddeaths;

-- Need to update missing values to NULL
UPDATE coviddeaths
SET iso_code = IF(iso_code = '', NULL, iso_code),
	continent = IF(continent = '', NULL, continent),
    location = IF(location = '', NULL, location),
    date = IF(date = '', NULL, date),
    population = IF(population = '', NULL, population),
    total_cases = IF(total_cases = '', NULL, total_cases),
    new_cases = IF(new_cases = '', NULL, new_cases),
    new_cases_smoothed = IF(new_cases_smoothed = '', NULL, new_cases_smoothed),
    total_deaths = IF(total_deaths = '', NULL, total_deaths),
    new_deaths = IF(new_deaths = '', NULL, new_deaths),
    new_deaths_smoothed = IF(new_deaths_smoothed = '', NULL, new_deaths_smoothed),
    total_cases_per_million = IF(total_cases_per_million = '', NULL, total_cases_per_million),
    new_cases_per_million = IF(new_cases_per_million = '', NULL, new_cases_per_million),
    new_cases_smoothed_per_million = IF(new_cases_smoothed_per_million = '', NULL, new_cases_smoothed_per_million),
    total_deaths_per_million = IF(total_deaths_per_million = '', NULL, total_deaths_per_million),
    new_deaths_per_million = IF(new_deaths_per_million = '', NULL, new_deaths_per_million),
    new_deaths_smoothed_per_million = IF(new_deaths_smoothed_per_million = '', NULL, new_deaths_smoothed_per_million),
    reproduction_rate = IF(reproduction_rate = '', NULL, reproduction_rate),
    icu_patients = IF(icu_patients = '', NULL, icu_patients),
    icu_patients_per_million = IF(icu_patients_per_million = '', NULL, icu_patients_per_million),
    hosp_patients = IF(hosp_patients = '', NULL, hosp_patients),
    hosp_patients_per_million = IF(hosp_patients_per_million = '', NULL, hosp_patients_per_million),
    weekly_icu_admissions = IF(weekly_icu_admissions = '', NULL, weekly_icu_admissions),
    weekly_icu_admissions_per_million = IF(weekly_icu_admissions_per_million = '', NULL, weekly_icu_admissions_per_million),
    weekly_hosp_admissions = IF(weekly_hosp_admissions = '', NULL, weekly_hosp_admissions),
    weekly_hosp_admissions_per_million = IF(weekly_hosp_admissions_per_million = '', NULL, weekly_hosp_admissions_per_million);

-- Handling data types in columns that I am going to use --
SELECT *
FROM coviddeaths
WHERE NOT total_cases REGEXP '^-?[0-9]+$';
ALTER TABLE coviddeaths
MODIFY total_cases INT;

SELECT *
FROM coviddeaths
WHERE STR_TO_DATE(date, '%Y-%m-%d %H:%i:%s') IS NULL
  AND date IS NOT NULL;
ALTER TABLE coviddeaths
MODIFY date DATE;
UPDATE coviddeaths
SET date = DATE(date);

SELECT *
FROM coviddeaths
WHERE NOT population REGEXP '^-?[0-9]+$';
ALTER TABLE coviddeaths
MODIFY population INT;

SELECT *
FROM coviddeaths
WHERE NOT new_cases REGEXP '^-?[0-9]+$';
ALTER TABLE coviddeaths
MODIFY new_cases INT;

SELECT *
FROM coviddeaths
WHERE NOT total_deaths REGEXP '^-?[0-9]+$';
ALTER TABLE coviddeaths
MODIFY total_deaths INT;

SELECT *
FROM coviddeaths
WHERE NOT new_deaths REGEXP '^-?[0-9]+$';
ALTER TABLE coviddeaths
MODIFY new_deaths INT;

-- Second table: covidvaccinations --
-- Checking to see if all data are correctly being imported for the vaccinations table
SELECT COUNT(*)
FROM covidvaccinations;
SELECT *
FROM covidvaccinations;

-- Same as the last table, need to update missing values to NULL
UPDATE covidvaccinations
SET iso_code = IF(iso_code = '', NULL, iso_code),
	continent = IF(continent = '', NULL, continent),
    location = IF(location = '', NULL, location),
    date = IF(date = '', NULL, date),
	new_tests = IF(new_tests = '', NULL, new_tests),
    total_tests = IF(total_tests = '', NULL, total_tests),
    total_tests_per_thousand = IF(total_tests_per_thousand = '', NULL, total_tests_per_thousand),
    new_tests_per_thousand = IF(new_tests_per_thousand = '', NULL, new_tests_per_thousand),
    new_tests_smoothed = IF(new_tests_smoothed = '', NULL, new_tests_smoothed),
    new_tests_smoothed_per_thousand = IF(new_tests_smoothed_per_thousand = '', NULL, new_tests_smoothed_per_thousand),
    positive_rate = IF(positive_rate = '', NULL, positive_rate),
    tests_per_case = IF(tests_per_case = '', NULL, tests_per_case),
    tests_units = IF(tests_units = '', NULL, tests_units),
    total_vaccinations = IF(total_vaccinations = '', NULL, total_vaccinations),
    people_vaccinated = IF(people_vaccinated = '', NULL, people_vaccinated),
    people_fully_vaccinated = IF(people_fully_vaccinated = '', NULL, people_fully_vaccinated),
    new_vaccinations = IF(new_vaccinations = '', NULL, new_vaccinations),
    new_vaccinations_smoothed = IF(new_vaccinations_smoothed = '', NULL, new_vaccinations_smoothed),
    total_vaccinations_per_hundred = IF(total_vaccinations_per_hundred = '', NULL, total_vaccinations_per_hundred),
    people_vaccinated_per_hundred = IF(people_vaccinated_per_hundred = '', NULL, people_vaccinated_per_hundred),
    people_fully_vaccinated_per_hundred = IF(people_fully_vaccinated_per_hundred = '', NULL, people_fully_vaccinated_per_hundred),
    new_vaccinations_smoothed_per_million = IF(new_vaccinations_smoothed_per_million = '', NULL, new_vaccinations_smoothed_per_million),
    stringency_index = IF(stringency_index = '', NULL, stringency_index),
    population_density = IF(population_density = '', NULL, population_density),
    median_age = IF(median_age = '', NULL, median_age),
    aged_65_older = IF(aged_65_older = '', NULL, aged_65_older),
    aged_70_older = IF(aged_70_older = '', NULL, aged_70_older),
    gdp_per_capita = IF(gdp_per_capita = '', NULL, gdp_per_capita),
    extreme_poverty = IF(extreme_poverty = '', NULL, extreme_poverty),
    cardiovasc_death_rate = IF(cardiovasc_death_rate = '', NULL, cardiovasc_death_rate),
    diabetes_prevalence = IF(diabetes_prevalence = '', NULL, diabetes_prevalence),
    female_smokers = IF(female_smokers = '', NULL, female_smokers),
    male_smokers = IF(male_smokers = '', NULL, male_smokers),
    handwashing_facilities = IF(handwashing_facilities = '', NULL, handwashing_facilities),
    hospital_beds_per_thousand = IF(hospital_beds_per_thousand = '', NULL, hospital_beds_per_thousand),
    life_expectancy = IF(life_expectancy = '', NULL, life_expectancy),
    human_development_index = IF(human_development_index = '', NULL, human_development_index);

-- Handling data types in columns that I am going to use --
SELECT *
FROM covidvaccinations
WHERE STR_TO_DATE(date, '%Y-%m-%d %H:%i:%s') IS NULL
  AND date IS NOT NULL;
ALTER TABLE covidvaccinations
MODIFY date DATE;
UPDATE covidvaccinations
SET date = DATE(date);

SELECT *
FROM covidvaccinations
WHERE NOT new_tests REGEXP '^-?[0-9]+$';
ALTER TABLE covidvaccinations
MODIFY new_tests INT;

SELECT *
FROM covidvaccinations
WHERE NOT total_tests REGEXP '^-?[0-9]+$';
ALTER TABLE covidvaccinations
MODIFY total_tests INT;

SELECT *
FROM covidvaccinations
WHERE NOT total_vaccinations REGEXP '^-?[0-9]+$';
ALTER TABLE covidvaccinations
MODIFY total_vaccinations INT;

SELECT *
FROM covidvaccinations
WHERE NOT people_vaccinated REGEXP '^-?[0-9]+$';
ALTER TABLE covidvaccinations
MODIFY people_vaccinated INT;

SELECT *
FROM covidvaccinations
WHERE NOT people_fully_vaccinated REGEXP '^-?[0-9]+$';
ALTER TABLE covidvaccinations
MODIFY people_fully_vaccinated INT;

SELECT *
FROM covidvaccinations
WHERE NOT new_vaccinations REGEXP '^-?[0-9]+$';
ALTER TABLE covidvaccinations
MODIFY new_vaccinations INT;

SELECT *
FROM covidvaccinations
WHERE population_density NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';
ALTER TABLE covidvaccinations
MODIFY population_density DOUBLE;



-- QUERIES --

-- PART I: finding problems --

-- Problem in continent and location

SELECT		*
FROM		coviddeaths
WHERE		continent IS NULL;

-- I can see that from this query there are some rows with NULL values inside the continent column, where the continent name is recorded in the location column

SELECT		location
FROM		coviddeaths
WHERE		continent IS NULL
GROUP BY	location;

SELECT		location
FROM		coviddeaths
GROUP BY	location;

-- From the looks of it, the data set included continent informations in the location column as well, and for those rows, it left the continent column NULL.

SELECT		location
FROM		covidvaccinations
WHERE		continent IS NULL
GROUP BY	location;

SELECT		location
FROM		covidvaccinations
GROUP BY	location;

-- The same goes for the other table.


-- PART II: EDA --

-- 1. Global Data
With A AS
(
SELECT		location, date, population, total_cases, total_deaths
FROM		coviddeaths
WHERE		location = 'world'
GROUP BY	location, date, population, total_cases, total_deaths
),
B AS
(
SELECT		MAX(population) AS population, MAX(total_cases) AS TotalCases, MAX(total_deaths) AS TotalDeaths
FROM 		A
)
SELECT		TotalCases, TotalDeaths, TotalDeaths/TotalCases*100 AS DeathRate, TotalCases/population*100 InfectionRate
FROM		B;


-- 2. Total Data in the world: Population/Cases/Deaths, Infection rate/Death rate

SELECT		location, date, population, total_cases, total_deaths, (total_cases/population)*100 AS infected_percentage, (total_deaths/total_cases)*100 AS death_percentage
FROM		coviddeaths
WHERE		location = 'world';

-- 3. Countries with highest infection rate

SELECT		location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases/population)*100 AS HighestPercentPopulationInfected
FROM		coviddeaths
WHERE		continent IS NOT NULL
GROUP BY	location, population
ORDER BY	HighestPercentPopulationInfected DESC;

-- 4. Countries with highest death rate

SELECT		location, MAX(total_deaths/total_cases)*100 AS DeathPercentage
FROM		coviddeaths
WHERE		continent IS NOT NULL
GROUP BY	location
ORDER BY	DeathPercentage DESC;
-- This does not make sence since when there are very few cases with some deaths, deathpercentage will be very high, I need a different approach.
-- I am going to find the max death count, use the earliest date of that death count to find the total cases for that date and calculate the death rate at that point for every country.

With A AS
(
SELECT		location, MAX(total_deaths) AS MostDeaths
FROM		coviddeaths
WHERE		continent IS NOT NULL
GROUP BY	location
),
B AS
(
SELECT		A.location, MIN(coviddeaths.date) AS EarliestDate
FROM		A
INNER JOIN	coviddeaths
ON			A.location = coviddeaths.location
			AND A.MostDeaths = coviddeaths.total_deaths
GROUP BY	A.location
),
C AS
(
SELECT		A.location, B.EarliestDate, A.MostDeaths
FROM		A
INNER JOIN	B
ON			A.location = B.location
)
SELECT		C.location AS Location, (C.MostDeaths/coviddeaths.total_cases)*100 AS DeathPercentage
FROM		C
INNER JOIN	coviddeaths
ON			C.location = coviddeaths.location
			AND C.EarliestDate = coviddeaths.date
ORDER BY	DeathPercentage DESC
;

-- 5. Countries with Highest death count

SELECT		location, MAX(total_deaths) AS TotalDeathCount
FROM		coviddeaths
WHERE		continent IS NOT NULL
GROUP BY	location
ORDER BY	TotalDeathCount DESC;

-- 6. Total Population vs Vaccinations

-- First take a look at columns related to vaccinations to get a better understanding what they represent
SELECT		location, date, total_vaccinations, people_vaccinated, people_fully_vaccinated, new_vaccinations
FROM		covidvaccinations
WHERE		continent IS NOT NULL
			AND location = 'United States';
-- The column new_vaccinations clearly misses some values that I cannot use, and total_vaccinations does not add up to people_vaccinated, 
-- which means after a while, some people are getting their second or third shot. So I am only going to use people_vaccinated and people_fully_vaccinated

WITH A AS
(
SELECT		coviddeaths.population, covidvaccinations.*
FROM		covidvaccinations
INNER JOIN	coviddeaths
ON			covidvaccinations.location = coviddeaths.location
			AND covidvaccinations.date = coviddeaths.date
WHERE		covidvaccinations.continent IS NOT NULL
),
B AS
(
SELECT		location, population, MAX(people_vaccinated) AS HighestVaccinated
FROM		A
GROUP BY	location, population
)
SELECT		location, (HighestVaccinated/population)*100 AS PercentageVaccinated
FROM		B
ORDER BY	PercentageVaccinated DESC
;

-- The one result Gibraltar has more than 100% vacciation which is very weird, I am going to investigate
SELECT		location, date, total_vaccinations, people_vaccinated, people_fully_vaccinated, new_vaccinations
FROM		covidvaccinations
WHERE		continent IS NOT NULL
			AND location = 'Gibraltar';
SELECT		location, population
FROM		coviddeaths
WHERE		location = 'Gibraltar';
-- Looks like I did everything correctly but according to the record, this indeed is the case. I gues maybe some poeple in Gibraltar who got vaccinated are not their citizen.

-- 7. Cases, Deaths, and DeathRates vver time by Continent

SELECT		continent
FROM		coviddeaths
GROUP BY	continent;
-- There is one NULL continent, it is the ones that continent is specified in the location column, I need to exclude this in the query.

SELECT		continent, date, SUM(total_cases) AS TotalCases, SUM(total_deaths) AS TotalDeaths, SUM(total_deaths)/SUM(total_cases) AS DeathRate
FROM		coviddeaths
WHERE		continent IS NOT NULL
GROUP BY	continent, date;


