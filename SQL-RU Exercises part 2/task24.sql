-- Exercise: 39 (Serge I: 2003-02-14)
-- Find the ships that `survived for future battles`; that is, after being damaged in a battle, they participated in another one, which occurred later.

SELECT DISTINCT dmg.ship
FROM
	(SELECT ship,battle,result,date FROM outcomes o 
	JOIN battles b ON o.battle = b.name 
	WHERE result = 'damaged') 
	as dmg
JOIN   
	(SELECT ship,battle,result,date FROM outcomes o 
	JOIN battles b ON o.battle = b.name) 
	as ok

ON dmg.ship = ok.ship

WHERE dmg.date < ok.date