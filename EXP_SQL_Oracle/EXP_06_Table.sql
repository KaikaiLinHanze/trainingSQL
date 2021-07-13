﻿DROP TABLE BOOK_CUSTOMER_ORDER;
DROP TABLE COFFEE_CUSTOMER_ORDER;
DROP TABLE MRT_TRANSIT_TRAFFIC;
DROP TABLE CUSTOMER;
DROP TABLE AMAZON_INC;
DROP TABLE STARBUCKS_INC;

-- 顧客資料表
CREATE TABLE CUSTOMER 
(
  CUS_IDENTIFIER_ID VARCHAR2(10 CHAR) PRIMARY KEY
, CUS_NAME VARCHAR2(50 CHAR) 
, CUS_SEX VARCHAR2(10 CHAR) 
, CUS_AGE VARCHAR2(10 CHAR) 
, CUS_PHONE_ENUMBER VARCHAR2(20 BYTE) 
, IS_DIFFICULT_CUS CHAR(1 CHAR) 
);
COMMENT ON COLUMN CUSTOMER.CUS_IDENTIFIER_ID IS '顧客身份證字號';
COMMENT ON COLUMN CUSTOMER.CUS_NAME IS '顧客姓名';
COMMENT ON COLUMN CUSTOMER.CUS_SEX IS '顧客姓別';
COMMENT ON COLUMN CUSTOMER.CUS_AGE IS '顧客姓名';
COMMENT ON COLUMN CUSTOMER.CUS_PHONE_ENUMBER IS '顧客手機號碼';
COMMENT ON COLUMN CUSTOMER.IS_DIFFICULT_CUS IS '奧客(1:是、0:否)';

-- 捷運轉運流量
CREATE TABLE MRT_TRANSIT_TRAFFIC
(
	STATION_ID VARCHAR2(10 CHAR)
	,STATION_NAME VARCHAR2(50 CHAR)
	,STATION_LINE VARCHAR2(50 CHAR)
	,STATION_DEPARTURE_TIME TIMESTAMP(6)
	,TRAFFIC_PEOPLE_QUANTITY NUMBER(10,0)
	, CONSTRAINT MRT_TRANSIT_TRAFFIC_PK PRIMARY KEY (STATION_ID, STATION_DEPARTURE_TIME)
);

COMMENT ON COLUMN MRT_TRANSIT_TRAFFIC.STATION_ID IS '車站編號';
COMMENT ON COLUMN MRT_TRANSIT_TRAFFIC.STATION_NAME IS '車站名稱';
COMMENT ON COLUMN MRT_TRANSIT_TRAFFIC.STATION_LINE IS '車站路線';
COMMENT ON COLUMN MRT_TRANSIT_TRAFFIC.STATION_DEPARTURE_TIME IS '發車時間';
COMMENT ON COLUMN MRT_TRANSIT_TRAFFIC.TRAFFIC_PEOPLE_QUANTITY IS '轉運人數流量';


-- 星巴客公司
CREATE TABLE STARBUCKS_INC
(
	 STORE_ID VARCHAR2(20 CHAR) PRIMARY KEY
	,STORE_NAME VARCHAR2(100 CHAR)
	,STORE_ADDR VARCHAR2(100 CHAR)	
	,STORE_TYPE VARCHAR2(100 CHAR)
	,STORE_MRT VARCHAR2(100 CHAR)
);

COMMENT ON COLUMN STARBUCKS_INC.STORE_ID IS '門市編號';
COMMENT ON COLUMN STARBUCKS_INC.STORE_NAME IS '門市名稱';
COMMENT ON COLUMN STARBUCKS_INC.STORE_ADDR IS '門市地址';
COMMENT ON COLUMN STARBUCKS_INC.STORE_MRT IS '門市捷運站點';
COMMENT ON COLUMN STARBUCKS_INC.STORE_TYPE IS '門市型態';

-- 阿馬龍公司
CREATE TABLE AMAZON_INC
(
	 STORE_ID VARCHAR2(20 CHAR) PRIMARY KEY
	,STORE_NAME VARCHAR2(100 CHAR)
	,STORE_ADDR VARCHAR2(100 CHAR)
	,STORE_BOOK_SALE_TYPE VARCHAR2(100 CHAR)
	,STORE_MRT VARCHAR2(100 CHAR)
);

COMMENT ON COLUMN AMAZON_INC.STORE_ID IS '書店編號';
COMMENT ON COLUMN AMAZON_INC.STORE_NAME IS '書店名稱';
COMMENT ON COLUMN AMAZON_INC.STORE_ADDR IS '書店地址';
COMMENT ON COLUMN AMAZON_INC.STORE_MRT IS '書店捷運站點';
COMMENT ON COLUMN AMAZON_INC.STORE_BOOK_SALE_TYPE IS '販售書籍類型';


-- 咖啡顧額訂單
CREATE TABLE COFFEE_CUSTOMER_ORDER
(
	 ORDER_NO VARCHAR2(20 CHAR) PRIMARY KEY
	,ORDER_DATE TIMESTAMP(6) 
	,ORDER_AMOUNT NUMBER(10,0)
	,BUY_GOODS_TYPE VARCHAR2(20 CHAR)
	,CUS_IDENTIFIER_ID VARCHAR2(10 CHAR) REFERENCES CUSTOMER(CUS_IDENTIFIER_ID)
	,COFFEE_STORE_ID VARCHAR2(20 CHAR) REFERENCES STARBUCKS_INC(STORE_ID) 
);

COMMENT ON COLUMN COFFEE_CUSTOMER_ORDER.ORDER_NO IS '訂單編號';
COMMENT ON COLUMN COFFEE_CUSTOMER_ORDER.ORDER_DATE IS '購買日期';
COMMENT ON COLUMN COFFEE_CUSTOMER_ORDER.ORDER_AMOUNT IS '購買金額';
COMMENT ON COLUMN COFFEE_CUSTOMER_ORDER.BUY_GOODS_TYPE IS '購買商品種類';
COMMENT ON COLUMN COFFEE_CUSTOMER_ORDER.CUS_IDENTIFIER_ID IS '顧客身份證字號';
COMMENT ON COLUMN COFFEE_CUSTOMER_ORDER.COFFEE_STORE_ID IS '門市編號';



-- 書籍顧額訂單
CREATE TABLE BOOK_CUSTOMER_ORDER
(
	 ORDER_NO VARCHAR2(20 CHAR) PRIMARY KEY
	,ORDER_DATE TIMESTAMP(6) 
	,ORDER_AMOUNT NUMBER(10,0)
	,BUY_BOOK_TYPE VARCHAR2(20 CHAR)
	,CUS_IDENTIFIER_ID VARCHAR2(10 CHAR) REFERENCES CUSTOMER(CUS_IDENTIFIER_ID)
	,BOOK_STORE_ID VARCHAR2(20 CHAR) REFERENCES AMAZON_INC(STORE_ID) 
);

COMMENT ON COLUMN BOOK_CUSTOMER_ORDER.ORDER_NO IS '訂單編號';
COMMENT ON COLUMN BOOK_CUSTOMER_ORDER.ORDER_DATE IS '購買日期';
COMMENT ON COLUMN BOOK_CUSTOMER_ORDER.ORDER_AMOUNT IS '購買金額';
COMMENT ON COLUMN BOOK_CUSTOMER_ORDER.BUY_BOOK_TYPE IS '購買書籍種類';
COMMENT ON COLUMN BOOK_CUSTOMER_ORDER.CUS_IDENTIFIER_ID IS '顧客身份證字號';
COMMENT ON COLUMN BOOK_CUSTOMER_ORDER.BOOK_STORE_ID IS '書店編號';