/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
with partitioned as (
                    SELECT w.id id, 
                           ws.age age, 
                           w.coins_needed coins_needed,
                           w.power power,
                           DENSE_RANK() OVER(PARTITION BY ws.age, w.power ORDER BY w.coins_needed) rank
                    FROM wands w 
                    JOIN wands_property ws ON w.code = ws.code and ws.is_evil = 0)
                
SELECT id, 
       age, 
       coins_needed,
       power
FROM partitioned
WHERE rank = 1
ORDER BY power DESC, age DESC