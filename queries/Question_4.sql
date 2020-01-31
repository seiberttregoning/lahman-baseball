/*
    QUESTION ::
        Using the fielding table, group players into 
		three groups based on their position: 
		label players with position OF as "Outfield", 
		those with position "SS", "1B", "2B", and "3B"
		as "Infield", and those with position "P" or "C"
		as "Battery". Determine the number of putouts 
		made by each of these three groups in 2016.

    SOURCES ::
        * fielding

    FILTERS ::
        * year = 2016

   ANSWER ::
        Battery = 41424
		Infield = 58934
		Outfield = 29560

*/


SELECT SUM(po) AS sum_of_putouts, position_group
FROM	(SELECT po, 
		        CASE WHEN pos IN ('OF') THEN 'Outfield'
		             WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
			         WHEN pos IN ('C', 'P') THEN 'Battery'
			         ELSE 'Other' END AS position_group
		 FROM fielding
		 WHERE yearid = '2016') AS subquery
GROUP BY position_group;
