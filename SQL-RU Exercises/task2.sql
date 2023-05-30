-- Exercise: 8 (Serge I: 2003-02-03)
-- Find the makers producing PCs but not laptops.


SELECT maker
FROM Product
WHERE type = 'PC'
EXCEPT
SELECT maker 
FROM Product
WHERE type = 'Laptop'


