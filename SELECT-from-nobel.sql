-- Change the query shown so that it displays Nobel prizes for 1950

SELECT yr 'Year', subject, winner
FROM nobel
WHERE yr = 1950

-- Show who won the 1962 prize for Literature
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'


-- Show the year and subject that won 'Albert Einstein' his prize
SELECT yr 'Year', subject
FROM nobel
WHERE LOWER(winner) = 'albert einstein'

-- Give the name of the 'Peace' winners since the year 2000, including 2000
SELECT winner
FROM nobel
WHERE LOWER(subject) = 'peace' and yr >= '2000'

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT yr 'Year',  subject, winner
FROM nobel
WHERE LOWER(subject) = 'literature' and yr BETWEEN '1980' AND '1989'

/*
Show all details of the presidential winners:
Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama
*/

SELECT * 
FROM nobel
WHERE  winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

-- Show the winners with first name John
SELECT winner
FROM nobel
WHERE  LOWER(winner) LIKE 'john%'

/*
Show the year, subject, and name of Physics winners 
for 1980 together with the Chemistry winners for 1984.
*/
SELECT yr 'Year', subject, winner
FROM nobel
WHERE  yr = '1980' AND LOWER(subject) = 'physics'  OR 
LOWER(subject) = 'chemistry' AND yr = '1984'


-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT yr 'Year', subject, winner
FROM nobel
WHERE   yr = '1980' AND
LOWER(subject) NOT IN ('chemistry', 'medicine') 

/*
Show year, subject, and name of people who won a 'Medicine' prize in an early year 
(before 1910, not including 1910) together with winners of a 'Literature' prize 
in a later year (after 2004, including 2004)
*/
SELECT yr 'Year', subject, winner
FROM nobel
WHERE  (LOWER(subject) = 'medicine' AND  yr < '1910') 
OR(LOWER(subject) = 'literature' AND  yr >= '2004') 

-- Find all details of the prize won by PETER GRÜNBERG
SELECT *
FROM nobel
WHERE LOWER(winner) = 'PETER GRÜNBERG'

-- Find all details of the prize won by EUGENE O'NEILL
SELECT *
FROM nobel
WHERE LOWER(winner) = "EUGENE O\'NEILL"

/*
List the winners, year and subject where the winner starts with Sir. 
Show the the most recent first, then by name order
*/
SELECT winner, yr 'Year', subject
FROM nobel
WHERE LOWER(winner) LIKE 'sir%'
ORDER BY yr DESC, winner
/*
Show the 1984 winners and subject ordered by subject and
winner name; but list Chemistry and Physics last.
 */
SELECT winner, subject
FROM nobel
WHERE yr=1984 
ORDER BY subject IN ('Chemistry','Physics'), subject,winner