DROP TABLE SAL;
DROP TABLE CUST;
DROP TABLE ORD;

create table SAL
  (SNUM number(4),
   SNAME varchar2(10) NOT NULL,
   CITY  varchar2(10) NOT NULL,
   COMM  number(7,2) NOT NULL);
   
create table CUST
  (CNUM number(4),
   CNAME varchar2(10) NOT NULL,
   CITY  varchar2(10) NOT NULL,
   RATING number(3) NOT NULL,
   SNUM number(4));
   
create table ORD
  (ONUM number(4),
   AMT  number(7,2) NOT NULL,
   ODATE date NOT NULL,
   CNUM number(4),
   SNUM number(4));
   
INSERT INTO SAL
  VALUES (1001, 'Peel', 'London', .12);
INSERT INTO SAL
  VALUES (1002, 'Serres', 'San Jose', .13);
INSERT INTO SAL
  VALUES (1004, 'Motica', 'London', .11);
INSERT INTO SAL
  VALUES (1007, 'Rifkin', 'Barcelona', .15);
INSERT INTO SAL
  VALUES (1003, 'Axelrod', 'New York', .10);
  
INSERT INTO CUST
  VALUES (2001, 'Hoffman', 'London', 100, 1001);
INSERT INTO CUST
  VALUES (2002, 'Giovanni', 'Rome', 200, 1003);
INSERT INTO CUST
  VALUES (2003, 'Liu', 'San Jose', 200, 1002);
INSERT INTO CUST
  VALUES (2004, 'Grass', 'Berlin', 300, 1002);
INSERT INTO CUST
  VALUES (2006, 'Clemens', 'London', 100, 1001);
INSERT INTO CUST
  VALUES (2008, 'Cisneros', 'San Jose', 300, 1007);
INSERT INTO CUST
  VALUES (2007, 'Pereira', 'Rome', 100, 1004);
  
INSERT INTO ORD
  VALUES (3001, 18.69,   to_date('03.01.2006','dd.mm.yyyy'), 2008, 1007);
INSERT INTO ORD
  VALUES (3003, 767.19,  to_date('03.01.2006','dd.mm.yyyy'), 2001, 1001);
INSERT INTO ORD
  VALUES (3002, 1900.10, to_date('03.01.2006','dd.mm.yyyy'), 2007, 1004);
INSERT INTO ORD
  VALUES (3005, 5160.45, to_date('03.01.2006','dd.mm.yyyy'), 2003, 1002);
INSERT INTO ORD
  VALUES (3006, 1098.16, to_date('03.01.2006','dd.mm.yyyy'), 2008, 1007);
INSERT INTO ORD
  VALUES (3009, 1713.23, to_date('04.01.2006','dd.mm.yyyy'), 2002, 1003);
INSERT INTO ORD
  VALUES (3007, 75.75,   to_date('04.01.2006','dd.mm.yyyy'), 2004, 1002);
INSERT INTO ORD
  VALUES (3008, 4723.00, to_date('05.01.2006','dd.mm.yyyy'), 2006, 1001);
INSERT INTO ORD
  VALUES (3010, 1309.95, to_date('06.01.2006','dd.mm.yyyy'), 2004, 1002);
INSERT INTO ORD
  VALUES (3011, 9891.88, to_date('06.01.2006','dd.mm.yyyy'), 2006, 1001);