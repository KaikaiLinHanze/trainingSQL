SELECT * FROM store_information
ORDER BY STORE_NAME, SALES;

SELECT SUM(SALES)
FROM store_information;

-- 計算各別商店的加總營業額
-- GROUP BY (群組、合併)
-- 依「商品名稱」群組，「營業額」合併加總
-- 群組,"合併"指定函數
SELECT STORE_NAME, SUM(SALES)
FROM store_information
GROUP BY STORE_NAME;

-- TRUNCATE去小數點
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_NAME), TRUNCATE(AVG(SALES),0),
	MAX(SALES), MIN(SALES)
FROM store_information
GROUP BY STORE_NAME;


-- DISTINCT只做資料去重覆
SELECT DISTINCT STORE_NAME
FROM store_information;

-- MySQL
-- 想查尋資料GROUP BY群組合併前的「資料清單」
SELECT STORE_NAME, COUNT(STORE_NAME), SUM(SALES),
	GROUP_CONCAT(SALES ORDER BY SALES SEPARATOR '/')
FROM store_information
GROUP BY STORE_NAME;

-- Oracle
SELECT STORE_NAME, COUNT(STORE_NAME),
  LISTAGG(SALES, '/') WITHIN GROUP (ORDER BY SALES)
FROM store_information
GROUP BY STORE_NAME;


SELECT STORE_NAME, SUM(SALES)
FROM store_information
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000;


-- "雙引號"用在別名
SELECT STORE_NAME AS "商店名稱", SUM(SALES) AS "營業額總合"
FROM store_information
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000;

-- '單引號'用在欄位字串
SELECT STORE_NAME
FROM store_information
WHERE STORE_NAME = 'Boston';

-- AS別名語法可省略
SELECT STORE_NAME "商店名稱", SUM(SALES) AS "營業額總合"
FROM store_information
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000;

-- 別名雙引號可省略(但中間不能有空白)
SELECT STORE_NAME 商店名稱, SUM(SALES) AS "營業額總合"
FROM store_information
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000;

-- 別名雙引號可省略
SELECT STORE_NAME "商店 名稱", SUM(SALES) AS "營業額總合"
FROM store_information
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000;

-- 表格別名不需加雙引號
SELECT STORE.STORE_NAME, STORE.SALES
FROM STORE_INFORMATION STORE;

-- 商店資料 + 區域名稱
-- 商店 * 9
SELECT * FROM STORE_INFORMATION;

-- 區域 * 3
SELECT * FROM GEOGRAPHY;


-- 地區編號來做join資料表連結(等值連接)
SELECT G.GEOGRAPHY_ID, G.REGION_NAME, S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G, STORE_INFORMATION S
-- JOIN 表格連結
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- INNER JOIN 必需搭配 ON 做資料連結
-- INNER 語法可省略
SELECT G.GEOGRAPHY_ID, G.REGION_NAME, S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G INNER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


SELECT G.GEOGRAPHY_ID, G.REGION_NAME, S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G JOIN STORE_INFORMATION S
USING (GEOGRAPHY_ID);

-- 全部的區域都要查詢出來
SELECT G.GEOGRAPHY_ID, G.REGION_NAME, S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 全部的商店都要查詢出來
SELECT G.GEOGRAPHY_ID, G.REGION_NAME, 
	S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G RIGHT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- MySQL 不支援 FULL JOIN
SELECT G.GEOGRAPHY_ID, G.REGION_NAME, 
	S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G FULL JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- 1.左側資料表連接並去除右側資料表的結果
SELECT A.*, B.* 
FROM GEOGRAPHY A LEFT JOIN STORE_INFORMATION B 
ON A.GEOGRAPHY_ID = B.GEOGRAPHY_ID
WHERE B.GEOGRAPHY_ID IS NULL;

-- 2.右側資料表連接並去除左側資料表的結果
SELECT A.*, B.* 
FROM GEOGRAPHY A RIGHT JOIN STORE_INFORMATION B 
ON A.GEOGRAPHY_ID = B.GEOGRAPHY_ID
WHERE A.GEOGRAPHY_ID IS NULL;

-- 3.全連接並去除INNER JOIN的結果
SELECT A.*, B.* 
FROM GEOGRAPHY A 
FULL JOIN STORE_INFORMATION B 
ON A.GEOGRAPHY_ID = B.GEOGRAPHY_ID
WHERE A.GEOGRAPHY_ID IS NULL OR B.GEOGRAPHY_ID IS NULL;


-- INNER JOIN(內部連結)、OUTER JOIN(外部連結) LEFT+RIGHT
SELECT G.GEOGRAPHY_ID, G.REGION_NAME, S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G INNER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

SELECT G.GEOGRAPHY_ID, G.REGION_NAME, S.STORE_ID, S.STORE_NAME, S.SALES
FROM GEOGRAPHY G LEFT OUTER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- SQL UNION 聯集(不包含重覆值)
SELECT G.*, S.* 
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
UNION
SELECT G.*, S.* 
FROM GEOGRAPHY G RIGHT JOIN STORE_INFORMATION S 
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;



-- 計算和統計「個別商店」的以下三項資料：
-- 「總合營業額」、「商店資料個數」、「平均營業額」

-- 搜尋或排除條件如下：
-- 排除「平均營業額」1000(含)以下的商店資料
-- 排除「商店資料個數」1(含)個以下的商店資料
-- 依照「平均營業額」由大至小排序
-- PS:使用別名語法簡化「表格名稱」及查詢結果「欄位名稱」
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_NAME), AVG(SALES)
FROM STORE_INFORMATION
GROUP BY STORE_NAME
HAVING AVG(SALES) > 1000 AND COUNT(STORE_NAME) > 1
ORDER BY AVG(SALES) DESC;


SELECT STORE_NAME, SUM(SALES), COUNT(STORE_NAME) COUNT_STORE, AVG(SALES) AVG_SALES
FROM STORE_INFORMATION
GROUP BY STORE_NAME
HAVING AVG_SALES > 1000 AND COUNT_STORE > 1
ORDER BY AVG_SALES DESC;



-- 查詢各區域的營業額總計
-- 資料結果依營業額總計由大到小排序
-- (不論該區域底下是否有所屬商店)

-- MySQL IFNULL 
SELECT G.REGION_NAME,  IFNULL(SUM(SALES), 0)  SUM_SALES
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY SUM_SALES DESC;

-- Oracle Not Value
SELECT G.REGION_NAME, NVL(SUM(SALES), 0)  SUM_SALES
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY SUM_SALES DESC;


-- 查詢各區域的商店個數
-- 資料結果依區域的商店個數由大至小排序
-- (依據商店名稱,不包含重覆的商店)
-- (不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME, COUNT(DISTINCT STORE_NAME) "COUNT_STORE"
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME
ORDER BY COUNT_STORE DESC;



-- 查詢所有部門資訊如下：
-- 1.所在地(國家、洲省、城市)
-- 2.部門(部門編號、部門名稱)
-- 3.部門管理者(員工編號、員工姓名、員工職稱)

-- Step1:找出所有欄位的資料表
-- 1.所在地(國家、洲省、城市)
-- (LOCATIONS)LOCATION_ID,CITY,STATE_PROVINCE
-- 2.部門(部門編號、部門名稱)
-- (DEPARTMENTS)DEPARTMENT_ID,DEPARTMENT_NAME
-- 3.部門管理者(員工編號、員工姓名、員工職稱)
-- (EMPLOYEES)EMPLOYEE_ID,FIRST_NAME
-- (JOBS)JOB_TITLE

-- Step2:找資料表與資料表之間的關聯欄位
-- LOCATIONS(LOCATION_ID)DEPARTMENTS
-- DEPARTMENTS(MANAGER_ID = EMPLOYEE_ID)EMPLOYEES
-- EMPLOYEES(JOB_ID)JOBS

-- Setp3:寫SQL(所有部門資料共"27"筆)



