drop table if exists DIM_CARRERA;

/*==============================================================*/
/* Table: DIM_CARRERA                                           */
/*==============================================================*/
create table DIM_CARRERA
(
   IDCARRERA            numeric(6,0) not null,
   FACULTAD             varchar(40),
   ESCUELA              varchar(40),
   NOMBRECARRERA        varchar(50),
   NUMNIVELES           numeric(2,0),
   HABILITA             varchar(1),
   primary key (IDCARRERA)
);

drop table if exists DIM_SEMESTRE;

/*==============================================================*/
/* Table: DIM_SEMESTRE                                          */
/*==============================================================*/
create table DIM_SEMESTRE
(
   IDSEMESTRE           numeric(6,0) not null,
   NOMBRE               varchar(15),
   primary key (IDSEMESTRE)
);

drop table if exists DIM_TIEMPO;

/*==============================================================*/
/* Table: DIM_TIEMPO                                            */
/*==============================================================*/
create table DIM_TIEMPO
(
   IDPERIODO            varchar(12) not null,
   FECHA_INICIO         date,
   FECHA_FIN            date,
   NOMBRE               varchar(50),
   primary key (IDPERIODO)
);

drop table if exists HEC_DESERCION;

/*==============================================================*/
/* Table: HEC_DESERCION                                         */
/*==============================================================*/
create table HEC_DESERCION
(
   IDCARRERA            numeric(6,0) not null,
   IDSEMESTRE           numeric(6,0) not null,
   IDPERIODO            varchar(12) not null,
   HECHO                smallint,
   primary key (IDCARRERA, IDSEMESTRE, IDPERIODO)
);

alter table HEC_DESERCION add constraint FK_DIMCARRERA_HEDESERCION foreign key (IDCARRERA)
      references DIM_CARRERA (IDCARRERA) on delete restrict on update restrict;

alter table HEC_DESERCION add constraint FK_DIMSEMESTRE_HEDESERCION foreign key (IDSEMESTRE)
      references DIM_SEMESTRE (IDSEMESTRE) on delete restrict on update restrict;

alter table HEC_DESERCION add constraint FK_DIMTIEMPOHEDESERCION foreign key (IDPERIODO)
      references DIM_TIEMPO (IDPERIODO) on delete restrict on update restrict;
