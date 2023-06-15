-- Exercise: 86 (Serge I: 2012-04-20)
-- For each maker, list the types of products he produces in alphabetic order, using a slash ("/") as a delimiter.
-- Result set: maker, list of product types.


with distinct_table as (SELECT DISTINCT maker, type
FROM Product
GROUP BY maker, type)

SELECT maker, STRING_AGG(type, '/')
FROM distinct_table
GROUP BY maker

