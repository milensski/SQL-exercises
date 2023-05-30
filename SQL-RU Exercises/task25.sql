-- Exercise: 6 (Serge I: 2002-10-28)
-- For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.

SELECT Distinct Product.maker, Laptop.speed 
FROM Product
JOIN Laptop ON Product.model = Laptop.model
WHERE Product.type = 'Laptop' AND Laptop.hd >= 10
