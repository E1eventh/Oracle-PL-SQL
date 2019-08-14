CREATE OR REPLACE PACKAGE PKG 
IS
    SUBTYPE t_city IS VARCHAR(10);
    PROCEDURE Sal_cnt (s_in_city IN PKG.t_city);
    PROCEDURE Cust_cnt (c_in_city IN PKG.t_city);
END PKG;
/

CREATE OR REPLACE PACKAGE BODY PKG 
IS
    cnt NUMBER(2);
    
    PROCEDURE Sal_cnt (s_in_city IN PKG.t_city)
    IS
        CURSOR salers (s_in_city IN PKG.t_city)
            IS
                SELECT SNAME
                FROM SAL
                WHERE CITY = s_in_city;
    BEGIN
        cnt := 0;
        FOR SNAME IN salers(s_in_city)
        LOOP
            cnt := cnt + 1;
        END LOOP;
        DBMS_OUTPUT.put_line('There is ' || cnt || ' salers in ' || s_in_city);
    END Sal_cnt;
    
    PROCEDURE Cust_cnt (c_in_city IN PKG.t_city)
    IS
        CURSOR custers (c_in_city IN PKG.t_city)
            IS
                SELECT CNAME
                FROM CUST
                WHERE CITY = c_in_city;
    BEGIN
        cnt := 0;
        FOR SNAME IN custers(c_in_city)
        LOOP
            cnt := cnt + 1;
        END LOOP;
        DBMS_OUTPUT.put_line('There is ' || cnt || ' custers in ' || c_in_city);
    END Cust_cnt;
END PKG;
/  
  
BEGIN
    PKG.Sal_cnt('London');
    PKG.Cust_cnt('Berlin');
END;