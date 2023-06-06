-- Exercise: 65 (Serge I: 2009-08-24)
-- Number the unique pairs {maker, type} in the Product table, ordering them as follows:
-- - maker name in ascending order;
-- - type of product (type) in the order PC, Laptop, Printer.
-- If a manufacturer produces more than one type of product, its name should be displayed in the first row only;
-- other rows for THIS manufacturer should contain an empty string (').

with ord as (SELECT 
	ROW_NUMBER() OVER(ORDER BY maker) as num,
	maker,
	type,
	ROW_NUMBER() OVER(PARTITION BY maker ORDER BY maker) as num2
	FROM (SELECT DISTINCT ROW_NUMBER() OVER(PARTITION BY maker,type ORDER 			 
        	BY maker,type) as num, 
        	maker,
        	type
        	FROM PRODUCT
        	GROUP BY maker, type) as temp)

SELECT num,maker, type, num2
FROM
	(SELECT num,maker,type, num2
	FROM (SELECT num,  
		CASE WHEN num2=1 THEN maker ELSE '' END as maker, 
		type,
		CASE WHEN type='PC' THEN 1
             	WHEN type='Laptop' THEN 2
             	ELSE 3
      		END as num2
		FROM ord
		) as final) as overfinal
        
-- Correct approach :
WITH t AS (
  SELECT 
    ROW_NUMBER() OVER (ORDER BY maker, 
                        CASE WHEN type = 'PC' THEN 1
                             WHEN type = 'Laptop' THEN 2
                             ELSE 3 END) AS num, 
    maker, 
    type
  FROM Product
  GROUP BY maker, type
)

SELECT 
  num,
  CASE 
    WHEN num = 1 OR maker <> LAG(maker) OVER (ORDER BY num) THEN maker 
    ELSE '' 
  END AS maker,
  type
FROM t;