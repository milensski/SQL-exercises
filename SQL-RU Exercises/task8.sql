-- Exercise: 20 (Serge I: 2003-02-13)
-- Find the makers producing at least three distinct models of PCs.
-- Result set: maker, number of PC models.

SELECT maker, COUNT(model) as count
FROM Product
WHERE type = 'PC'
GROUP by maker
HAVING COUNT(model) >= 3

