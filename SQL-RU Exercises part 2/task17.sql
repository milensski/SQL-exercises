-- Exercise: 29 (Serge I: 2003-02-14)
-- Under the assumption that receipts of money (inc) and payouts (out) are registered not more than once a day for each collection point [i.e. the primary key consists of (point, date)], write a query displaying cash flow data (point, date, income, expense).
-- Use Income_o and Outcome_o tables.

SELECT i.point, i.date, i.inc, o.out FROM income_o i
LEFT JOIN outcome_o o ON i.point = o.point AND i.date = o.date
UNION
SELECT o.point, o.date, i.inc, o.out FROM outcome_o o
LEFT JOIN income_o i ON i.point = o.point AND i.date = o.date
