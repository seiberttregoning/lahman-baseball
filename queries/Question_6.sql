/*
    QUESTION ::
        Find the player who had the most success stealing bases in 2016,
		where __success__ is measured as the percentage of stolen base 
		attempts which are successful. (A stolen base attempt results 
		either in a stolen base or being caught stealing.) 
		Consider only players who attempted _at least_ 20 stolen bases.

    SOURCES ::
        * people.playerid, people.namelast, people.namefirst, batting.sb (stolen) batting.cs (caught stealing), batting.playerid

    DIMENSIONS ::
        * successful stolen base percentage = stolen base/(stolen base + caught stealing)*100

    FACTS ::
        * ...

    FILTERS ::
        * stolen base + caught stealing >= 20
		yearid = 2016

    DESCRIPTION ::
        ...

    ANSWER ::
        Chris Owings

*/

SELECT namelast, 
	   namefirst, 
	   ROUND(SUM(sb)/(SUM(sb)+SUM(cs)::numeric)*100, 2) AS stolen_base_success_2016
FROM batting
LEFT JOIN people
USING (playerid)
WHERE yearid = 2016
GROUP BY namelast, namefirst
HAVING SUM(sb) + SUM(cs) >= 20
ORDER BY stolen_base_success_2016 DESC
LIMIT 1;
