TABLE_NAME
-----------------
REGIONS
LOCATIONS
DEPARTMENTS
JOBS
EMPLOYEES
JOB_HISTORY
COUNTRIES

Setup:

GRANT CREATE ANY EDITION, DROP ANY EDITION to HR;


ALTER USER HR ENABLE EDITIONS;

GRANT USE ON EDITION ORA$BASE TO HR;

grant sysdba to hr;

SELECT SYS_CONTEXT('USERENV', 'CURRENT_EDITION_NAME') FROM DUAL;




Program test:
=================

CREATE OR REPLACE PROCEDURE say_hello
IS
l_edition VARCHAR2(30);
BEGIN
SELECT SYS_CONTEXT('USERENV', 'CURRENT_EDITION_NAME')
INTO l_edition
FROM DUAL;
DBMS_OUTPUT.PUT_LINE('Chennai hackathon. This is from '||l_edition);
END;
/

set serveroutput on

exec say_hello


CREATE EDITION hack AS CHILD OF ora$base;

ALTER SESSION SET EDITION = hack;

SELECT SYS_CONTEXT('USERENV', 'CURRENT_EDITION_NAME') FROM DUAL;

set serveroutput on
exec say_hello

Now we change the code for this procedure in the child edition
----------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE say_hello
IS
l_edition VARCHAR2(30);
BEGIN
SELECT SYS_CONTEXT('USERENV', 'CURRENT_EDITION_NAME')
INTO l_edition
FROM DUAL;
DBMS_OUTPUT.PUT_LINE('Hello from hackathon. This code is changed. current edition is '||l_edition||'.');
END;
/

set serveroutput on
exec say_hello




