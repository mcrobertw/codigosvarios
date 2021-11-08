drop table if exists DIM_TIEMPO;

/*==============================================================*/
/* Table: DIM_TIEMPO                                            */
/*==============================================================*/
create table DIM_TIEMPO
(
   IDPERIODO            numeric(3,0) not null,
   FECHA_INICIO         date,
   FECHA_FIN            date,
   NOMBRE               varchar(50),
   primary key (IDPERIODO)
);

drop table if exists DIM_SEMESTRE;

/*==============================================================*/
/* Table: DIM_SEMESTRE                                          */
/*==============================================================*/
create table DIM_SEMESTRE
(
   IDSEMESTRE           numeric(6,0) not null,
   NOMBRE               varchar(20),
   primary key (IDSEMESTRE)
);

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

drop table if exists DIM_ASIGNATURA;

/*==============================================================*/
/* Table: DIM_ASIGNATURA                                        */
/*==============================================================*/
create table DIM_ASIGNATURA
(
   IDASIGNATURA         numeric(4,0) not null,
   NOMBRE               varchar(50),
   HORAS                numeric(5,2),
   CLASE                varchar(2),
   primary key (IDASIGNATURA)
);


drop table if exists DIM_MOTIVO;

/*==============================================================*/
/* Table: DIM_MOTIVO                                            */
/*==============================================================*/
create table DIM_MOTIVO
(
   IDMOTIVO             numeric(6,0) not null,
   DESCRIPCION          varchar(25),
   primary key (IDMOTIVO)
);

drop table if exists HEC_DESERCION;

/*==============================================================*/
/* Table: HEC_DESERCION                                         */
/*==============================================================*/
create table HEC_DESERCION
(
   IDCARRERA            numeric(6,0) not null,
   IDSEMESTRE           numeric(6,0) not null,
   IDPERIODO            numeric(3,0) not null,
   IDASIGNATURA         numeric(4,0) not null,
   IDMOTIVO             numeric(6,0) not null,
   HECHO                smallint,
   primary key (IDCARRERA, IDSEMESTRE, IDPERIODO, IDASIGNATURA, IDMOTIVO)
);

alter table HEC_DESERCION add constraint FK_DIMASIGNATURA_HEDESERCION foreign key (IDASIGNATURA)
      references DIM_ASIGNATURA (IDASIGNATURA) on delete restrict on update restrict;

alter table HEC_DESERCION add constraint FK_DIMCARRERA_HEDESERCION foreign key (IDCARRERA)
      references DIM_CARRERA (IDCARRERA) on delete restrict on update restrict;

alter table HEC_DESERCION add constraint FK_DIMMOTIVO_HEDESERCION foreign key (IDMOTIVO)
      references DIM_MOTIVO (IDMOTIVO) on delete restrict on update restrict;

alter table HEC_DESERCION add constraint FK_DIMSEMESTRE_HEDESERCION foreign key (IDSEMESTRE)
      references DIM_SEMESTRE (IDSEMESTRE) on delete restrict on update restrict;

alter table HEC_DESERCION add constraint FK_DIMTIEMPOHEDESERCION foreign key (IDPERIODO)
      references DIM_TIEMPO (IDPERIODO) on delete restrict on update restrict;
