-- Exercise: 127 (qwrqwr: 2015-04-24)
-- Find out the arithmetic mean (rounded to hundredths) of the following prices:
-- 1. Price of the cheapest Laptops produced by makers of PCs with the lowest CD-ROM speed;
-- 2. Price of the most expensive PCs by makers of the cheapest printers;
-- 3. Price of the most expensive printers by makers of Laptops with the greatest RAM capacity.
-- Note: Exclude missing prices from the calculation.


-- 1. Price of the cheapest Laptops produced by makers of PCs with the lowest CD-ROM speed;
SELECT MIN(price) 
FROM (
				SELECT * FROM product
				WHERE maker = ANY (
								SELECT maker 
								FROM (SELECT p.maker, MIN(pc.cd) as cd FROM product p 
									 JOIN PC on pc.model = p.model
									 GROUP BY p.maker) x ) 
							   AND type = 'Laptop'
			 ) y
JOIN Laptop on laptop.model = y.model;

-- 2. Price of the most expensive PCs by makers of the cheapest printers;
SELECT MAX(price) 
FROM (SELECT DISTINCT * 
FROM product
WHERE maker = ANY ( 
				SELECT maker 
				FROM (
					SELECT maker , MIN(pr.price) FROM product p
					JOIN printer pr ON p.model = pr.model
					GROUP BY p.maker ) x )
				AND type = 'PC' ) y
LEFT JOIN pc ON pc.model = y.model;

-- 3. Price of the most expensive printers by makers of Laptops with the greatest RAM capacity.

SELECT MAX(price) max_price_pr
FROM (SELECT *
FROM product
WHERE maker = ANY ( SELECT maker 
						FROM (SELECT maker , MAX(ram) max_ram FROM product p
											JOIN laptop l ON p.model = l.model
											GROUP BY p.maker ) x )
			 AND type = 'Printer') y
JOIN printer p ON p.model = y.model
-- ------------------------------------------------ --

WITH lap_lowest as (SELECT MIN(price) min_price
FROM (
				SELECT * FROM product
				WHERE maker = ANY (
								SELECT maker 
								FROM (SELECT p.maker, MIN(pc.cd) as cd FROM product p 
									 JOIN PC on pc.model = p.model
									 GROUP BY p.maker) x ) 
							   AND type = 'Laptop'
			 ) y
JOIN Laptop on laptop.model = y.model),

pc_expensive as (SELECT MAX(price) min_price
FROM (SELECT  * 
	FROM product
	WHERE maker = ANY ( SELECT maker 
				FROM (
				SELECT maker , MIN(pr.price) min_price FROM product p
					JOIN printer pr ON p.model = pr.model
					GROUP BY p.maker ) x )
				AND type = 'PC' ) y
LEFT JOIN pc ON pc.model = y.model
),

printer_expensive as (SELECT MAX(price) max_price_pr
FROM (SELECT *
FROM product
WHERE maker = ANY ( SELECT maker 
						FROM (SELECT maker , MAX(ram) max_ram FROM product p
											JOIN laptop l ON p.model = l.model
											GROUP BY p.maker ) x )
			 AND type = 'Printer') y
JOIN printer p ON p.model = y.model)


SELECT SUBSTRING(CAST(AVG(min_price) as VARCHAR),1,6)
FROM (SELECT * FROM lap_lowest
UNION
SELECT * FROM pc_expensive
UNION
SELECT * FROM printer_expensive) x