/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
with total_challenges as (
                            SELECT hacker_id, count(challenge_id) cnt
                            FROM challenges
                            GROUP BY hacker_id),
     grouped_counts as (
                            SELECT cnt, COUNT(*)  total_submits
                            FROM total_challenges
                            GROUP BY cnt)

SELECT t.hacker_id, h.name, t.cnt
FROM total_challenges t
JOIN grouped_counts g ON t.cnt = g.cnt
JOIN hackers h ON h.hacker_id = t.hacker_id
WHERE t.cnt = (SELECT MAX(cnt) FROM total_challenges) OR g.total_submits = 1
ORDER BY t.cnt DESC, hacker_id