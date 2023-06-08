-- Exercise: 57 (Serge I: 2003-02-14)
-- For classes having irreparable combat losses and at least three ships in the database, display the name of the class and the number of ships sunk.

with g as (SELECT class, COUNT(*) as ships FROM outcomes o
RIGHT JOIN ships s on o.ship = s.name
GROUP BY class
HAVING COUNT(*) >= 3)

SELECT class, COUNT(result) as sank
FROM ships s
JOIN outcomes o ON s.name = o.ship
WHERE result = 'sunk'
GROUP BY class
