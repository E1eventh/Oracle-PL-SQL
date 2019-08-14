DROP TABLE TAB;

CREATE TABLE TAB
    (TNUM NUMBER,
    TNAME VARCHAR2(20));
    
INSERT INTO TAB
    VALUES (1, 'LORD');
INSERT INTO TAB
    VALUES (2, 'DIMASIK');
INSERT INTO TAB
    VALUES (3, 'SHUROCHKA');

DECLARE
   drop_tab VARCHAR(20) := 'DROP TABLE ';
BEGIN
    ACCEPT tab_name CHAR PROMPT 'Введите имя таблицы'
    drop_tab := drop_tab || '&tab_name';
    EXECUTE IMMEDIATE drop_tab;
END;
/
SELECT * FROM TAB;
