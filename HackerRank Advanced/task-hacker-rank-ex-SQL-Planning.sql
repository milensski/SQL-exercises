/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

with ends as (
                SELECT p2.end_date, row_number() over(order by p2.end_date) rn
                FROM projects p
                RIGHT JOIN projects p2 ON p.start_date = p2.end_date
                WHERE p.task_id IS NULL),    
    starts as (
                SELECT p.start_date, row_number() over(order by p.start_date) rn
                FROM projects p
                LEFT JOIN projects p2 ON p.start_date = p2.end_date
                WHERE p2.task_id IS NULL)
                
SELECT s.start_date, e.end_date
FROM starts s
JOIN ends e on s.rn = e.rn
ORDER BY DATEDIFF(day, s.start_date, e.end_date), s.start_date