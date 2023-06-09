-- Exercise: 97 (qwrqwr: 2013-02-15)
-- From the Laptop table, select rows fulfilling the following condition:
-- the values of the speed, ram, price, and screen columns can be arranged in such a way that each successive value exceeds two or more times the previous one.
-- Note: all known laptop characteristics are greater than zero.
-- Output: code, speed, ram, price, screen.

WITH cte AS (
SELECT
 Attribute,
 Code,
 CONVERT(decimal(18, 2), Value) AS Value
FROM (SELECT
 code,
 CONVERT(varchar(max), speed) AS speed,
 CONVERT(varchar(max), ram) AS ram,
 CONVERT(varchar(max), price) AS price,
 CONVERT(varchar(max), screen) AS screen
FROM Laptop) AS SourceTable
UNPIVOT
(
Value FOR Attribute IN (speed, ram, price, screen)
) AS UnpivotTable
),
ranked_cte AS (
SELECT
 *,
 RANK() OVER (PARTITION BY code ORDER BY value) AS prt
FROM cte),
final_cte AS (
SELECT
 *,
 value AS val,
 LAG(value, 1) OVER (PARTITION BY code ORDER BY prt) AS prt1_value,
 LAG(value, 2) OVER (PARTITION BY code ORDER BY prt) AS prt2_value,
 LAG(value, 3) OVER (PARTITION BY code ORDER BY prt) AS prt3_value
FROM ranked_cte
)

SELECT code,speed,ram,price,screen FROM laptop WHERE code IN (SELECT code FROM final_cte
WHERE val >= prt1_value * 2
AND prt1_value >= prt2_value * 2
AND prt2_value >= prt3_value * 2 )
