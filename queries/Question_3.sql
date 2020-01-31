/*
    QUESTION ::
        Find all players in the database who played at Vanderbilt University.
		Create a list showing each player’s first and last names 
		as well as the total salary they earned in the major leagues. 
		Sort this list in descending order by the total salary earned. 
		Which Vanderbilt player earned the most money in the majors?

    SOURCES ::
        * players, schools.schoolid, schools.schoolname, salaries.playerid, salaries.salary

    ANSWER ::
        David Price

*/
SELECT namelast, namefirst, SUM(s.salary)
FROM people
INNER JOIN salaries AS s
USING (playerid)
WHERE playerid IN (
				   SELECT playerid
				   FROM collegeplaying
				   WHERE schoolid IN (
	  								  SELECT schoolid
									  FROM schools
		                              WHERE schoolname LIKE '%anderbilt%'))
GROUP BY namelast, namefirst
ORDER BY sum DESC;
