/*
    QUESTION ::
       Find the name and height of the shortest player in the database. 
	   How many games did he play in? 
	   What is the name of the team for which he played?

    SOURCES ::
        * players, appearances.g_all appearances.teamid, teams
	

    DIMENSIONS ::
        * height

    FILTERS ::
        * min(height)

    ANSWER ::
        Gaedel, Eddie. 43 inches tall. 1 total game played. Team name = St. Louis Browns

*/

SELECT namelast    AS last_name,
	   namefirst   AS first_name,
	   height      AS height_in_inches,
	   g_all       AS total_games_played,
	   t.name      AS team_name
FROM (SELECT playerid, namelast, namefirst, height
		FROM people
		ORDER BY height
	    LIMIT 1) AS subquery
LEFT JOIN appearances as a
USING (playerid)
LEFT JOIN (
		   SELECT teamid, name
		   FROM teams
		   GROUP BY teamid, name) as t
USING (teamid);