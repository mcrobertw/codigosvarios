create table CUENTA (
   IDCUENTA             int                  not null,
   SALDO                numeric(10,2)        null,
   constraint PK_CUENTA primary key nonclustered (IDCUENTA)
)

ALTER TABLE CUENTA ADD CHECK (SALDO>=0)

create table MOVIMIENTO (
   IDMOVIMIENTO         int                  not null,
   IDCUENTA             int                  null,
   TIPOMOVIMIENTO       varchar(2)           null,
   VALOR                numeric(10,2)        null,
   constraint PK_MOVIMIENTO primary key nonclustered (IDMOVIMIENTO)
)

create table TRANSFERENCIA (
   IDCUENTAORIGEN       int                  null,
   IDCUENTADESTINO      int                  null,
   IMPORTE              numeric(10,2)        null
)

alter table MOVIMIENTO
   add constraint FK_MOVIMIEN_FK3_CUENTA foreign key (IDCUENTA)
      references CUENTA (IDCUENTA)


alter table TRANSFERENCIA
   add constraint FK_cuentadestino_CUENTA foreign key (IDCUENTADESTINO)
      references CUENTA (IDCUENTA)

alter table TRANSFERENCIA
   add constraint FK_cuentaorigen_CUENTA foreign key (IDCUENTAORIGEN)
      references CUENTA (IDCUENTA)