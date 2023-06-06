-- Exercise: 41 (Serge I: 2019-05-31)
-- For each maker who has models at least in one of the tables PC, Laptop, or Printer, determine the maximum price for his products.
-- Output: maker; if there are NULL values among the prices for the products of a given maker, display NULL for this maker, otherwise, the maximum price.


WITH l1 as (SELECT p.maker, p.type, p.model, l.price
FROM product p
JOIN laptop l ON l.model = p.model
WHERE p.type = 'laptop'), l2 as

(SELECT p.maker, p.type, p.model, pc.price
FROM product p
JOIN pc ON pc.model = p.model
WHERE p.type = 'PC'), l3 as
 
(SELECT p.maker, p.type, p.model, pr.price
FROM product p
JOIN printer pr ON pr.model = p.model
WHERE p.type = 'Printer')

SELECT maker, 
	CASE 
    		WHEN sum(CASE 
                WHEN price IS NULL THEN 1 
                ELSE 0 
             	END) > 0 THEN NULL
    		ELSE max(price) 
  	END AS price
FROM (SELECT maker,type, model, price
		FROM l1
		UNION
		SELECT maker,type, model, price
		FROM l2
		UNION
		SELECT maker,type, model, price
		FROM l3) as total
GROUP BY maker
