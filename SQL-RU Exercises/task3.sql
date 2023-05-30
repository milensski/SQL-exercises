-- Exercise: 14 (Serge I: 2002-11-05)
-- For the ships in the Ships table that have at least 10 guns, get the class, name, and country.



SELECT s.class, s.name, c.country
FROM ships s
INNER JOIN classes c ON s.class = c.class
WHERE c.numGuns >= 10


