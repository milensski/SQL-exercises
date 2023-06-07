-- Exercise: 46 (Serge I: 2003-02-14)
-- For each ship that participated in the Battle of Guadalcanal, get its name, displacement, and the number of guns.

SELECT distinct o.ship, c.displacement, c.numGuns
FROM classes c 
LEFT JOIN ships s ON s.class = c.class
RIGHT JOIN outcomes o ON o.ship = c.class OR s.name = o.ship
WHERE o.battle = 'Guadalcanal'

