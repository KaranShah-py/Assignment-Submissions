USE for_practice;

# Creating a table for the data
CREATE TABLE IF NOT EXISTS factbook
(
	country VARCHAR(150),
    area BIGINT,
    birth_rate DECIMAL(10,2),
    death_rate	DECIMAL(10,2),
    infant_mortality_rate BIGINT,
    internet_users DECIMAL(10,2),
    life_exp_at_birth INT,
    maternal_mortality_rate	DECIMAL(10,2),
    net_migration_rate DECIMAL(10,2),
    population BIGINT,
    population_growth_rate DECIMAL(10,2)
);

# Loading the data into the table factbook
LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Project 2 Factbook Project\\cia_factbook.csv"
INTO TABLE factbook
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;


/************************************************************************************************************************************************/

# Answer to the question 
# 1. Which country has the highest population?
WITH CTE AS
(
	SELECT 
		country,
		DENSE_RANK() OVER(ORDER BY population DESC) AS "CountryRank",
		population
	FROM factbook
)
SELECT * FROM CTE 
WHERE CountryRank = 1;


# 2. Which country has the least number of people?
WITH CTE AS
(
	SELECT 
		country,
		DENSE_RANK() OVER(ORDER BY population ASC) AS "CountryRank",
		population
	FROM factbook
)
SELECT * FROM CTE 
WHERE CountryRank = 1;

# 3. Which country is witnessing the highest population growth?
WITH CTE AS
(
	SELECT 
		country,
		DENSE_RANK() OVER(ORDER BY population_growth_rate DESC) AS "CountryRank",
		population_growth_rate
	FROM factbook
)
SELECT * FROM CTE 
WHERE CountryRank = 1;

# 4. Which country has an extraordinary number for the population?
WITH CTE AS
(
	SELECT 
		country,
		DENSE_RANK() OVER(ORDER BY population DESC) AS "CountryRank",
		population
	FROM factbook
)
SELECT * FROM CTE 
WHERE CountryRank = 1;

# 5. Which is the most densely populated country in the world?
SELECT 
	country, (population / area) AS 'Population Density',
    DENSE_RANK() OVER(ORDER BY (population / area) DESC)
FROM factbook
GROUP BY country
LIMIT 1;
/************************************************************************************************************************************************/