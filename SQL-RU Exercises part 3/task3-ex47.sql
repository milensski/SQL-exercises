-- Exercise: 47 (Serge I: 2019-06-07)
-- Find the countries that have lost all their ships in battles.

with sh as (select c.country, s.name from classes c join ships s on c.class=s.class
union
select c.country, o.ship from outcomes o join classes c on c.class=o.ship), a as (

select country, name, result,CASE 
			WHEN result = 'sunk' THEN 1
			ELSE 0
			END as lost
from sh left join outcomes o on o.ship=sh.name)

SELECT sh.country
FROM sh JOIN a on sh.name = a.name
GROUP BY sh.country
having count(distinct sh.name)=sum(lost)


