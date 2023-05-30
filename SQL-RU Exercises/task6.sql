-- Exercise: 17 (Serge I: 2003-02-03)
-- Get the laptop models that have a speed smaller than the speed of any PC.
-- Result set: type, model, speed.

SELECT DISTINCT p.type, l.model, l.speed
FROM Product p, Laptop l
WHERE p.type = 'Laptop' AND l.speed < ALL (SELECT pc.speed FROM PC pc)
