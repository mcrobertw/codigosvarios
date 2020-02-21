
create table CLIENTE (
   IDCLIENTE            int                  not null,
   NOMBRESC             varchar(50)          null,
   APELLIDOSC           varchar(50)          null,
   TELEFONOMOVILC       varchar(25)          null,
   constraint PK_CLIENTE primary key nonclustered (IDCLIENTE)
)

create table MASCOTA (
   IDMASCOTA            int                  not null,
   IDCLIENTE            int                  null,
   NOMBRE               varchar(50)          null,
   FECHANACIMIENTO      datetime             null,
   RAZA                 varchar(50)          null,
   OBSERVACIONES        varchar(50)          null,
   constraint PK_MASCOTA primary key nonclustered (IDMASCOTA)
)