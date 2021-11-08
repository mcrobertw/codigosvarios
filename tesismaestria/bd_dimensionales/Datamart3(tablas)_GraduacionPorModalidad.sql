drop table if exists DIM_MODALIDAD;

/*==============================================================*/
/* Table: DIM_MODALIDAD                                         */
/*==============================================================*/
create table DIM_MODALIDAD
(
   IDMODALIDAD          numeric(6,0) not null,
   NOMBRE               varchar(50),
   primary key (IDMODALIDAD)
);

drop table if exists DIM_TIEMPO;

/*==============================================================*/
/* Table: DIM_TIEMPO                                            */
/*==============================================================*/
create table DIM_TIEMPO
(
   IDTIEMPO             varchar(12) not null,
   FECHA                date,
   DIA                  smallint,
   MES                  smallint,
   ANIO                 smallint,
   primary key (IDTIEMPO)
);

drop table if exists HEC_GRADUACION;

/*==============================================================*/
/* Table: HEC_GRADUACION                                        */
/*==============================================================*/
create table HEC_GRADUACION
(
   IDMODALIDAD          numeric(6,0) not null,
   IDTIEMPO             varchar(12) not null,
   HECHO                smallint,
   primary key (IDMODALIDAD, IDTIEMPO)
);

alter table HEC_GRADUACION add constraint FK_DIMMODALIDAD_HECGRADUACION foreign key (IDMODALIDAD)
      references DIM_MODALIDAD (IDMODALIDAD) on delete restrict on update restrict;

alter table HEC_GRADUACION add constraint FK_DIMTIEMPO_HECGRADUACION foreign key (IDTIEMPO)
      references DIM_TIEMPO (IDTIEMPO) on delete restrict on update restrict;
