DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER(
 CUSTOMER_ID INT,
 PRODUCT_KEY INT,
 PRIMARY KEY (CUSTOMER_ID,PRODUCT_KEY)
);

DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(
 PRODUCT_KEY INT,
 PRIMARY KEY (PRODUCT_KEY)
);

INSERT INTO CUSTOMER VALUES (1, 5);
INSERT INTO CUSTOMER VALUES (2, 6);
INSERT INTO CUSTOMER VALUES (3, 5);
INSERT INTO CUSTOMER VALUES (3, 6);
INSERT INTO CUSTOMER VALUES (1, 6);
INSERT INTO PRODUCT VALUES (5); 
INSERT INTO PRODUCT VALUES (6);
COMMIT;