-- Exercise: 146 (Serge I: 2008-08-30)
-- For the PC in the PC table with the maximum code value, obtain all its characteristics (except for the code) and display them in two columns:
-- - name of the characteristic (title of the corresponding column in the PC table);
-- - its respective value.

with max_code as (SELECT 
	cast(model as varchar(15)) model,
	cast(speed as varchar(15)) speed,
	cast(ram as varchar(15)) ram,
	cast(hd as varchar(15)) hd,
	cast(cd as varchar(15)) cd,
	cast(price as varchar(15)) price
FROM pc
WHERE code = (select max(code) from pc))

SELECT chr value 
FROM 
	(SELECT *
	FROM max_code) x

UNPIVOT(
   value for chr in (model,speed,ram,hd,cd,price)
) as unpvt