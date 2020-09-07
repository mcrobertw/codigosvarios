create table CLIENTE 
(
   IDCLIENTE            INTEGER              not null,
   CEDULACLIENTE        VARCHAR2(10),
   APELLIDOSCLIENTE     VARCHAR2(50),
   NOMBRESCLIENTE       VARCHAR2(50),
   FECHANACIMIENTOCLIENTE        DATE,
   constraint PK_CLIENTE primary key (IDCLIENTE)
);

create table PRESTAMO 
(
   IDPRESTAMO           INTEGER              not null,
   IDCLIENTE            INTEGER,
   FECHAPRESTAMO        DATE,
   TOTALPRESTAMO        NUMBER(10,2),
   OBSERVACIONPRESTAMO  VARCHAR2(100),
   constraint PK_PRESTAMO primary key (IDPRESTAMO)
);

create table PAGO 
(
   IDPAGO               INTEGER              not null,
   IDPRESTAMO           INTEGER,
   FECHAPAGO            DATE,
   VALORPAGO            NUMBER(10,2),
   SALDOPENDIENTEDEUDA  NUMBER(10,2),
   constraint PK_PAGO primary key (IDPAGO)
);

alter table PAGO
   add constraint FK_PAGO_PRESTAMO foreign key (IDPRESTAMO)
      references PRESTAMO (IDPRESTAMO);

alter table PRESTAMO
   add constraint FK_PRESTAMO_CLIENTE foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE);