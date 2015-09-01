CREATE EDITION RELEASE_V1;

ALTER SESSION SET EDITION = release_v1;

SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;

EDITION
--------------------------------------------------------------------------------
RELEASE_V1

CREATE TABLE employees_tab (
  employee_id   NUMBER(5)    NOT NULL,
  name          VARCHAR2(40) NOT NULL,
  SEX 		CHAR(1)      NOT NULL,
  CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

CREATE OR REPLACE EDITIONING VIEW employees AS
SELECT employee_id,
       name,
       SEX
FROM   employees_tab;

INSERT INTO EMPLOYESS (EMPLOYEE_ID,NAME,SEX) VALUES(1001, 'RAJA', 'M');
INSERT INTO EMPLOYESS (EMPLOYEE_ID,NAME,SEX) VALUES(1002, 'RANI', 'F');


CREATE EDITION RELEASE_V2;

ALTER SESSION SET EDITION = release_v2;

ALTER TABLE employees_tab ADD (
  TITLE   VARCHAR2(20)
);


CREATE OR REPLACE EDITIONING VIEW employees AS
SELECT employee_id,
       name,
       SEX,
       TITLE
FROM   employees_tab;

INSERT INTO EMPLOYESS (EMPLOYEE_ID,NAME,SEX , TITLE) VALUES(1001, 'RAJ', 'M', 'CONSULTANT');
INSERT INTO EMPLOYESS (EMPLOYEE_ID,NAME,SEX, TITLE) VALUES(1002, 'SELVI', 'F','SNR. CONSULTANT');


CREATE EDITION RELEASE_V3;

ALTER SESSION SET EDITION=RELEASE_V3;

ALTER TABLE employees_tab ADD (
  first_name VARCHAR2(20),
  last_name  VARCHAR2(20)
);

UPDATE employees_tab
SET    first_name = SUBSTR(name, 1, INSTR(name, ' ')-1),
       last_name  = SUBSTR(name, INSTR(name, ' ')+1)
WHERE  first_name IS NULL;

ALTER TABLE employees_tab MODIFY (
  first_name VARCHAR2(20) NOT NULL,
  last_name  VARCHAR2(20) NOT NULL
);


CREATE OR REPLACE EDITIONING VIEW employees AS
SELECT employee_id,
       first_name,
       last_name,
       SEX,
       TITLE
FROM   employees_tab;

INSERT INTO EMPLOYESS (EMPLOYEE_ID,FIRST_NAME, LAST_NAME,SEX , TITLE) VALUES(1001, 'RAVI','KUMAR', 'M', 'ANALYST');
INSERT INTO EMPLOYESS (EMPLOYEE_ID,FIRST_NAME, LAST_NAME,SEX , TITLE) VALUES(1002, 'UMA','SELVAN', 'F','ANALYST');


CREATE OR REPLACE TRIGGER employees_fwd_xed_trg
  BEFORE INSERT OR UPDATE ON employees_tab
  FOR EACH ROW
  FORWARD CROSSEDITION
  DISABLE
BEGIN
  :NEW.first_name := SUBSTR(:NEW.name, 1, INSTR(:NEW.name, ' ')-1);
  :NEW.last_name  := SUBSTR(:NEW.name, INSTR(:NEW.name, ' ')+1);
END employees_fwd_xed_trg;
/

CREATE OR REPLACE TRIGGER employees_rvrs_xed_trg
  BEFORE INSERT OR UPDATE ON employees_tab
  FOR EACH ROW
  REVERSE CROSSEDITION
  DISABLE
BEGIN
  :NEW.name := :NEW.first_name || ' ' || :NEW.last_name;
END employees_rvrs_xed_trg;
/

ALTER TRIGGER employees_fwd_xed_trg ENABLE;
ALTER TRIGGER employees_rvrs_xed_trg ENABLE;
