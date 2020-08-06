/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   IDCLIENTE            int                  not null,
   NOMBRESCLIENTE       varchar(50)          null,
   APELLIDOSCLIENTE     varchar(50)          null,
   IDENTIFICACIONCLIENTE varchar(20)          null,
   GENERO               varchar(20)          null,
   TELEFONOCONVENCIONAL varchar(50)          null,
   TELEFONOMOVIL        varchar(50)          null,
   EMAILCLIENTE         varchar(30)          null,
   TIPO_LICENCIACONDUCIR varchar(4)           null,
   CUENTA_SEGUROMEDICO  boolean                  null,
   constraint PK_CLIENTE primary key (IDCLIENTE)
)

/*==============================================================*/
/* Table: MARCAVEHICULO                                         */
/*==============================================================*/
create table MARCAVEHICULO (
   IDMARCA              int                  not null,
   DESCRIPCIONMARCA     varchar(25)          null,
   constraint PK_MARCAVEHICULO primary key (IDMARCA)
)

/*==============================================================*/
/* Table: VEHICULO                                              */
/*==============================================================*/
create table VEHICULO (
   IDVEHICULO           int                  not null,
   IDMARCA              int                  null,
   PRECIO_DIARIO        numeric(5,2)         null,
   PLACA_VEHICULO       varchar(20)          null,
   FECHA_ULTIMAREVISION date             null,
   FECHA_ULTIMOALQUILER date             null,
   constraint PK_VEHICULO primary key (IDVEHICULO)
)

/*==============================================================*/
/* Table: ALQUILERVEHICULO                                      */
/*==============================================================*/
create table ALQUILERVEHICULO (
   IDVEHICULO           int                  not null,
   IDCLIENTE            int                  not null,
   FECHASALIDA_VEHICULO date             not null,
   OBSERVACIONSALIDA_VEHICULO varchar(100)         null,
   FECHARECEPCION_VEHICULO date             null,
   OBSERVACIONRECEPCION_VEHICULO varchar(100)         null,
   CALIFICACIONCLIENTEAEMPRESA smallint             null,
   OBSERVACIONCALIFICACIONCLIENTEAEMPRESA varchar(100)         null,
   CALIFICACIONEMPRESACLIENTE smallint             null,
   OBSERVACIONCALIFICACIONEMPRESACLIENTE varchar(100)         null,
   constraint PK_ALQUILERVEHICULO primary key (IDVEHICULO, IDCLIENTE, FECHASALIDA_VEHICULO)
)