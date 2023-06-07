-- Exercise: 48 (Serge I: 2003-02-16)
-- Find the ship classes having at least one ship sunk in battles.

SELECT class FROM outcomes o
JOIN classes c ON c.class = o.ship
WHERE result = 'sunk'
UNION
SELECT class FROM outcomes o
JOIN ships s ON s.name = o.ship
WHERE result = 'sunk'

