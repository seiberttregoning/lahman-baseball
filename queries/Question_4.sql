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
        * ...

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

SELECT MAX(yearid), MIN(yearid)
FROM fieldingpost;
