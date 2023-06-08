-- Exercise: 69 (Serge I: 2011-01-06)
-- Using the Income and Outcome tables, find out the balance for each buy-back center by the end of each day when funds were received or payments were made.
-- Note that the cash isn’t withdrawn, and the unspent balance/debt is carried forward to the next day.
-- Result set: buy-back center ID (point), date in dd/mm/yyyy format, unspent balance/debt by the end of this day.


WITH temp as (SELECT 
            code,
            point,
            date,
            inc,
	    0 as out
        FROM Income
        UNION
        SELECT 
            code,
            point,
            date,
            0 as inc,
            out
        FROM Outcome)

SELECT DISTINCT point,
	CONVERT(varchar, date, 103),
	SUM(inc) OVER(partition by point order by date) - 
	SUM(out) OVER(partition by point order by date)
FROM temp
