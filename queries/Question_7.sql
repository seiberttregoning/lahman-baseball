/*
    QUESTION ::
        From 1970 – 2016, what is the largest number of wins for a 
		team that did not win the world series? 
		What is the smallest number of wins for a team that did 
		win the world series? Doing this will probably result 
		in an unusually small number of wins for a world series 
		champion – determine why this is the case. 
		Then redo your query, excluding the problem year. 
		How often from 1970 – 2016 was it the case that a team with 
		the most wins also won the world series? What percentage of the time?

    SOURCES ::
        * ...

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWERS ::
        Between 1970 - 2016 (inclusive) the largest number of wins by a team that did not win the world series was 116.
        Between 1970 - 2016 (inclusive) the smallest number of wins by a team that won the world series was 63.
		Unusually small # of wins also had an unusally small number of games played (110 vs 162) in 1981.
			Google shows a players strike that year.
		Between 1970 - 2016 (inclusive) -excluding 1981- the smallest number of wins by a team that won the world series was 83.
		Between 1970 - 2016 (inclusive) -excluding 2007 and 2013 (tie for most wins, one team won one team lost world series)
			and 1994 (no series due to players strike) 10 teams won the world series and also had the greatest number of season wins.
			This occurred 22.73% of the time.
*/
WITH max_w_by_year AS (
                       SELECT yearid, MAX(w)
                       FROM teams
                       WHERE yearid BETWEEN 1970 AND 2016
                         AND wswin IS NOT NULL
                         AND yearid <> 2007
                         AND yearid <> 2013
                       GROUP BY yearid),
   
   totals AS(
             SELECT t.yearid, w, wswin
             FROM teams AS t
             INNER JOIN max_w_by_year AS m
             ON t.yearid = m.yearid AND t.w = m.max
             GROUP BY t.yearid, w, wswin
             ORDER BY yearid)

SELECT 
		(SELECT COUNT(*) 
		 FROM totals 
		 WHERE wswin = 'Y') AS season_greatest_wins_and_world_series_win,

		ROUND((SELECT COUNT(*) 
		 FROM totals 
		 WHERE wswin = 'Y')::numeric
         /
        (SELECT COUNT(*) 
		 FROM totals 
		 WHERE wswin IS NOT NULL)*100, 2) AS percentage


/*
SELECT MIN(w) AS min_wins
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
  AND yearid <> 1981
  AND wswin = 'Y';
*/
/*
SELECT *
FROM teams
WHERE yearid BETWEEN 1970 and 2016
  AND wswin = 'Y'
ORDER BY w;
*/
/*
SELECT MIN(w) AS min_wins
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
  AND wswin = 'Y';
*/
/*
SELECT MAX(w) AS max_wins
FROM teams
WHERE yearid BETWEEN 1970 AND 2016
  AND wswin = 'N';
*/