-- Weather Observation Station 18

SELECT Abs(ROUND((MIN(LAT_N) + MIN(LONG_W)) - (MAX(LAT_N) + MAX(LONG_W)),4))
FROM STATION