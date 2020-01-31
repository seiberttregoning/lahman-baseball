/*
    QUESTION ::
        Find the average number of strikeouts per game by decade since 1920. 
		Round the numbers you report to 2 decimal places. 
		Do the same for home runs per game. Do you see any trends?

    SOURCES ::
        * batting.yearid, batting.hr, batting.so

    DIMENSIONS ::
        * AVG() ROUND( , 2)

   FILTERS ::
        * >1920

   ANSWER ::
        Home runs increased from an avg of 1.86 per game grouped in the 1920s to
		2.57 and 2.24 in the 30s and 40s then between 3.21 and 3.83 from the 50s
		to the end of the data (2016). Average strikeouts per game jumped from
		between 13.04 and 17.69 to 24.13 between the 20s to 50s and the 60s.
		After the 60s the avgerage strikeouts per game stayed in the low to mid
		20s.

*/

SELECT CONCAT(LEFT(yearid::varchar, 3), '0s') AS decade, 
       ROUND(AVG(hr), 2)                      AS avg_home_runs_per_game, 
	   ROUND(AVG(so), 2)                      AS avg_strike_outs_per_game
FROM batting
WHERE yearid >= 1920
GROUP BY decade;
