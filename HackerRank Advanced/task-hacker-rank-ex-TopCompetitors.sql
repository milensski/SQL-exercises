/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT CONCAT(x.hacker_id, ' ', h.name)
FROM (
        SELECT s.hacker_id, COUNT(s.hacker_id) cnt
        FROM submissions s
        JOIN challenges cha ON s.challenge_id = cha.challenge_id
        JOIN difficulty d ON d.difficulty_level = cha.difficulty_level
        WHERE s.score = d.score
        GROUP BY s.hacker_id
        HAVING COUNT(s.hacker_id) > 1 
     ) x
JOIN hackers h ON h.hacker_id = x.hacker_id
ORDER BY x.cnt DESC, x.hacker_id
;