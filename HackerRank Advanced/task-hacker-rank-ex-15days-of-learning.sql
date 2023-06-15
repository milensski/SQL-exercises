SELECT * FROM submissions s;



with count as (
				SELECT submission_date, hacker_id, count(*) as submits
				FROM submissions s
				GROUP BY submission_date, hacker_id
    ),
    final as (
				SELECT submission_date, max(submits) max
				FROM count
				GROUP BY submission_date
	),
    
	unq_counts as (
					SELECT submission_date, count(distinct hacker_id) as unq_hackers
					FROM(
							SELECT *, cast(dense_rank() OVER(partition by hacker_id order by submission_date) as decimal) - DAY(submission_date) as days
							FROM submissions s
						) x
					WHERE days = 0
					GROUP BY submission_date    
    ),
    
    solved as (
					SELECT c.submission_date, MAX(u.unq_hackers) no_unq_hackers, MIN(c.hacker_id) hacker_id  From final f
					JOIN count c ON c.submission_date = f.submission_date and f.max = c.submits
					LEFT JOIN unq_counts u ON c.submission_date = u.submission_date
					GROUP BY c.submission_date
				)
SELECT s.submission_date, s.no_unq_hackers, s.hacker_id, h.name
FROM solved s
JOIN hackers h ON h.hacker_id = s.hacker_id
