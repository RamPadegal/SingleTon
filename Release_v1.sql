alter session set current_schema=hr;

CREATE EDITION R1;

ALTER SESSION SET EDITION = r1;

SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;


CREATE TABLE employees_tab (
  employee_id   NUMBER(5)    NOT NULL,
  name          VARCHAR2(40) NOT NULL,
  SEX 		CHAR(1)      NOT NULL,
  CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

CREATE OR REPLACE EDITIONING VIEW v_employees AS
SELECT employee_id,
       name,
       SEX
FROM   employees_tab;

INSERT INTO V_EMPLOYEES (EMPLOYEE_ID,NAME,SEX) VALUES(1001, 'RAJASH KUMAR', 'M');
INSERT INTO V_EMPLOYEES (EMPLOYEE_ID,NAME,SEX) VALUES(1002, 'RANI MA', 'F');

alter database default edition=r1;