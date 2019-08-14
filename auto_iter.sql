CREATE OR REPLACE TRIGGER up
BEFORE INSERT 
    ON SAL
    FOR EACH ROW
DECLARE
    t_num NUMBER(4);
    temp NUMBER(4);
BEGIN
    SELECT MIN(SNUM) INTO t_num FROM SAL;
    t_num := t_num + 1;
    
    LOOP
        SELECT SNUM INTO temp FROM SAL WHERE SNUM = t_num;
        t_num := t_num + 1;
    END LOOP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            :new.SNUM := t_num;
END;

SELECT * FROM SAL;

INSERT INTO SAL(SNAME, CITY, COMM)
  VALUES ('Zeus', 'Olymp', .99);