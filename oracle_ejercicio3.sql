CREATE TABLE DEUDA(
    iddeuda int primary key,
    idcliente int,
    saldo numeric(8,2)
)

insert into deuda(iddeuda,idcliente,saldo) --Insert into multifilas
    SELECT 3,100,50 FROM dual UNION ALL
    SELECT 4,200,-20 FROM dual;

alter table DEUDA
 add constraint CK_deudaenpositivo
 check (saldo>=0);
 
alter table DEUDA drop constraint CK_deudaenpositivo;