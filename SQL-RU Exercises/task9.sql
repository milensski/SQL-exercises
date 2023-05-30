-- Exercise: 23 (Serge I: 2003-02-14)
-- Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher.
-- Result set: maker

SELECT DISTINCT p1.maker
FROM Product p1
INNER JOIN PC ON p1.model = PC.model AND PC.speed >= 750
INNER JOIN Product p2 ON p1.maker = p2.maker
INNER JOIN Laptop ON p2.model = Laptop.model AND Laptop.speed >= 750
