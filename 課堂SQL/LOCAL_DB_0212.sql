SELECT STORE_NAME FROM STORE_INFORMATION;

SELECT STORE_ID, STORE_NAME FROM STORE_INFORMATION;

SELECT STORE_ID, STORE_DATE, STORE_NAME FROM STORE_INFORMATION;

SELECT * FROM STORE_INFORMATION;

SELECT DISTINCT STORE_NAME FROM STORE_INFORMATION;

-- 依整列資料為去重覆
-- DISTINCT只能下一次，而且要在欄位的最前面
SELECT DISTINCT STORE_ID, STORE_NAME FROM STORE_INFORMATION;

SELECT STORE_ID, STORE_NAME FROM STORE_INFORMATION;


SELECT STORE_ID, STORE_NAME, SALES
FROM STORE_INFORMATION
WHERE SALES >= 1500;


-- "且"AND "嚴僅" 查的資料愈少
-- "或"OR  "寬鬆" 查的資料愈多
-- 2,4,5,6
SELECT STORE_ID, STORE_NAME, SALES
FROM STORE_INFORMATION
WHERE SALES > 1000
OR (SALES > 270 AND SALES < 500);


SELECT * 
FROM STORE_INFORMATION
WHERE STORE_ID = 3 
OR STORE_ID = 4
OR STORE_ID = 5;


SELECT * 
FROM STORE_INFORMATION
WHERE STORE_ID IN (3, 4, 5);

SELECT * 
FROM STORE_INFORMATION
WHERE STORE_ID >= 3 AND STORE_ID <= 5;


-- 文字類型欄位"區分小大寫"(依照不同資料庫有所不同限制)
-- 文字類型欄位須上單引號
SELECT * FROM STORE_INFORMATION
WHERE STORE_NAME IN ('Los Angeles', 'San Diego');


-- 運用一個範圍(range) 內抓出資料庫中的值
SELECT * 
FROM STORE_INFORMATION
WHERE STORE_ID BETWEEN 3 AND 5;







