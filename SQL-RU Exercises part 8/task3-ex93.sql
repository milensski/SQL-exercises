-- Exercise: 93 (Serge I: 2003-06-05)
-- For each airline that transported passengers calculate the total flight duration of its planes.
-- Result set: company name, duration in minutes.


-- Solution for SQL-RU
SELECT name, SUM(timediff)
FROM (
	SELECT pt.trip_no, c.name, time_out, time_in, 
		CASE WHEN time_in < time_out THEN DATEDIFF(mi, time_out, DATEADD(day, 1, time_in)) ELSE DATEDIFF(mi, time_out, time_in) END as timediff
       FROM pass_in_trip pt 
       JOIN
       trip t
               ON t.trip_no=pt.trip_no 
	   JOIN company c ON c.ID_comp = t.ID_comp
       GROUP BY pt.trip_no, c.name, date, time_out, time_in ) x
GROUP BY name
;


-- MY_SQL Solution -- 

SELECT name, SUM(timediff)
FROM (
SELECT pt.trip_no, c.name, time_out, time_in, 
		CASE WHEN time_in < time_out THEN TIMESTAMPDIFF(minute, time_out, DATE_ADD(time_in, INTERVAL 1 DAY)) ELSE TIMESTAMPDIFF(minute, time_out, time_in) END as timediff
       FROM pass_in_trip pt 
       JOIN
       trip t
               ON t.trip_no=pt.trip_no 
	   JOIN company c ON c.ID_comp = t.ID_comp
       GROUP BY pt.trip_no, c.name, date, time_out, time_in ) x
GROUP BY name;











-- SELECT ID_comp, date,
-- 		SUM(timediff)
-- FROM 		(SELECT pt.trip_no, ID_comp, date, time_out, time_in,
-- 			        CASE WHEN time_out > time_in THEN TIMESTAMPDIFF(minute,time_out,time_in) * -1
-- 					 ELSE TIMESTAMPDIFF(minute,time_out,time_in) 
-- 					 END as timediff
-- 			FROM pass_in_trip pt 
-- 			JOIN trip t ON t.trip_no=pt.trip_no 
-- 			GROUP BY pt.trip_no, ID_comp, date, time_out, time_in
--             ) x
-- GROUP BY ID_comp, date;