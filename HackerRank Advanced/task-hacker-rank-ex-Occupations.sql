WITH gen as (SELECT Name,Occupation, row_number() OVER(Partition by occupation order by name) rn
            FROM occupations)
            

SELECT Doctor, Professor, Singer, Actor
FROM gen
PIVOT(

        max(name)
        FOR occupation in (Doctor, Professor, Singer, Actor)

     ) x