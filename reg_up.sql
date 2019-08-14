DROP TABLE reg;

CREATE TABLE reg
    (OPERATION VARCHAR2(20),
    USERNAME VARCHAR2(20),
    DATE_TIME VARCHAR2(30));
    
CREATE OR REPLACE TRIGGER reg_up
AFTER INSERT OR DELETE OR UPDATE 
    ON cust
    FOR EACH ROW
DECLARE
    t_user VARCHAR2(20);
    t_date VARCHAR2(30);
BEGIN
    IF :new.CITY = 'Rome' THEN
        RAISE_APPLICATION_ERROR(-20001,  'Продавец из Рима');
    END IF;
    SELECT USER INTO t_user
        FROM dual;
    SELECT TO_CHAR(SYSDATE,  'DD-MM-YYYY HH24:MI:SS') INTO t_date
        FROM DUAL;
    IF INSERTING THEN
        INSERT INTO reg
            (OPERATION,
             USERNAME,
             DATE_TIME)
        VALUES
            ('INSERT',
            t_user,
            t_date);
    END IF;
    
    IF DELETING THEN
        INSERT INTO reg
            (OPERATION,
             USERNAME,
             DATE_TIME)
        VALUES
            ('DELETE',
            t_user,
            t_date);
    END IF;
    
    IF UPDATING THEN
        INSERT INTO reg
            (OPERATION,
             USERNAME,
             DATE_TIME)
        VALUES
            ('UPDATE',
            t_user,
            t_date);
    END IF;
END;

INSERT INTO cust
  VALUES (1997, 'Clemens', 'London', 100, 1001);

DELETE FROM cust
    WHERE CNUM = 1997;
    
INSERT INTO cust
  VALUES (1997, 'Clemens', 'Rome', 100, 1001);
 
SELECT * FROM reg;