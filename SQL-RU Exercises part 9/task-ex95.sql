-- Exercise: 95 (qwrqwr: 2013-02-08)
-- Using the Pass_in_Trip table, calculate for each airline:
-- 	1) the number of performed flights;
-- 	2) the number of plane types used;
-- 	3) the number of different passengers that have been transported;
-- 	4) the total number of passengers that have been transported by the company.
-- Output: airline name, 1), 2), 3), 4).

with flights as (SELECT t.ID_comp, COUNT(x.trip_no) as cnt
FROM
	(SELECT DISTINCT *, row_number() OVER(partition by date, trip_no ORDER BY p.trip_no) as rn FROM pass_in_trip p) x
JOIN trip t ON x.trip_no = t.trip_no
WHERE rn = 1
GROUP BY t.ID_comp),
     

planes as (SELECT ID_comp, COUNT(pn) cnt_planes
FROM(
	SELECT t.ID_comp, ROW_NUMBER() OVER(PARTITION BY t.ID_comp, t.plane ORDER BY plane) as pn
	FROM
		(SELECT DISTINCT *, row_number() OVER(partition by date, trip_no ORDER BY p.trip_no) as rn FROM pass_in_trip p) x
	JOIN trip t ON x.trip_no = t.trip_no
	WHERE rn = 1) y
WHERE pn = 1
GROUP BY ID_comp),

diff as (SELECT ID_comp, COUNT(ID_psg) cnt_diff
FROM (
	SELECT t.trip_no, t.ID_comp, x.ID_psg, x.date, row_number() OVER(partition by ID_comp, ID_psg ORDER BY t.trip_no) diff_psg
		FROM
			(SELECT DISTINCT *, row_number() OVER(partition by date, trip_no ORDER BY p.trip_no) as rn FROM pass_in_trip p) x
		JOIN trip t ON x.trip_no = t.trip_no
	) y
WHERE diff_psg = 1
GROUP BY ID_comp),

passangers as (SELECT ID_comp, COUNT(ID_psg) cnt_psg
	FROM
		(SELECT DISTINCT *, row_number() OVER(partition by date, trip_no ORDER BY p.trip_no) as rn FROM pass_in_trip p) x
	JOIN trip t ON x.trip_no = t.trip_no
GROUP BY ID_comp)

SELECT c.name company_name,
       f.cnt as flights,
       p.cnt_planes as planes,
       d.cnt_diff as diff_psngrs,
       ps.cnt_psg as total_psngrs
FROM flights f
JOIN planes p ON p.ID_comp = f.ID_comp
JOIN diff d ON d.ID_comp = f.ID_comp
JOIN passangers ps ON ps.ID_comp = f.ID_comp
JOIN company c ON c.ID_comp = f.ID_comp

