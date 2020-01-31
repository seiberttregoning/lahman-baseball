/*
    QUESTION ::
        What range of years does the provided database cover?

    SOURCES ::
        * appearances, batting, pitching, people

    DIMENSIONS ::
        * MAX() and MIN()

    DESCRIPTION ::
        Including earliest birthyear from people data starts the data in 1820

    ANSWER ::
        1871 and 2016 from batting, appearances, pitching
		1820 from people.birthyear

*/

SELECT MIN(yearid), MAX(yearid)
FROM batting;
