-- Show the total population of the world.
SELECT SUM(population) 'world poulation'
FROM world

-- List of continents
SELECT DISTINCT continent
FROM world

-- Give the total GDP of Africa
SELECT SUM(gdp) 'Africa GDP'
from world
WHERE LOWER(continent) = 'africa'


-- How many countries have an area of at least 1000000
SELECT  Count(name) 'area >= 1000000'
from world
WHERE area >= 1000000

-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT   sum(population) POPULATION
from world
WHERE LOWER(name) IN ('estonia', 'latvia', 'lithuania')

-- For each continent show the continent and number of countries.
SELECT continent, COUNT(name) COUNTRIES
from world
GROUP BY continent

-- For each continent show the continent and number of countries with populations of at least 10 million.

SELECT continent, COUNT(name) COUNTRIES
from world
WHERE population >= 10000000
GROUP BY continent

-- List the continents that have a total population of at least 100 million.

SELECT continent
from world
GROUP BY continent
having sum(population) >= 100000000