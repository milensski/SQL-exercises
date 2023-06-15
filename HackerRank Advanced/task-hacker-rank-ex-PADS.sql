/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT CONCAT(name, '(',SUBSTRING(occupation,1,1),')')
FROM OCCUPATIONS
ORDER BY name;
              
SELECT CONCAT('There are a total of', ' ',COUNT(name), ' ', LOWER(occupation),'s.')
FROM OCCUPATIONS
GROUP BY occupation
ORDER BY COUNT(name), CASE WHEN SUBSTRING(occupation,1,1) = 'P' THEN 4
              WHEN SUBSTRING(occupation,1,1) = 'A' THEN 2
              WHEN SUBSTRING(occupation,1,1) = 'S' THEN 3
              WHEN SUBSTRING(occupation,1,1) = 'D' THEN 1
              ELSE 5
              END;