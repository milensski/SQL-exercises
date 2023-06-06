-- Exercise: 27 (Serge I: 2003-02-03)
-- Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers.
-- Result set: maker, average HDD capacity.

SELECT maker, AVG(pc.hd)
FROM product p
INNER JOIN pc ON p.model = pc.model
WHERE maker IN (SELECT DISTINCT maker from product WHERE type = 'Printer')
GROUP BY maker