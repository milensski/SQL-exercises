-- Exercise: 26 (Serge I: 2003-02-14)
-- Find out the average price of PCs and laptops produced by maker A.
-- Result set: one overall average price for all items.

SELECT AVG(price) as AVG_price
FROM (SELECT pc.price
	FROM product
	INNER JOIN pc ON product.model = pc.model
	WHERE maker = 'A'
	UNION ALL
	SELECT lap.price
	FROM product
	INNER JOIN laptop lap ON product.model = lap.model
	WHERE maker = 'A'
	) as final