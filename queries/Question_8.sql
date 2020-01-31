/*
    QUESTION ::
        Using the attendance figures from the homegames table, 
		find the teams and parks which had the top 5 average 
		attendance per game in 2016 (where average attendance 
		is defined as total attendance divided by number of games). 
		Only consider parks where there were at least 10 games played.
		Report the park name, team name, and average attendance. 
		Repeat for the lowest 5 average attendance.

    SOURCES ::
        * homegames.year, homegames.attendance, homegames.park, parks.park, parks.park_name, homegames.team, teams.teamid?, teams.name?

   FILTERS ::
        * homegames.year = 2016 homegames.games >10

   ANSWER ::        
	                             -Top 5 Avg attendance in 2016-
					 
	      Park Name                           Team Name                  Avg Attendance
        "Dodger Stadium"	                 "Los Angeles Dodgers"	       45719.90
        "Busch Stadium III"                  "St. Louis Cardinals"	       42524.57
        "Rogers Centre"	                     "Toronto Blue Jays"	       41877.77
        "AT&T Park"	                         "San Francisco Giants"	       41546.37
        "Wrigley Field"  	                 "Chicago Cubs"	               39906.42

                           
						         -Lowest 5 Avg attendance in 2016-
					   
		  Park Name                           Team Name                  Avg Attendance
        "Tropicana Field"	                "Tampa Bay Rays"	           15878.56
        "Oakland-Alameda County Coliseum"	"Oakland Athletics"	           18784.02
        "Progressive Field"	                "Cleveland Indians"  	       19650.21
        "Marlins Park"	                    "Miami Marlins"	               21405.21
        "U.S. Cellular Field"            	"Chicago White Sox"  	       21559.17
*/
SELECT p.park_name,
       t.name                                AS team_name, 
	   ROUND(h.attendance/games::numeric, 2) AS avg_attendance
FROM homegames AS h
JOIN teams AS t
  ON h.team = t.teamid
 AND h.year = t.yearid
JOIN parks AS p
  ON h.park = p.park
WHERE year = 2016
  AND games >= 10
ORDER BY avg_attendance
LIMIT 5;



SELECT p.park_name,
       t.name                                AS team_name, 
	   ROUND(h.attendance/games::numeric, 2) AS avg_attendance
FROM homegames AS h
JOIN teams AS t
  ON h.team = t.teamid
 AND h.year = t.yearid
JOIN parks AS p
  ON h.park = p.park
WHERE year = 2016
  AND games >= 10
ORDER BY avg_attendance DESC
LIMIT 5;
