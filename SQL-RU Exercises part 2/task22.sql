-- Exercise: 36 (Serge I: 2003-02-17)
-- List the names of lead ships in the database (including the Outcomes table).

SELECT DISTINCT name FROM SHIPS
WHERE name IN (SELECT class FROM classes)
UNION
SELECT ship from OUTCOMES 
WHERE ship IN (SELECT class FROM classes)
