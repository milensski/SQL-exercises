-- Exercise: 101 (qwrqwr: 2013-03-29)
-- The Printer table is sorted by the code field in ascending order.
-- The ordered rows form groups: the first group starts with the first row, each row having color=’n’ begins a new group, the groups of rows don’t overlap.
-- For each group, determine the maximum value of the model field (max_model), the number of unique printer types (distinct_types_cou), and the average price (avg_price).
-- For all table rows, display code, model, color, type, price, max_model, distinct_types_cou, avg_price.

WITH grouped as (SELECT *,
	SUM(CASE WHEN color = 'n' THEN 1 ELSE 0 END) OVER(ORDER BY code) grp
FROM Printer),

agg as (SELECT grp, MAX(model) max_model, COUNT(DISTINCT type) distinct_type , AVG(price) avg_price
FROM grouped
GROUP BY grp)

SELECT g.code,g.model,g.color,g.type,g.price, agg.max_model, agg.distinct_type, agg.avg_price
FROM grouped g
JOIN agg ON agg.grp = g.grp
