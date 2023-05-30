-- Exercise: 24 (Serge I: 2003-02-03)
-- List the models of any type having the highest price of all products present in the database.

WITH statement AS (
	SELECT product.model, pc.price
	FROM product
	JOIN pc ON pc.model = product.model
	UNION
	SELECT product.model, lap.price
	FROM product
	JOIN laptop lap ON lap.model = product.model
	UNION
	SELECT product.model, pr.price
	FROM product
	JOIN printer pr ON pr.model = product.model)
SELECT model
FROM statement
GROUP BY model
HAVING MAX(price) = (SELECT MAX(price) FROM statement)

