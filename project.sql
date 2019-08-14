DROP TABLE BREEDS;
DROP TABLE CLUBS;
DROP TABLE REG;
DROP TABLE MAX_HEADS;

CREATE TABLE CLUBS
	(CNAME VARCHAR2(20),
	FDATA DATE NOT NULL,
	RES VARCHAR2(20) NOT NULL);

CREATE TABLE BREEDS
	(TITLE VARCHAR2(30) NOT NULL,
	CNAME VARCHAR2(20));

CREATE TABLE reg
	(BREED VARCHAR2(20),
	OLD_CLUB VARCHAR2(20),
	NEW_CLUB VARCHAR2(20));

CREATE TABLE MAX_HEADS
	(CLUB VARCHAR2(30),
	HEAD NUMBER);

ALTER TABLE CLUBS
	ADD (CONSTRAINT clubs_pk_cname PRIMARY KEY (CNAME));

ALTER TABLE BREEDS
	ADD (CONSTRAINT breeds_fk_cname FOREIGN KEY (cname)
		REFERENCES clubs(cname)
		ON DELETE CASCADE);
		
CREATE OR REPLACE TRIGGER changed
BEFORE UPDATE
	ON BREEDS
	FOR EACH ROW
DECLARE
	r_breed VARCHAR2(30) := :old.title;
	r_oclub VARCHAR2(20) := :old.cname;
	r_nclub VARCHAR2(20) := :new.cname;
BEGIN
	INSERT INTO reg
	VALUES (r_breed, r_oclub, r_nclub);
END;
/

CREATE OR REPLACE VIEW request AS
	SELECT a.CNAME, a.RES, b.TITLE
	FROM CLUBS a, BREEDS b
	WHERE a.RES <> 'London' AND a.CNAME = b.CNAME;
	
GRANT SELECT
	ON request
	TO PUBLIC;
	
GRANT UPDATE
	ON BREEDS
	TO UP1;
	
CREATE OR REPLACE PACKAGE FILLING
IS
	PROCEDURE fill_tables;
	PROCEDURE clear_tables;
END FILLING;
/

CREATE OR REPLACE PACKAGE BODY FILLING
IS
	PROCEDURE fill_tables
	IS
	BEGIN
		INSERT INTO CLUBS
			VALUES ('Hunting', to_date('03.01.2006','dd.mm.yyyy'), 'London');
		INSERT INTO CLUBS
			VALUES ('Terrier', to_date('12.11.2010','dd.mm.yyyy'), 'Rome');
		INSERT INTO CLUBS
			VALUES ('Decorative', to_date('11.03.2004','dd.mm.yyyy'), 'Moscow');
		INSERT INTO CLUBS
			VALUES ('Spitz', to_date('07.06.2006','dd.mm.yyyy'), 'New York');
		INSERT INTO CLUBS
			VALUES ('Retriever', to_date('11.11.2011','dd.mm.yyyy'), 'Liverpool');
		INSERT INTO BREEDS
			VALUES ('Hounds', 'Hunting');
		INSERT INTO BREEDS
			VALUES ('Greyhounds', 'Hunting');
		INSERT INTO BREEDS
			VALUES ('Australian Terrier', 'Terrier');
		INSERT INTO BREEDS
			VALUES ('Border terrier', 'Terrier');
		INSERT INTO BREEDS
			VALUES ('Sky terrier', 'Terrier');
		INSERT INTO BREEDS
			VALUES ('Poodle', 'Decorative');
		INSERT INTO BREEDS
			VALUES ('Chihuahua', 'Decorative');
		--INSERT INTO BREEDS
		--	VALUES ('Pekingese', 'Decorative');
		INSERT INTO BREEDS
			VALUES ('Pug', 'Decorative');
		INSERT INTO BREEDS
			VALUES ('Wolfspitz', 'Spitz');
		INSERT INTO BREEDS
			VALUES ('Japanese spitz', 'Spitz');
		INSERT INTO BREEDS
			VALUES ('Labrador', 'Retriever');
		INSERT INTO BREEDS
			VALUES ('Golden retriever', 'Retriever');
		INSERT INTO BREEDS
			VALUES ('Flat-coated retriever', 'Retriever');
		COMMIT;
	END fill_tables;
	
	PROCEDURE clear_tables
	IS
	BEGIN
		DELETE FROM CLUBS;
		DELETE FROM BREEDS;
		COMMIT;
	END clear_tables;
END FILLING;
/

CREATE OR REPLACE PACKAGE CH_PKG
IS
	SUBTYPE titles IS VARCHAR(30);
	PROCEDURE up_club(breed IN CH_PKG.titles, club IN CH_PKG.titles);
	PROCEDURE count_head;
END CH_PKG;
/

CREATE OR REPLACE PACKAGE BODY CH_PKG
AS
	PROCEDURE up_club(breed IN CH_PKG.titles, club IN CH_PKG.titles)
	IS
		up VARCHAR2(100) := 'UPDATE BREEDS SET CNAME = ';
		temp VARCHAR2(30);
		nclub VARCHAR2(30);
		same_clubs EXCEPTION;
	BEGIN
		FILLING.clear_tables;
		FILLING.fill_tables;
		SELECT CNAME INTO temp FROM CLUBS WHERE CNAME = club;
		SELECT CNAME INTO nclub FROM BREEDS WHERE TITLE = breed;
		SELECT TITLE INTO temp FROM BREEDS WHERE TITLE = breed;
		up := up || chr(39) || club || chr(39) || ' WHERE TITLE = ' || chr(39) || breed || chr(39);
		EXECUTE IMMEDIATE up;
		IF club = nclub THEN
			RAISE same_clubs;
		ELSE
			COMMIT;
		END IF;
		EXCEPTION
			WHEN no_data_found THEN
				raise_application_error (-20001,'Запись не найдена');
			WHEN same_clubs THEN
				ROLLBACK;
				raise_application_error (-20001,'Порода уже состоит в этом клубе');
	END up_club;
	
	PROCEDURE count_head
	IS
		CURSOR counter
		IS
			SELECT CNAME, COUNT(title)
				FROM BREEDS
				GROUP BY CNAME
				ORDER BY COUNT(title) DESC;
		heads NUMBER;
		temp NUMBER := 0;
		club VARCHAR(30);
	BEGIN
		DELETE FROM MAX_HEADS;
		OPEN counter;
		LOOP
			FETCH counter INTO club, heads;
			IF(heads >= temp) THEN
				temp := heads;
			INSERT INTO MAX_HEADS
				VALUES(club, heads);
			ELSE
				EXIT;
			END IF;
		END LOOP;
		CLOSE counter;
	END count_head;
END CH_PKG;
/ 

--------------------------------------------------------------------------------
        
BEGIN
    FILLING.clear_tables;
    FILLING.fill_tables;
END;

SELECT * FROM BREEDS;
SELECT * FROM reg;

UPDATE BREEDS
    SET CNAME = 'Hunting'
    WHERE TITLE = 'Wolfspitz';

UPDATE BREEDS
    SET CNAME = 'Spitz'
    WHERE TITLE = 'Wolfspitz';
    
SELECT * FROM request;     

BEGIN
    CH_PKG.up_club('Wolfspitz', 'Hunting');
END;

GRANT SELECT
    ON request
    TO PUBLIC;
    
GRANT UPDATE
    ON BREEDS
    TO UP1;