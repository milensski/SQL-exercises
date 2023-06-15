/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

WITH total_submits as (SELECT  con.contest_id,
                        sum(s.total_submissions) total_submissions,
                        sum(s.total_accepted_submissions) total_accepted_submissions
                FROM contests con
                JOIN colleges col ON con.contest_id = col.contest_id
                JOIN challenges chal ON chal.college_id = col.college_id
                JOIN submission_stats s ON s.challenge_id = chal.challenge_id
                GROUP BY con.contest_id
        ),
    total_views as (SELECT  con.contest_id, 
                        sum(v.total_views) total_views,
                        sum(v.total_unique_views) total_unique_views
                FROM contests con
                JOIN colleges col ON con.contest_id = col.contest_id
                JOIN challenges chal ON chal.college_id = col.college_id
                JOIN view_stats v ON chal.challenge_id = v.challenge_id
                GROUP BY con.contest_id)

SELECT c.contest_id, c.hacker_id, c.name,
        ts.total_submissions, ts.total_accepted_submissions,
        tv.total_views, tv.total_unique_views
FROM contests c
JOIN total_submits ts ON ts.contest_id = c.contest_id
JOIN total_views tv ON tv.contest_id = c.contest_id
WHERE ts.total_submissions > 0 OR ts.total_accepted_submissions > 0 OR
        tv.total_views > 0 OR tv.total_unique_views > 0
ORDER BY c.contest_id
;