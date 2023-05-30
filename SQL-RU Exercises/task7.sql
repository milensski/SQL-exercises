-- Exercise: 18 (Serge I: 2003-02-03)
-- Find the makers of the cheapest color printers.
-- Result set: maker, price.

SELECT product.maker, MIN(pr.price) AS price
FROM Printer pr
INNER JOIN product ON product.model = pr.model
WHERE color = 'y'
GROUP BY product.maker
HAVING MIN(pr.price) = (
    SELECT MIN(price) AS price
    FROM Printer
    WHERE color = 'y'
  )

