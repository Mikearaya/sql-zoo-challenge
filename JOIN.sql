/*
show the matchid and player name for all goals scored by Germany. 
To identify German players, check for: teamid = 'GER'
*/
SELECT matchid, player FROM goal 
JOIN eteam on eteam.id = goal.teamid
WHERE eteam.id = 'GER'


-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
FROM game
where id = 1012

-- show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (game.id=goal.matchid)
where teamid = 'GER'


/*
Show the team1, team2 and player for every goal 
scored by a player called Mario player LIKE 'Mario%'
*/
SELECT team1, team2, player
FROM game JOIN goal ON (game.id=goal.matchid)
where player LIKE 'Mario%'

/*
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/

SELECT player, teamid,coach, gtime
FROM goal 
JOIN eteam on goal.teamid=eteam.id
WHERE gtime<=10


/*
List the dates of the matches and the name of the 
team in which 'Fernando Santos' was the team1 coach.
*/
SELECT mdate, teamname
FROM game 
JOIN eteam on game.team1 = eteam.id
WHERE LOWER(coach) = 'fernando santos'


/*

List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/

SELECT player
FROM game
JOIN goal on goal.matchid = game.id
where LOWER(stadium) = 'national stadium, warsaw'


/* 
Instead show the name of all players who scored a goal against Germany.
*/
SELECT DISTINCT player
FROM goal JOIN game ON goal.matchid = game.id 
WHERE (game.team1='GER' OR game.team2='GER') AND goal.teamid != 'GER' AND game.id = goal.matchid


/*
Show teamname and the total number of goals scored
*/

SELECT teamname,  COUNT(goal.matchid)
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname
ORDER BY teamname


/*
Show the stadium and the number of goals scored in each stadium
*/

SELECT stadium,  COUNT(goal.matchid)
FROM game JOIN goal ON game.id = goal.matchid
GROUP BY stadium
ORDER BY stadium

/*
For every match involving 'POL', show the matchid, date and the number of goals scored.
*/

SELECT matchid,mdate, COUNT(goal.matchid) 'GOALs'
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid

/*
For every match where 'GER' scored, show matchid, 
match date and the number of goals scored by 'GER'
*/
SELECT matchid,mdate, COUNT(goal.matchid) 'GOALs'
FROM game JOIN goal ON game.id = goal.matchid 
WHERE (team1 = 'GER' OR team2 = 'GER') and goal.teamid = 'GER'
GROUP BY goal.matchid


/*
List every match with the goals scored by each team as shown. 
This will use "CASE WHEN" which has not been explained in any previous exercises.
*/

SELECT mdate,
team1,
SUM(CASE WHEN goal.teamid=game.team1 THEN 1 ELSE 0 END) score1,
team2,
SUM(CASE WHEN goal.teamid=game.team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY game.mdate, goal.matchid
