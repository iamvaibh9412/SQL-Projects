--- 1. Calculate the number of employees in each department.

SELECT department as Department, COUNT(emp_no) as no_of_emp FROM AnalyzingEmployeeTrends
GROUP by department
Order by no_of_emp DESC;

--- Inference 1:
--- The R&D department has the highest number of employees (961), followed by Sales (446), while HR has the fewest (63). 
--- This indicates that the company places a strong emphasis on research and product development, with comparatively fewer resources allocated to administrative functions.

--- 2. Calcualte the average age for each department.

SELECT department, ROUND(AVG(age)) as average_age FROM AnalyzingEmployeeTrends
GROUP BY department
order by average_age DESC;

--- Inference 2:
--- The HR department has the highest average employee age (38), slightly above Sales and R&D (both at 37). 
--- This suggests that HR roles may require more experience or attract more seasoned professionals compared to other departments.

--- 3. Identify the most common job roles in each department

SELECT department as Department, job_role aS JOB_ROLE, COUNT(emp_no) AS EMP_NO 
FROM AnalyzingEmployeeTrends
GROUP BY department, job_role
ORDER BY department,EMP_NO DESC;

--- Inference 3:
--- The most common job role in the Sales department is Sales Executive (326 employees), while in R&D, Research Scientist (292 employees) and Laboratory Technician (259 employees) are the leading roles.
--- In HR, the Human Resources role dominates (52 employees). This distribution reflects the organization's focus on research-intensive roles and front-line sales positions.

--- 4. Calculate the average job satisfaction for each education level

SELECT education as Education_Level, round(avg(job_satisfaction),2) as Average_Satisfaction
FROM AnalyzingEmployeeTrends
GROUP by education;

--- Inference 4:
--- Inference:
--- Employees with a High School education report the highest average job satisfaction (2.80), followed closely by those with a Master's Degree (2.79) and an Associate’s Degree (2.77).
--- Surprisingly, Bachelor’s and Doctoral degree holders have slightly lower satisfaction levels, which may suggest that higher educational attainment does not necessarily equate to greater job fulfillment within the organization.\

--- 5.Determine the average age for employees with different levels of job satisfaction

SELECT job_satisfaction AS SATISFACTION_LEVEL, round(avg(age),2) AS AVG_AGE
FROM AnalyzingEmployeeTrends
GROUP BY job_satisfaction
ORDER BY AVG_AGE desc;

--- Inference 5:
--- Employees with higher job satisfaction levels (e.g., level 3 and 4) tend to have a slightly lower or similar average age (~36.8–37.0 years) compared to those with moderate satisfaction.
--- This suggests that age may not be a significant factor influencing job satisfaction, as satisfaction appears relatively consistent across age groups.


--- 6. Identify the age band with the highest average job satisfaction among married employees

WITH DepartmentSatisfaction AS (
    SELECT department, ROUND(AVG(job_satisfaction), 2) AS avg_satisfaction
    FROM AnalyzingEmployeeTrends
    GROUP BY department
)
SELECT * FROM DepartmentSatisfaction
WHERE avg_satisfaction = (SELECT MAX(avg_satisfaction) FROM DepartmentSatisfaction)
   OR avg_satisfaction = (SELECT MIN(avg_satisfaction) FROM DepartmentSatisfaction);

--- Inference 6:
--- Among all departments, Sales has the highest average job satisfaction (2.75), while HR reports the lowest (2.6). 
--- This may suggest that employees in Sales feel more motivated or rewarded compared to those in HR, possibly due to differences in role dynamics or recognition.

--- 7. Calculate the attrition rate for each age band --
SELECT age_band, 
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AnalyzingEmployeeTrends
GROUP BY age_band;

--- Inference 7:
--- The attrition rate is highest among employees aged Under 25 (39.18%), suggesting that younger employees may be more likely to leave the company, possibly due to career transitions, lack of engagement, or external opportunities.
--- The 25-34 age band has a significant attrition rate (20.22%) as well, which may indicate early career challenges or dissatisfaction. Conversely, older age bands (35-44, 45-54, Over 55) have lower attrition rates, reflecting greater job stability and longer tenure in the organization.

--- 8. Find the age band with the highest attrition rate among employees with a specific education level---
SELECT education, age_band, 
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AnalyzingEmployeeTrends
GROUP BY education, age_band
ORDER BY attrition_rate DESC;

--- Inference 8:
--- For employees with a Bachelor's Degree, the age band 25-34 has the highest attrition rate of 18.75%.
--- For employees with a Master's Degree, the age band 35-44 shows the highest attrition rate of 14.00%.

--- 9.Find the education level with the highest average job satisfaction among employees who travel frequently
SELECT education, 
       ROUND(AVG(job_satisfaction), 2) AS average_job_satisfaction
FROM AnalyzingEmployeeTrends
WHERE business_travel = 'Travel_Frequently'
GROUP BY education
ORDER BY average_job_satisfaction DESC
LIMIT 1;  -- Only selects the education level with the highest average satisfaction
