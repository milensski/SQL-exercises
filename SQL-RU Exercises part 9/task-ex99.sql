-- Only Income_o and Outcome_o tables are considered. It is known that no money transactions are performed on Sundays.
-- For each buy-back center (point) and each funds receipt date, determine the encashment date according to the following rules:
-- 1. The encashment date is the same as the receipt date if there is no payment entry in the Outcome_o table for this date and point.
-- 2. Otherwise, the first possible date after the receipt date is used that doesn’t fall on Sunday and doesn’t have a corresponding payment entry in the Outcome_o table for the point in question.
-- Output: point, receipt date, encashment date.

-- SQL RU code with error in 2nd database 

SELECT i.point, i.date as DI,
		CASE WHEN o.date IS NOT NULL AND DATEPART(dw, DATEADD(day, 1 ,o.date)) = 1 THEN CASE WHEN DATEADD(day, 2, o.date) IN (SELECT date FROM outcome_o oo  where oo.point = i.point) THEN DATEADD(day, 3,o.date) ELSE DATEADD(day, 2, o.date) END
			 WHEN o.date IS NOT NULL AND DATEPART(dw, DATEADD(day, 1, o.date)) != 1 THEN CASE WHEN DATEADD(day, 1, o.date) IN (SELECT date FROM outcome_o oo  where oo.point = i.point) THEN DATEADD(day, 2, o.date) ELSE DATEADD(day, 1, o.date) END
     ELSE i.date END as DP
FROM Income_o as i
LEFT JOIN outcome_o as o ON i.point = o.point AND i.date = o.date;

-- MY_SQL CODE------------------------- 
SELECT * FROM Income_o;
SELECT * FROM Outcome_o;

SELECT i.point, i.date as DI,
		CASE WHEN o.date IS NOT NULL AND DAYOFWEEK(DATE_ADD(o.date, INTERVAL 1 DAY)) = 1 THEN CASE WHEN DATE_ADD(o.date, INTERVAL 2 DAY) IN (SELECT date FROM outcome_o oo  where oo.point = i.point) THEN DATE_ADD(o.date, INTERVAL 3 DAY) ELSE DATE_ADD(o.date, INTERVAL 2 DAY) END
			 WHEN o.date IS NOT NULL AND DAYOFWEEK(DATE_ADD(o.date, INTERVAL 1 DAY)) != 1 THEN CASE WHEN DATE_ADD(o.date, INTERVAL 1 DAY) IN (SELECT date FROM outcome_o oo  where oo.point = i.point) THEN DATE_ADD(o.date, INTERVAL 2 DAY) ELSE DATE_ADD(o.date, INTERVAL 1 DAY) END
     ELSE i.date END as DP
FROM Income_o as i
LEFT JOIN outcome_o as o ON i.point = o.point AND i.date = o.date;


