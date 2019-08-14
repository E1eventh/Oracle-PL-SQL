CREATE OR REPLACE FUNCTION cash
    (o_num NUMBER) 
    RETURN VARCHAR2 
    IS 
        c_cash VARCHAR2(100);
        o_amt NUMBER(7, 2);
    BEGIN
        SELECT AMT INTO o_amt FROM ORD WHERE ONUM = o_num;
        c_cash := FLOOR(o_amt);
        
        IF (SUBSTR(c_cash, LENGTH(c_cash)) = 1) THEN
            c_cash := c_cash || '  рубль';
        ELSIF (SUBSTR(c_cash, LENGTH(c_cash)) = 2 OR 
                SUBSTR(c_cash, LENGTH(c_cash)) = 3 OR
                SUBSTR(c_cash, LENGTH(c_cash)) = 4) THEN
            c_cash := c_cash || '  рубля';
        ELSE
            c_cash := c_cash || '  рублей';
        END IF;
        
        c_cash := c_cash || ' ' || SUBSTR(o_amt, LENGTH(o_amt) - 1);
        
        IF (SUBSTR(c_cash, LENGTH(c_cash)) = 1) THEN
            c_cash := c_cash || '  копейка';
        ELSIF (SUBSTR(c_cash, LENGTH(c_cash)) = 2 OR 
                SUBSTR(c_cash, LENGTH(c_cash)) = 3 OR
                SUBSTR(c_cash, LENGTH(c_cash)) = 4) THEN
            c_cash := c_cash || '  копейки';
        ELSE
            c_cash := c_cash || '  копеек';
        END IF;
        
        RETURN(c_cash);
    END;
/

BEGIN
    DBMS_OUTPUT.put_line(cash(3011));
    DBMS_OUTPUT.put_line(cash(3010));
    DBMS_OUTPUT.put_line(cash(3009));
END;
/