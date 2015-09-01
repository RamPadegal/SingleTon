create or replace procedure get_count
is
i_count number(10):=0;
begin
loop
select count(*) into i_count from hr.v_test;
DBMS_OUTPUT.PUT_LINE('Hello from hackathon.  current row count is ' || to_char(i_count) ||'.' );
end loop;
end;
/


i_count number(10) :=0;

l_edition VARCHAR2(30);
BEGIN

SELECT SYS_CONTEXT('USERENV', 'CURRENT_EDITION_NAME')
INTO l_edition
FROM DUAL;
DBMS_OUTPUT.PUT_LINE('Hello from hackathon. This code is changed. current edition is '||l_edition||'.');