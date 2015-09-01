alter session set current_schema=hr;

CREATE EDITION R3;


SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;

ALTER SESSION SET EDITION=R3;

ALTER TABLE employees_tab ADD (
  first_name VARCHAR2(20),
  last_name  VARCHAR2(20)
);


CREATE OR REPLACE EDITIONING VIEW v_employees AS
SELECT employee_id,
       first_name,
       last_name,
       SEX,
       TITLE
FROM   employees_tab;

UPDATE employees_tab
SET    first_name = SUBSTR(name, 1, INSTR(name, ' ')-1),
       last_name  = SUBSTR(name, INSTR(name, ' ')+1)
WHERE  first_name IS NULL;

ALTER TABLE employees_tab MODIFY (
  first_name VARCHAR2(20) NOT NULL,
  last_name  VARCHAR2(20) NOT NULL
);



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


INSERT INTO V_EMPLOYEES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME,SEX , TITLE) VALUES(1005, 'RAVI','KUMAR', 'M', 'ANALYST');
INSERT INTO V_EMPLOYEES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME,SEX , TITLE) VALUES(1006, 'UMA','SELVAN', 'F','ANALYST');

alter database default edition=r3;