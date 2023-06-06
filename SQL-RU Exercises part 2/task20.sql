-- Exercise: 40 (Serge I: 2012-04-20)
-- Get the makers who produce only one product type and more than one model. Output: maker, type.


SELECT maker, MAX(type) as type
FROM product
GROUP BY maker
HAVING COUNT(*) > 1 AND MAX(TYPE)=MIN(TYPE)
