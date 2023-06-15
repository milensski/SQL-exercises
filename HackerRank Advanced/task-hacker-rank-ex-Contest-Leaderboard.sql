/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT h.hacker_id, h.name, sum(max_score) 
FROM (
    SELECT hacker_id, challenge_id, max(score) max_score
    FROM submissions s
    GROUP BY hacker_id, challenge_id) x
JOIN hackers h ON h.hacker_id = x.hacker_id
GROUP BY h.hacker_id, h.name
HAVING sum(max_score) > 0
ORDER BY sum(max_score) desc, h.hacker_id