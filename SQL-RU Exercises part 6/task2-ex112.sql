-- Exercise: 112 (Serge I: 2003-12-24)
-- What maximal number of black squares could be colored white using the remaining paint?

SELECT CASE WHEN COUNT(*) = 3 then MIN(t1.tot_rest) ELSE 0 END
    FROM
        (SELECT SUM(t.rest) / 255 tot_rest FROM
             (SELECT V_ID, 
                V_COLOR, 
                 COALESCE(255-SUM(B_VOL), 255) rest 
       FROM utV LEFT JOIN utB ON utV.V_ID = utB.B_V_ID 
       GROUP BY V_ID, V_COLOR) t 

    GROUP BY t.v_color) t1
