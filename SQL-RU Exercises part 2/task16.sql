-- Exercise: 28 (Serge I: 2012-05-04)
-- Using Product table, find out the number of makers who produce only one model.

SELECT COUNT(maker)
FROM (SELECT maker
	FROM product 
	GROUP BY maker 
	HAVING COUNT(model) = 1) as x