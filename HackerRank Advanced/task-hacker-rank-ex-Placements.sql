with merged_info as (
                        SELECT s.id, s.name, p.salary
                        FROM students s
                        JOIN packages p ON s.id = p.id )

SELECT s.name
FROM friends f
JOIN merged_info s ON f.id = s.id --student salary here
JOIN merged_info fr ON fr.id = f.friend_id --friend salary here
WHERE fr.salary > s.salary
ORDER BY fr.salary