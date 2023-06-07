-- Exercise: 43 (qwrqwr: 2011-10-28)
-- Get the battles that occurred in years when no ships were launched into water.

SELECT name
FROM battles
WHERE DATEPART(year,CAST(date as date)) NOT IN (SELECT launched FROM ships WHERE launched IS NOT NULL)

