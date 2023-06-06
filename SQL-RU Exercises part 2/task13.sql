-- Exercise: 25 (Serge I: 2003-02-14)
-- Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity.
-- Result set: maker.

SELECT DISTINCT maker
FROM Product JOIN PC
ON Product.model = PC.model
WHERE ram = (
	SELECT MIN(ram)
	FROM PC
)
AND speed = (
	SELECT MAX(speed)
	FROM pc
	WHERE ram = (
		SELECT min(ram) from pc )
	)
AND maker IN (
	SELECT maker
	FROM product
	WHERE type = 'Printer'
	)