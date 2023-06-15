-- Exercise: 88 (Serge I: 2003-04-29)
-- Among those flying with a single airline find the names of different passengers who have flown most often.
-- Result set: passenger name, number of trips, and airline name.


with cte as (SELECT DISTINCT ID_comp, ID_psg, count(p.trip_no) as qty
	     FROM trip t
	     JOIN pass_in_trip p on t.trip_no = p.trip_no
	     GROUP BY ID_comp, ID_psg
	     )

SELECT DISTINCT p.name, cte.qty, c.name as Company FROM cte
JOIN company c ON cte.ID_comp = c.ID_comp
JOIN passenger p ON cte.ID_psg = p.ID_psg
WHERE qty = (SELECT MAX(qty) FROM cte);

-- 1 WRONG RECORD IN THE SECOND CHECKING DATABASE !
