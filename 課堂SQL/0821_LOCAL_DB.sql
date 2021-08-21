-- 子查詢 Sub Query (個數無限制)
SELECT * FROM STORE_INFORMATION
WHERE SALES = 3000;

-- 商店最高的營業額
SELECT MAX(SALES) FROM STORE_INFORMATION;

-- 查詢"最高營業額"的商店資料
-- 簡單子查詢
SELECT * FROM STORE_INFORMATION
WHERE SALES = (
	SELECT MAX(SALES) FROM STORE_INFORMATION
);

-- 關聯式的子查詢
-- 外查詢
SELECT S.* FROM STORE_INFORMATION S
WHERE GEOGRAPHY_ID IN (
	-- 內查詢
    SELECT GEOGRAPHY_ID FROM GEOGRAPHY G
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
);

-- 可把子查詢視為一個"暫存資料表"的概念
-- 1.查詢與查詢之間，彼此互相獨立(各查各的)不互相影響
-- 2.最後可再將所有的子查詢結果，再做join連接"整合"最終想要的查詢結果
SELECT G.*, S.* 
FROM (
	SELECT * FROM STORE_INFORMATION
) S, 
(
	SELECT * FROM GEOGRAPHY
) G
WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


SELECT G.*, S.* 
FROM (
	SELECT * FROM STORE_INFORMATION
) S
INNER JOIN
(
	SELECT * FROM GEOGRAPHY
) G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;


-- 簡單子查詢(Simple Subquery)
-- 查詢與查詢之間彼此獨立"不能互相使用對方的欄位"
SELECT G.*, S.* 
FROM (
   SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G , 
(
   SELECT STORE.GEOGRAPHY_ID, STORE.STORE_NAME
   FROM STORE_INFORMATION STORE, G
   WHERE G.GEOGRAPHY_ID = STORE.GEOGRAPHY_ID
) S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- WITH (Common Table Expressions)
WITH G AS (
  SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
)  ,
S AS (
  SELECT GEOGRAPHY_ID, STORE_NAME FROM STORE_INFORMATION
)
SELECT  *  FROM G, S 
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- 查詢與查詢之間可以相互使用欄位做關聯式查詢
WITH G AS (
  SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) ,
S AS (
  SELECT STORE.GEOGRAPHY_ID, STORE.STORE_NAME 
  FROM STORE_INFORMATION STORE, G
  WHERE G.GEOGRAPHY_ID = STORE.GEOGRAPHY_ID
)
SELECT  G.*, S.*  FROM G, S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;



-- HR DB 資料查詢
-- 查詢每個部門"高於","平均部門薪資"的員工
-- (結果依部門平均薪資降冪排序)
-- Step1:
-- EMPLOYEES(EMPLOYEE_ID,FIRST_NAME,SALARY)
-- DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME)

-- Step2:
-- EMPLOYEES(DEPARTMENT_ID)DEPARTMENTS

-- Step3:
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,	
	D.DEPARTMENT_NAME,
	DEP_EMP.AVG_DEP	
FROM (
	-- 1.先計算"平均部門薪資"
	SELECT DEPARTMENT_ID , FLOOR(AVG(SALARY)) "AVG_DEP" 
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
) DEP_EMP, EMPLOYEES E, DEPARTMENTS D
-- 2.篩選出"高於"平均部門薪資的員工
WHERE DEP_EMP.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY > DEP_EMP.AVG_DEP
-- 結果依部門平均薪資"降冪"排序
ORDER BY DEP_EMP.AVG_DEP DESC, E.SALARY DESC;


WITH DEP_EMP AS (
	-- 1.先計算"平均部門薪資"
	SELECT DEPARTMENT_ID , FLOOR(AVG(SALARY)) "AVG_DEP" 
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
),
EMP AS (
	SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
    FROM EMPLOYEES E, DEP_EMP
    WHERE DEP_EMP.DEPARTMENT_ID = E.DEPARTMENT_ID
    -- 2.篩選出"高於"平均部門薪資的員工
	-- 運用CTE的功能使用上面查詢的暫存表的資料來做過濾資料限縮
    AND E.SALARY > DEP_EMP.AVG_DEP
)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID,	
	D.DEPARTMENT_NAME,
	DEP_EMP.AVG_DEP	
FROM DEP_EMP, EMP E, DEPARTMENTS D
WHERE DEP_EMP.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
-- 結果依部門平均薪資"降冪"排序
ORDER BY DEP_EMP.AVG_DEP DESC, E.SALARY DESC;


-- CHAR(9 BYTE)"固定長度"字串資料型別
-- 資料不足則會補上空白
-- VARCHAR 可變長度字串資料型別

-- 資料表的資料欄位的限制
--  1.NOT NULL 不能為空值
--  2.UNIQUE "唯一鍵" 唯一值 (UNIQUE 限制是保證一個欄位中的所有資料都是不一樣的值)，值可以是NULL
--  3.CHECK (保證一個欄位中的所有資料都是符合某些條件)
--    GOODS_PRICE NUMBER(10) CHECK (GOODS_PRICE > 100)
--  4.主鍵 (Primary Key) 有UNIQUE特性，值必須獨一無二，不能是NULL
--    STORE_ID   NUMERIC (10,0) PRIMARY KEY
--    主鍵可以包含一或多個欄位。當主鍵包含多個欄位時，稱為"組合鍵" (Composite Key),複合式主鍵
--  5.外來鍵 (Foreign Key)
--   參考完整性(referential integrity)
--   父檔:顧客資料表，子檔:訂單資料表
--  一般公司為了效能考量,並不會真的去設置FK欄位限制!
-- 	5.1:子項列再建資料時找不到相對應的父項編號
-- 	Cannot add or update a child row: a foreign key constraint fails
-- 	5.2:再刪除父項資料列之前，必須沒有任何的子項資料
-- 	Cannot delete or update a parent row: a foreign key constraint fails

-- Oracle
CREATE TABLE TABLE1 (
  COLUMN1 VARCHAR2(20),
  COLUMN2 VARCHAR2(20),
  CONSTRAINT TABLE1_PK PRIMARY KEY (COLUMN1 , COLUMN2)
);

-- MS SQL、My SQL
CREATE TABLE TABLE1 (
  COLUMN1 VARCHAR(20),
  COLUMN2 VARCHAR(20),
  CONSTRAINT TABLE1_PK PRIMARY KEY (COLUMN1 , COLUMN2)
);


CREATE TABLE GEOGRAPHY (  
	GEOGRAPHY_ID NUMERIC (10,0) PRIMARY KEY,
	REGION_NAME  VARCHAR(255)
);

CREATE TABLE STORE_INFORMATION (
	STORE_ID   NUMERIC (10,0) PRIMARY KEY,
	STORE_NAME VARCHAR(255),
	SALES      NUMERIC (10,0) CHECK (SALES > 0),
	STORE_DATE datetime,
-- 	GEOGRAPHY_ID NUMERIC(10,0) REFERENCES GEOGRAPHY(GEOGRAPHY_ID)
 	GEOGRAPHY_ID NUMERIC (10,0),
 	CONSTRAINT CONSTRAINT_GEOGRAPHY_ID FOREIGN KEY (GEOGRAPHY_ID) REFERENCES GEOGRAPHY (GEOGRAPHY_ID)
);


-- 1.One to One 一對一關係
-- A資料表中的單筆資料記錄同時只能對應到B資料表的一筆記錄
--  Duplicate entry '110' for key 'state.GOV_SDID'
-- https://dataedo.com/kb/tools/mysql-workbench/create-database-diagram

-- 政府官員州長
CREATE TABLE Gov(
    GID NUMERIC(3) PRIMARY KEY,
    Name VARCHAR(25),
    Address VARCHAR(30),
    TermBegin date,
    TermEnd date
);

-- 州
-- REFERENCES(參照)、CONSTRAINT(限制)、UNIQUE(唯一)
CREATE TABLE State(
    SID NUMERIC(3) PRIMARY KEY,
    StateName VARCHAR(15),
    Population NUMERIC(10),
    SGID NUMERIC(4) REFERENCES Gov(GID),
    CONSTRAINT GOV_SDID UNIQUE (SGID)
);

INSERT INTO Gov (GID, Name, Address, TermBegin, TERMEND) VALUES (110, 'Bob', '123 Any St', '2009-01-01', '2011-12-31');
INSERT INTO State (SID, StateName, Population, SGID) VALUES (111, 'Virginia', 2000000, 110);


-- 2.One to Many 一對多關係
-- A資料表中的單筆資料記錄同時可以對應到B資料表的多筆記錄
-- 例如一間供用商可同時有多個商品，但一個商品只能屬於一間供應商

-- 供應商
CREATE TABLE Vendor(
    VendorNUMERIC NUMERIC(4) PRIMARY KEY,
    Name VARCHAR(20),
    Address VARCHAR(200),
    City VARCHAR(15),
    Street VARCHAR(200),
    ZipCode VARCHAR(10),
    PhoneNUMERIC VARCHAR(12),
    Status VARCHAR(50)
);

-- 商品清單
CREATE TABLE Inventory(
    Item VARCHAR(50) PRIMARY KEY,
    Description VARCHAR(300),
    CurrentQuantity NUMERIC(4) NOT NULL,
 	VendorNUMERIC NUMERIC(4),
 	CONSTRAINT CONSTRAINT_Vendor_ID FOREIGN KEY (VendorNUMERIC) REFERENCES Vendor (VendorNUMERIC)
);

INSERT INTO Vendor (VENDORNUMERIC, NAME, ADDRESS, CITY, STREET, ZIPCODE, PHONENUMERIC, STATUS) VALUES ('1', 'Apple Inc', '大同區承德路一段1號1樓', '台北市', '承德路', '10351', '02 7743 8068', '營運中');
INSERT INTO Inventory (ITEM, DESCRIPTION, CURRENTQUANTITY, VENDORNUMERIC) VALUES ('iPhone 7 Plus', 'iPhone 7 Plus 5.5吋手機 32GB(原廠包裝盒+原廠配件)', '10', '1');


-- Many to Many 多對多關係
-- A資料表中的多筆資料記錄同時可以對應到B資料表的多筆記錄
-- 例如一位學生可以選擇多門課，一門課也可以同時被多位學生選擇

-- 課程科目
CREATE TABLE Class(
    ClassID VARCHAR(20) PRIMARY KEY,
    ClassName VARCHAR(300),
    Instructor VARCHAR(100)
);

-- 學生
CREATE TABLE Student(
    StudentID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Major VARCHAR(100),
    ClassYear VARCHAR(50)
);

--
-- UNIQUE (StudentID, ClassID)
-- 表示一位學生只能選擇同樣的課程一次不得重覆
CREATE TABLE ClassStudent_Relation(
    StudentID VARCHAR(20) NOT NULL,
    ClassID VARCHAR(20) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    UNIQUE (StudentID, ClassID)
);

INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('1', '國文', '朱媽');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('2', '數學', '凡清');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('3', '英文', '高國華');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('4', '理化', '阿飛');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('5', '物理', '簡杰');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('6', '歷史', '呂杰');
INSERT INTO Class (ClassID, ClassNAME, INSTRUCTOR) VALUES ('7', '地理', '王剛');

INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('1', '馬小九', '資訊管理', '大二');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('2', '輸真慘', '資訊工程', '大一');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('3', '菜英蚊', '企業管理', '大三');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('4', '豬利輪', '財務金融', '大二');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('5', '韓國魚', '應用外語', '碩二');
INSERT INTO Student (StudentID, NAME, MAJOR, ClassYEAR) VALUES ('6', '賣臺銘', '國際貿易', '大一');

INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('1', '1');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('1', '3');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('2', '1');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('3', '1');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('3', '2');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('3', '5');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('5', '6');
INSERT INTO ClassStudent_Relation (StudentID, ClassID) VALUES ('6', '6');






