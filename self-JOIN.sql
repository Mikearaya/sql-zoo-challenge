-- How many stops are in the database.
SELECT COUNT(id) 'Stops'
FROM stops

-- Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE LOWER(name) = 'craiglockhart'

-- Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name
FROM stops
JOIN route ON route.stop = stops.id 
WHERE route.num = '4' AND route.company = 'LRT';

/*
The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes.
*/
SELECT company, num, COUNT(*) 'stops' 
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING stops > 1


/*
Execute the self join shown and observe that b.stop gives all the places 
you can get to from Craiglockhart, without changing routes. 
Change the query so that it shows the services from Craiglockhart to London Road.
*/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149

/*
Change the query so that the services between 'Craiglockhart' and 'London Road' are shown
*/

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE LOWER(stopa.name)='Craiglockhart' AND LOWER(stopb.name) = 'london road'


/* 
Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
*/
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop = 137 OR b.stop=115 AND b.stop = 137

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
JOIN stops aas on aas.id = a.stop
JOIN stops bs on bs.id = b.stop
WHERE (aas.name = 'Craiglockhart' AND bs.name = 'Tollcross') or
(bs.name = 'Craiglockhart' AND aas.name = 'Tollcross')

/*
Give a distinct list of the stops which may be reached 
from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, 
offered by the LRT company. Include the company and bus no. of the relevant services.
*/
SELECT s2.name, r1.company, r1.num
FROM route r1 
JOIN route r2 ON (r1.company=r2.company AND r1.num=r2.num)
JOIN stops s1 ON (r1.stop = s1.id)
JOIN stops s2 ON (r2.stop = s2.id)
WHERE LOWER(s1.name) = 'craiglockhart'

/*
Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus 
*/
SELECT cr.num, cr.company, stops.name, loc.num, loc.company
    FROM (SELECT a.company, a.num, b.stop
        FROM route a 
        JOIN route b ON (a.company=b.company AND a.num=b.num)
        WHERE a.stop=53
        ) AS cr
    JOIN (SELECT a.company, a.num, b.stop
        FROM route a 
        JOIN route b ON (a.company=b.company AND a.num=b.num)
        WHERE a.stop=147
        ) AS loc
    ON (cr.stop = loc.stop)
    JOIN stops ON(stops.id = cr.stop)
    GROUP BY cr.num, stops.name, cr.num
