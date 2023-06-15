SELECT * FROM company;
SELECT * FROM pass_in_trip;
SELECT * FROM passenger;
SELECT * FROM Trip;

SELECT ID_psg, COUNT(DISTINCT city) as visited
FROM  (SELECT trip_no, town_from as city, ID_psg FROM (
			SELECT p.trip_no, t.town_from, t.town_to, p.ID_psg,
					ROW_NUMBER() OVER (PARTITION BY p.ID_psg, t.town_from, t.town_to  ORDER BY p.trip_no) as rn
			FROM Trip t 
			JOIN pass_in_trip p ON t.trip_no = p.trip_no ) x
		WHERE rn = 1
		union
		SELECT trip_no, town_to as city, ID_psg FROM (
			SELECT p.trip_no, t.town_from, t.town_to, p.ID_psg,
					ROW_NUMBER() OVER (PARTITION BY p.ID_psg, t.town_from, t.town_to  ORDER BY p.trip_no) as rn
			FROM Trip t 
			JOIN pass_in_trip p ON t.trip_no = p.trip_no ) x
		WHERE rn = 1 ) y
GROUP BY ID_psg 

-- SQL RU solution below -----------------------------------

with summary as (SELECT ID_psg, COUNT(DISTINCT city) as visited
				 FROM  (SELECT trip_no, town_from as city, ID_psg 
						FROM (SELECT p.trip_no, t.town_from, t.town_to, p.ID_psg,
								ROW_NUMBER() OVER (PARTITION BY p.ID_psg, t.town_from, t.town_to  ORDER BY p.trip_no) as rn
							  FROM Trip t 
						JOIN pass_in_trip p ON t.trip_no = p.trip_no ) x
						WHERE rn = 1
							union
						SELECT trip_no, town_to as city, ID_psg FROM (
							SELECT p.trip_no, t.town_from, t.town_to, p.ID_psg,
									ROW_NUMBER() OVER (PARTITION BY p.ID_psg, t.town_from, t.town_to  ORDER BY p.trip_no) as rn
							FROM Trip t 
							JOIN pass_in_trip p ON t.trip_no = p.trip_no ) x
						WHERE rn = 1 ) y
				GROUP BY ID_psg)

SELECT p.name FROM summary s
JOIN passenger p ON s.ID_psg = p.ID_psg
WHERE visited = (SELECT MAX(visited) FROM summary)
