/*
From 1970 – 2016, what is the largest number of 
wins for a team that did not win the world series? 
What is the smallest number of wins for a team 
that did win the world series? Doing this will 
probably result in an unusually small number of 
wins for a world series champion – determine why 
this is the case. Then redo your query, excluding 
the problem year. How often from 1970 – 2016 was
it the case that a team with the most wins also 
won the world series? What percentage of the time?
*/

-- CTE to make a table of maximum number of wins in each year by
-- any team between 1970 and 2016 with a value for world series.
with max_wins_per_year AS 
	(SELECT yearid, MAX(w) AS max_wins
	FROM teams
	WHERE yearid BETWEEN 1970 AND 2016
	 AND  wswin IS NOT NULL
	GROUP BY yearid),

-- CTE to match the world series results with the list of years
-- where the team(s) have a win number that matches the number of
-- max wins found in the max_wins_per_year CTE above
    max_w_year_ws_result AS
	(SELECT t.yearid, t.wswin, t.w
     FROM max_wins_per_year AS m
     INNER JOIN teams AS t
     ON m.yearid =  t.yearid
     AND t.w = m.max_wins
	 GROUP BY t.yearid, t.wswin, t.w),
     

-- CTE to find the list of years where two teams tied for max number
-- of wins for that season and one team won the world series
	excluded_years AS
    (SELECT result1.yearid
     FROM max_w_year_ws_result AS result1
     INNER JOIN max_w_year_ws_result AS result2
     ON result1.yearid = result2.yearid
     AND result1.wswin <> result2.wswin
     GROUP BY result1.yearid)
 
-- Query to count lines in second CTE where WSWIN is yes and yearid 
-- is not found in excluded_years CTE. As well as find that and divide
-- by total of lines where year is not found in excluded_years*100

SELECT 
       (SELECT COUNT(*)
	    FROM max_w_year_ws_result
	    WHERE wswin = 'Y' AND
              yearid NOT IN (SELECT yearid
						     FROM excluded_years)) as max_season_and_ws_win,
		ROUND((SELECT COUNT (*)
			  FROM max_w_year_ws_result
			  WHERE wswin = 'Y' AND
			        yearid NOT IN (SELECT yearid
								  FROM excluded_years))::numeric
			  / 
			  (SELECT COUNT (*)
				 FROM max_w_year_ws_result
			    WHERE yearid NOT IN (SELECT yearid
									 FROM excluded_years))*100, 2) AS percentage
			
		
