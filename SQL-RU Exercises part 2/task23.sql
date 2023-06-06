-- Exercise: 37 (Serge I: 2003-02-17)
-- Find classes for which only one ship exists in the database (including the Outcomes table).

WITH total_ships as (
SELECT c.class, s.name FROM classes c JOIN ships s ON c.class = s.class
UNION
SELECT c.class, o.ship from outcomes o JOIN classes c ON c.class = o.ship
)

SELECT class FROM total_ships GROUP BY class HAVING COUNT(class) = 1
