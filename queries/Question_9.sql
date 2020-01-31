/*
    QUESTION ::
        Which managers have won the TSN Manager of the Year 
		award in both the National League (NL) 
		and the American League (AL)? 
		Give their full name and the teams that 
		they were managing when they won the award.

    SOURCES ::
        * awardsmanagers, people, managers, teams

   ANSWER ::
        Davey Johnson 1997 - Baltimore Orioles
		              2012 - Washington Nationals
		
		Jim Leyland   1988 - Pittsburg Pirates
		              1990 - Pittsburg Pirates
					  1992 - Pittsburg Pirates
					  2006 - Detroit Tigers

*/
SELECT p.namefirst AS first_name,
       p.namelast  AS last_name,
	   sub.yearid  AS year_of_award,
	   sub.lgid    AS league_of_award,
	   t.name      AS team_name 
FROM(
	SELECT a1.playerid, a1.yearid, a1.lgid, a1.awardid
    FROM awardsmanagers AS a1
    INNER JOIN awardsmanagers AS a2
     ON a1.playerid = a2.playerid
    AND a1.lgid <> a2.lgid
    AND a1.awardid = a2.awardid
    WHERE a1.awardid ILIKE '%TSN%'
      AND a1.lgid IN ('NL', 'AL')
     AND a2.lgid IN ('NL', 'AL')
    GROUP BY a1.playerid, a1.yearid, a1.lgid, a1.awardid
    ORDER BY a1.playerid
	) as sub
INNER JOIN people AS p
ON p.playerid = sub.playerid
LEFT JOIN managers AS m
ON sub.playerid = m.playerid
AND sub.yearid = m.yearid
LEFT JOIN teams AS t
ON  m.yearid = t.yearid
AND m.teamid = t.teamid
ORDER BY namelast, year_of_award;
