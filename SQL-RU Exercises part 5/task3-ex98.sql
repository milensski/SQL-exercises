-- Exercise: 98 (qwrqwr: 2010-04-26)
-- Display the list of PCs, for each of which the result of the bitwise OR operation performed on the binary representations of its respective processor speed and RAM capacity contains a sequence of at least four consecutive bits set to 1.
-- Result set: PC code, processor speed, RAM capacity.


with temp as (
 SELECT code, (speed|ram) as bitwise_or
 from pc
),
recursive as ( 
 SELECT CAST(bitwise_or as INTEGER) n,
	code,
	bitwise_or,
	CAST('' as VARCHAR(MAX)) as bit_repr
	FROM temp
  UNION ALL
 SELECT n / 2,
        code,
        bitwise_or,
        CAST((n%2) as varchar(max)) + bit_repr
        FROM recursive 
        WHERE n > 0)

SELECT pc.code,pc.speed,pc.ram FROM recursive r
JOIN pc on r.code = pc.code
WHERE n = 0 and bit_repr LIKE '%1111%'

