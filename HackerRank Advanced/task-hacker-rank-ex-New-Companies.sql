/*
company_code, founder name, 
total number of lead managers, 
total number of senior managers, 
total number of managers, and total number of employees. 
Order your output by ascending company_code.
*/
with total_leads as  (
                    SELECT DISTINCT company_code, COUNT(DISTINCT lead_manager_code) lead_count
                    FROM lead_manager
                    GROUP BY company_code),
                    
     total_seniors as (
                    SELECT DISTINCT company_code, count(DISTINCT senior_manager_code) senior_count
                    FROM senior_manager
                    GROUP BY company_code),
    
    total_managers as (
                    SELECT DISTINCT company_code, count(DISTINCT manager_code) manager_count
                    FROM manager
                    GROUP BY company_code),
                    
    total_employees as (
                    SELECT DISTINCT company_code, count(DISTINCT employee_code) employee_count
                    FROM employee
                    GROUP BY company_code)

SELECT 
c.company_code, c.founder, 
    tl.lead_count,
    ts.senior_count,
    tm.manager_count, 
    te.employee_count
FROM company c
JOIN total_leads tl ON c.company_code = tl.company_code
JOIN total_seniors ts ON c.company_code = ts.company_code
JOIN total_managers tm ON c.company_code = tm.company_code
JOIN total_employees te ON c.company_code = te.company_code
-- GROUP BY c.company_code, c.founder
ORDER BY c.company_code ASC
