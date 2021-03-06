alter session set current_schema=hr;

CREATE EDITION R2;

ALTER SESSION SET EDITION = R2;

SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;

ALTER TABLE employees_tab ADD (
  TITLE   VARCHAR2(20)
);


CREATE OR REPLACE EDITIONING VIEW v_employees AS
SELECT employee_id,
       name,
       SEX,
       TITLE
FROM   employees_tab;

INSERT INTO V_EMPLOYEES (EMPLOYEE_ID,NAME,SEX , TITLE) VALUES(1003, 'RAJ KUMAR', 'M', 'CONSULTANT');
INSERT INTO V_EMPLOYEES (EMPLOYEE_ID,NAME,SEX, TITLE) VALUES(1004, 'SELVA RANI', 'F','SNR. CONSULTANT');

alter database default edition=r2;