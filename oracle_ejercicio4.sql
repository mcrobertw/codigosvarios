CREATE TABLE DEUDA(
    iddeuda int primary key,
    idcliente int,
    saldo numeric(8,2)
)

insert into deuda(iddeuda,idcliente,saldo) --Insert into multifilas
    SELECT 1,100,50 FROM dual UNION ALL
    SELECT 2,200,-20 FROM dual;

create or replace trigger tr_controlsaldo
before
insert on deuda
for each row
declare
    excep exception;
BEGIN
    if (:new.saldo>0)  then
        raise excep;
    end if;
    exception
    when excep then
    RAISE_APPLICATION_ERROR(-20002, 'Valor inadmisible');
END;

insert into deuda(iddeuda,idcliente,saldo) --Insert into multifilas
    SELECT 3,100,50 FROM dual UNION ALL
    SELECT 4,200,-20 FROM dual;
