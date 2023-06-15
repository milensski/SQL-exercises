-- https://leetcode.com/problems/department-top-three-salaries/
-- 185. Department Top Three Salaries

SELECT dep_name Department , emp_name Employee , salary Salary 
FROM (
        SELECT e.id e_id, e.name emp_name, e.salary salary, d.name dep_name,
                DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) rn
        FROM employee e
        JOIN department d ON d.id = e.departmentId ) as x
WHERE rn <= 3