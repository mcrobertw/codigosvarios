create table CLIENTE (
   IDCLIENTE            INTEGER              not null,
   NOMBRESCLIENTE       VARCHAR2(50)          null,
   APELLIDOSCLIENTE     VARCHAR2(50)          null,
   IDENTIFICACIONCLIENTE VARCHAR2(20)          null,
   GENERO               VARCHAR2(20)          null,
   TELEFONOCONVENCIONAL VARCHAR2(50)          null,
   TELEFONOMOVIL        VARCHAR2(50)          null,
   EMAILCLIENTE         VARCHAR2(30)          null,
   TIPO_LICENCIACONDUCIR VARCHAR2(4)           null,
   CUENTA_SEGUROMEDICO  BOOLEAN                   null,
   constraint PK_CLIENTE primary key (IDCLIENTE)
);
