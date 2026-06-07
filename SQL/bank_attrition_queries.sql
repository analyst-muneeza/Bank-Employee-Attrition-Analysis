-- =========================================================
-- BANK EMPLOYEE ATTRITION ANALYSIS USING SQL
-- =========================================================
-- Project Objective:
-- Analyze employee attrition patterns and identify key
-- factors affecting employee retention in the organization.
-- =========================================================


-- =========================================================
-- 1. DATA PREVIEW
-- =========================================================
-- Purpose: To inspect the dataset and verify imported data.

SELECT * 
FROM bank_attrition
LIMIT 5;


-- =========================================================
-- 2. TOTAL EMPLOYEES
-- =========================================================
-- Purpose: To calculate the total number of employees.

SELECT COUNT(*) AS Total_Employees
FROM bank_attrition;


-- =========================================================
-- 3. ATTRITION ANALYSIS
-- =========================================================
-- Purpose: To analyze how many employees left the company.

SELECT Attrition,
       COUNT(*) AS Employee_Count
FROM bank_attrition
GROUP BY Attrition;


-- =========================================================
-- 4. DEPARTMENT-WISE ATTRITION
-- =========================================================
-- Purpose: To identify departments with higher attrition.

SELECT Department,
       COUNT(*) AS Employees_Left
FROM bank_attrition
WHERE Attrition = 1
GROUP BY Department
ORDER BY Employees_Left DESC;


-- =========================================================
-- 5. OVERTIME IMPACT ON ATTRITION
-- =========================================================
-- Purpose: To analyze whether overtime affects attrition.

SELECT OverTime_Flag,
       COUNT(*) AS Attrition_Count
FROM bank_attrition
WHERE Attrition = 1
GROUP BY OverTime_Flag;


-- =========================================================
-- 6. AVERAGE EMPLOYEE SALARY
-- =========================================================
-- Purpose: To calculate average employee income.

SELECT AVG(Income) AS Average_Salary
FROM bank_attrition;


-- =========================================================
-- 7. CITY-WISE EMPLOYEE DISTRIBUTION
-- =========================================================
-- Purpose: To identify employee distribution across cities.

SELECT City,
       COUNT(*) AS Total_Employees
FROM bank_attrition
GROUP BY City
ORDER BY Total_Employees DESC;


-- =========================================================
-- 8. EDUCATION LEVEL ANALYSIS
-- =========================================================
-- Purpose: To analyze employees based on education level.

SELECT Education_Level,
       COUNT(*) AS Employee_Count
FROM bank_attrition
GROUP BY Education_Level
ORDER BY Employee_Count DESC;


-- =========================================================
-- 9. AVERAGE AGE OF EMPLOYEES
-- =========================================================
-- Purpose: To calculate average employee age.

SELECT AVG(Age) AS Average_Age
FROM bank_attrition;


-- =========================================================
-- 10. JOB ROLE ATTRITION ANALYSIS
-- =========================================================
-- Purpose: To identify job roles with higher attrition.

SELECT Joining_Designation,
       COUNT(*) AS Attrition_Count
FROM bank_attrition
WHERE Attrition = 1
GROUP BY Joining_Designation
ORDER BY Attrition_Count DESC;


-- =========================================================
-- 11. MONTHLY ATTRITION TREND
-- =========================================================
-- Purpose: To analyze attrition trends over time.

SELECT MMMM_YY,
       COUNT(*) AS Monthly_Attrition
FROM bank_attrition
WHERE Attrition = 1
GROUP BY MMMM_YY
ORDER BY MMMM_YY;


-- =========================================================
-- 12. TOP EARNING EMPLOYEES
-- =========================================================
-- Purpose: To identify employees with highest income.

SELECT Employee_ID,
       Income
FROM bank_attrition
ORDER BY Income DESC
LIMIT 10;


-- =========================================================
-- 13. ATTRITION RATE BY DEPARTMENT
-- =========================================================
-- Purpose: To calculate attrition percentage for each department.

SELECT Department,
       COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*) AS Attrition_Rate
FROM bank_attrition
GROUP BY Department
ORDER BY Attrition_Rate DESC;


-- =========================================================
-- 14. TOP 5 CITIES WITH HIGHEST ATTRITION
-- =========================================================
-- Purpose: To identify cities facing maximum employee attrition.

SELECT City,
       COUNT(*) AS Attrition_Count
FROM bank_attrition
WHERE Attrition = 1
GROUP BY City
ORDER BY Attrition_Count DESC
LIMIT 5;


-- =========================================================
-- 15. INCOME CATEGORY ANALYSIS
-- =========================================================
-- Purpose: To categorize employees based on salary range.

SELECT 
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Category,
    
    COUNT(*) AS Employee_Count
FROM bank_attrition
GROUP BY Income_Category;


-- =========================================================
-- 16. AVERAGE INCOME BY EDUCATION LEVEL
-- =========================================================
-- Purpose: To compare salaries across education levels.

SELECT Education_Level,
       ROUND(AVG(Income),2) AS Avg_Income
FROM bank_attrition
GROUP BY Education_Level
ORDER BY Avg_Income DESC;


-- =========================================================
-- 17. ATTRITION TREND BY AGE GROUP
-- =========================================================
-- Purpose: To identify which age groups have higher attrition.

SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '45+'
    END AS Age_Group,

    COUNT(*) AS Attrition_Count
FROM bank_attrition
WHERE Attrition = 1
GROUP BY Age_Group
ORDER BY Attrition_Count DESC;


-- =========================================================
-- 18. RANK EMPLOYEES BY SALARY
-- =========================================================
-- Purpose: To rank employees based on income.

SELECT Employee_ID,
       Income,
       RANK() OVER(ORDER BY Income DESC) AS Salary_Rank
FROM bank_attrition
LIMIT 10;


-- =========================================================
-- 19. RUNNING TOTAL OF EMPLOYEES BY MONTH
-- =========================================================
-- Purpose: To analyze cumulative employee records over time.

SELECT MMMM_YY,
       COUNT(*) AS Monthly_Count,
       
       SUM(COUNT(*)) OVER(ORDER BY MMMM_YY) AS Running_Total
FROM bank_attrition
GROUP BY MMMM_YY;


-- =========================================================
-- 20. EMPLOYEES EARNING ABOVE AVERAGE SALARY
-- =========================================================
-- Purpose: To identify employees earning more than average income.

SELECT Employee_ID,
       Income
FROM bank_attrition
WHERE Income > (
    SELECT AVG(Income)
    FROM bank_attrition
)
ORDER BY Income DESC;


-- =========================================================
-- CONCLUSION
-- =========================================================

-- The SQL analysis revealed important insights related to
-- employee attrition within the organization.

-- Key Findings:
-- • Certain departments experienced higher attrition rates.
-- • Employees working overtime showed a greater tendency to leave.
-- • Attrition was more common among specific age groups and job roles.
-- • Salary and education level also influenced employee retention.
-- • Monthly trend analysis helped identify periods with increased attrition.

-- Overall, this analysis can help organizations improve
-- employee retention strategies, optimize workforce planning,
-- and make data-driven HR decisions.