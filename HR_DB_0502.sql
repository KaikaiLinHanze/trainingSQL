--查詢所有部門資訊如下：
--1.所在地(國家、洲省、城市)
--2.部門(部門編號、部門名稱)
--3.部門管理者(員工編號、員工姓名、員工職稱)

-- Step1:找出欄位所在的資料表
-- LOCATIONS(COUNTRY_ID,STATE_PROVINCE,CITY)
-- DEPARTMENTS(DEPARTMENT_ID,DEPARTMENT_NAME)
-- EMPLOYEES(EMPLOYEE_ID,FIRST_NAME,JOB_ID)
-- JOBS(JOB_TITLE)

-- Step2:找出資料表與資料表的相關聯的欄位
-- LOCATIONS(LOCATION_ID)DEPARTMENTS
-- DEPARTMENTS(MANAGER_ID,EMPLOYEE_ID)EMPLOYEES
-- EMPLOYEES(JOB_ID)JOBS

-- Step3:透過Step1,Step2撰寫SQL
SELECT L.COUNTRY_ID, L.STATE_PROVINCE, L.CITY,
D.DEPARTMENT_ID, D.DEPARTMENT_NAME,
NVL(E.EMPLOYEE_ID, 100), E.FIRST_NAME,
J.JOB_TITLE
FROM DEPARTMENTS D 
INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;


