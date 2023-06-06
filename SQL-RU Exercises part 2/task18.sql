-- Exercise: 30 (Serge I: 2003-02-14)
-- Under the assumption that receipts of money (inc) and payouts (out) can be registered any number of times a day for each collection point [i.e. the code column is the primary key], display a table with one corresponding row for each operating date of each collection point.
-- Result set: point, date, total payout per day (out), total money intake per day (inc).
-- Missing values are considered to be NULL.

SELECT oo.point, oo.date, oo.out, ii.inc
FROM (SELECT o.point, o.date, SUM(o.out) as out
	FROM outcome o
	GROUP BY point,date) as oo

LEFT JOIN (SELECT i.point, i.date, SUM(i.inc) as inc
	FROM income i
	GROUP BY point,date) as ii ON oo.date = ii.date AND oo.point = ii.point
UNION
SELECT i.point, i.date, o.out, i.inc
FROM (
	SELECT point, date, sum(inc) AS inc
	FROM Income
	GROUP BY point, date
) AS i
LEFT JOIN (
	SELECT point, date, sum(out) AS out
	FROM Outcome
	GROUP BY point, date
) AS o
ON i.point = o.point
AND i.date = o.date

