-- Exercise: 99 (qwrqwr: 2013-03-01)
-- Only Income_o and Outcome_o tables are considered. It is known that no money transactions are performed on Sundays.
-- For each buy-back center (point) and each funds receipt date, determine the encashment date according to the following rules:
-- 1. The encashment date is the same as the receipt date if there is no payment entry in the Outcome_o table for this date and point.
-- 2. Otherwise, the first possible date after the receipt date is used that doesn’t fall on Sunday and doesn’t have a corresponding payment entry in the Outcome_o table for the point in question.
-- Output: point, receipt date, encashment date.

SELECT i.point, CASE
		WHEN o.date IS NULL THEN i.date
                ELSE i.date
		END as DP,
	  CASE 
		WHEN o.date IS NOT NULL and datepart(dw,i.date) = 7 THEN DATEADD(day,3,i.date)
		WHEN o.date IS NOT NULL and datepart(dw,i.date) = 6 THEN
DATEADD(day,1,i.date)
		WHEN o.date IS NOT NULL and i.date=o.date THEN
		DATEADD(day,1,i.date)
		ELSE i.date
		END as DI
FROM INCOME_O i
LEFT JOIN OUTCOME_O o ON i.point = o.point and i.date = o.date
