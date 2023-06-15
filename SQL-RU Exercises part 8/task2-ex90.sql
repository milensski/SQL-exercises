-- Exercise: 90 (Serge I: 2012-05-04)
-- Display all records from the Product table except for three rows with the smallest model numbers and three ones with the greatest model numbers.



SELECT *
FROM product 

WHERE model NOT IN(
		SELECT TOP 3 model
		FROM product
		ORDER BY model) 

	      AND

      model NOT IN(SELECT TOP 3 model
		FROM product
		ORDER BY model DESC)