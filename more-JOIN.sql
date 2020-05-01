
-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962


-- Give year of 'Citizen Kane'.
SELECT yr 'Year'
 FROM movie
 WHERE title = 'Citizen Kane' 


/*
List all of the Star Trek movies, include the id, title and 
yr (all of these movies include the words Star Trek in the title). Order results by year
*/

SELECT id, title, yr 'Year'
FROM movie
WHERE title LIKE '%Star Trek%' 
ORDER By yr


/* What id number does the actor 'Glenn Close' have?*/
SELECT id
FROM actor
WHERE LOWER(name) =  'Glenn Close'



/*
What is the id of the film 'Casablanca'
*/
SELECT id
FROM movie
WHERE LOWER(title) =  'Casablanca'


/*
Obtain the cast list for 'Casablanca'.
Use movieid=11768, (or whatever value you got from the previous question)
*/
SELECT name
FROM casting
JOIN actor on actor.id = casting.actorid
WHERE movieid = 11768

/*
Obtain the cast list for the film 'Alien'
*/
SELECT name
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor on actor.id = casting.actorid
WHERE LOWER(movie.title) = 'alien'

/*
List the films in which 'Harrison Ford' has appeared
*/
SELECT title
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor on actor.id = casting.actorid
WHERE LOWER(actor.name) = 'harrison ford'

/*
List the films where 'Harrison Ford' has appeared - 
but not in the starring role. [Note: the ord field of casting 
gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT title
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor on actor.id = casting.actorid
WHERE LOWER(actor.name) = 'harrison ford' AND ord <> 1


/*
List the films together with the leading star for all 1962 films.
*/
SELECT  title, name
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor on actor.id = casting.actorid
WHERE yr = 1962 AND ord = 1

/*
Which were the busiest years for 'Rock Hudson', 
show the year and the number of movies he made 
each year for any year in which he made more than 2 movies.
*/
SELECT yr 'Year' ,COUNT(movie.id) 'Total' FROM
movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING total > 2

/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/

SELECT title, name 
FROM casting
JOIN actor on actor.id = casting.actorid AND ord = 1
JOIN movie on movie.id = casting.movieid
WHERE movie.id IN (
SELECT movieid FROM casting
WHERE
 actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))

/*
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/
SELECT  name
FROM casting
JOIN actor on actor.id = casting.actorid
WHERE ord = 1
GROUP BY casting.actorid
HAVING count(casting.actorid) > 14
Order by name


/*
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/

SELECT  title, COUNT(casting.actorId) 'Actors'
FROM movie
JOIN casting on casting.movieid = movie.id
WHERE yr = 1978
GROUP BY title
Order by Actors DESC, title 

/*
List all the people who have worked with 'Art Garfunkel'.
*/

SELECT  name 
FROM casting
JOIN actor on actor.id = casting.actorid AND LOWER(actor.name) <> 'art garfunkel'
JOIN movie on movie.id = casting.movieid
WHERE movie.id IN (
SELECT movieid FROM casting
WHERE
 actorid IN (
  SELECT id FROM actor
  WHERE name='Art Garfunkel'))

/*
Use CASE to show the name of each teacher followed 
by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
*/

SELECT teacher.name,
CASE 
    WHEN dept.id IN (1, 2) THEN 'Sci'
    ELSE 'Art'  
END AS teacher
FROM teacher LEFT JOIN dept
        ON (teacher.dept=dept.id)

/*
Use CASE to show the name of each teacher followed by 'Sci'
if the teacher is in dept 1 or 2, show 'Art' 
if the teacher's dept is 3 and 'None' otherwise.
*/
SELECT teacher.name,
CASE 
    WHEN dept.id IN (1, 2) THEN 'Sci'
    WHEN dept.id = 3  THEN 'Art'
    ELSE 'None'  
END AS teacher
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)