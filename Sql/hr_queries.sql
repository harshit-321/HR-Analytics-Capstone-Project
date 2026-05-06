-- ============================================
-- HR Analytics SQL Project
-- Author: Harshit Rathi
-- Description: SQL queries for HR Analytics Dashboard
-- ============================================


-- 🔹 1. Create Table
CREATE TABLE hrdata (
    emp_no BIGINT PRIMARY KEY,
    gender VARCHAR(50) NOT NULL,
    marital_status VARCHAR(50),
    age_band VARCHAR(50),
    age BIGINT,
    department VARCHAR(50),
    education VARCHAR(50),
    education_field VARCHAR(50),
    job_role VARCHAR(50),
    business_travel VARCHAR(50),
    employee_count BIGINT,
    attrition VARCHAR(50),
    attrition_label VARCHAR(50),
    job_satisfaction BIGINT,
    active_employee BIGINT
);


-- 🔹 2. Import Data (Update path as per your system)
COPY hrdata 
FROM 'D:\\hrdata.csv' 
DELIMITER ',' 
CSV HEADER;


-- ============================================
-- 📊 KPI QUERIES
-- ============================================

-- 🔹 Total Employee Count
SELECT SUM(employee_count) AS employee_count 
FROM hrdata;


-- 🔹 Attrition Count
SELECT COUNT(*) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes';


-- 🔹 Attrition Rate (%)
SELECT ROUND(
    (
        (SELECT COUNT(*) FROM hrdata WHERE attrition = 'Yes') * 100.0
        / SUM(employee_count)
    ), 2
) AS attrition_rate
FROM hrdata;


-- 🔹 Active Employees
SELECT 
    SUM(employee_count) - 
    (SELECT COUNT(*) FROM hrdata WHERE attrition = 'Yes') 
AS active_employees
FROM hrdata;


-- 🔹 Average Age
SELECT ROUND(AVG(age), 0) AS avg_age
FROM hrdata;


-- ============================================
-- 📊 ANALYSIS QUERIES
-- ============================================

-- 🔹 Attrition by Gender
SELECT 
    gender, 
    COUNT(*) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY gender
ORDER BY attrition_count DESC;


-- 🔹 Department-wise Attrition
SELECT 
    department, 
    COUNT(*) AS attrition_count,
    ROUND(
        COUNT(*) * 100.0 / 
        (SELECT COUNT(*) FROM hrdata WHERE attrition = 'Yes'), 
    2) AS percentage
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY attrition_count DESC;


-- 🔹 Employee Count by Age
SELECT 
    age, 
    SUM(employee_count) AS employee_count
FROM hrdata
GROUP BY age
ORDER BY age;


-- 🔹 Education Field-wise Attrition
SELECT 
    education_field, 
    COUNT(*) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY attrition_count DESC;


-- 🔹 Attrition by Age Group & Gender
SELECT 
    age_band, 
    gender, 
    COUNT(*) AS attrition_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM hrdata WHERE attrition = 'Yes'),
    2) AS percentage
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY age_band, gender DESC;


-- ============================================
-- 📊 JOB SATISFACTION (CROSSTAB)
-- ============================================

-- Enable extension (run once)
CREATE EXTENSION IF NOT EXISTS tablefunc;


-- Crosstab Query
SELECT *
FROM crosstab(
    'SELECT job_role, job_satisfaction, SUM(employee_count)
     FROM hrdata
     GROUP BY job_role, job_satisfaction
     ORDER BY job_role, job_satisfaction'
) AS ct (
    job_role VARCHAR(50),
    rating_1 NUMERIC,
    rating_2 NUMERIC,
    rating_3 NUMERIC,
    rating_4 NUMERIC
)
ORDER BY job_role;
