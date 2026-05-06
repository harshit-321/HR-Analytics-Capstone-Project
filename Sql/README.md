# 🗄️ HR Analytics SQL Queries

## 📌 Overview
This folder contains all SQL queries used in the HR Analytics Capstone Project.  
The queries are written in PostgreSQL and are used to extract, analyze, and transform HR data for dashboard creation.

---

## 🛠️ Database Used
- PostgreSQL

---

## 📂 File Included
- `hr_queries.sql` → Contains all queries including table creation, data import, KPI calculations, and analysis queries

---

## 🧱 Table Structure

The dataset is stored in a table named `hrdata` with the following key columns:

- Employee ID (`emp_no`)
- Gender
- Age & Age Band
- Department
- Education & Education Field
- Job Role
- Attrition Status
- Job Satisfaction
- Employee Count

---

## 📊 SQL Query Categories

### 🔹 1. Data Setup
- Table creation
- Data import using `COPY` command

---

### 🔹 2. KPI Queries
- Total Employee Count  
- Attrition Count  
- Attrition Rate (%)  
- Active Employees  
- Average Age  

---

### 🔹 3. Analytical Queries
- Attrition by Gender  
- Department-wise Attrition  
- Employee Count by Age  
- Education Field-wise Attrition  
- Attrition by Age Group & Gender  

---

### 🔹 4. Advanced Analysis
- Job Satisfaction analysis using `CROSSTAB()` function  

---

## 🔍 Sample Query

```sql
SELECT department, COUNT(*) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY attrition_count DESC;
```

---

## 🚀 How to Run

1. Create table using provided SQL  
2. Import dataset using `COPY` command  
3. Execute queries step-by-step in PostgreSQL  

---

## 📌 Key Insights Generated

- Identified departments with highest attrition  
- Analyzed attrition trends across age groups  
- Evaluated job satisfaction across roles  
- Provided data for dashboard visualizations  

---

## ⚠️ Note
- Update file path in `COPY` command as per your system  
- Ensure PostgreSQL extension `tablefunc` is enabled for crosstab query  

---

## 🎯 Purpose
These SQL queries form the backbone of the data analysis process and support dashboard creation in Power BI, Tableau, and Excel.

