-- Exercise: 15 (Serge I: 2003-02-03)
-- Get hard drive capacities that are identical for two or more PCs.
-- Result set: hd.

SELECT hd
FROM PC
GROUP BY hd
HAVING count(hd) >= 2


