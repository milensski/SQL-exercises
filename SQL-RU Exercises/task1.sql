-- Exercise: 7 (Serge I: 2002-11-02)
-- Get the models and prices for all commercially available products (of any type) produced by maker B.

SELECT Product.model, PC.price
FROM Product INNER JOIN 
 PC ON PC.model = Product.model AND Product.maker = 'B'
UNION
SELECT Product.model, Laptop.price
FROM Product INNER JOIN 
 Laptop ON Laptop.model = Product.model AND Product.maker = 'B'
UNION
SELECT Product.model, Printer.price
FROM Product INNER JOIN 
 Printer ON Printer.model = Product.model AND Product.maker = 'B'
