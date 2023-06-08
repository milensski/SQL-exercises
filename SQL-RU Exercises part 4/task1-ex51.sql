-- Exercise: 51 (Serge I: 2003-02-17)
-- Find the names of the ships with the largest number of guns among all ships having the same displacement (including ships in the Outcomes table).

with a as (SELECT name, numGuns, displacement FROM ships s
JOIN classes c ON s.class = c.class
UNION
SELECT ship, numGuns, displacement FROM outcomes o
JOIN classes c ON o.ship = c.class),

b as (SELECT MAX(numGuns) as MaxGun, displacement
FROM a
GROUP BY displacement)

SELECT a.name
FROM a
JOIN b on a.numGuns = b.MaxGun and a.displacement = b.displacement
