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

drop table if exists DIM_TIPOOPTATIVAS;

/*==============================================================*/
/* Table: DIM_TIPOOPTATIVAS                                     */
/*==============================================================*/
create table DIM_TIPOOPTATIVAS
(
   IDTIPOMATERIA        varchar(1) not null,
   NOMBRE               varchar(50),
   primary key (IDTIPOMATERIA)
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

drop table if exists DIM_ASIGNATURA;

/*==============================================================*/
/* Table: DIM_ASIGNATURA                                        */
/*==============================================================*/
create table DIM_ASIGNATURA
(
   IDASIGNATURA         numeric(6,0) not null,
   NOMBRE               varchar(50),
   HORAS                numeric(5,2),
   primary key (IDASIGNATURA)
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

drop table if exists HEC_PREFERENCIAS;

/*==============================================================*/
/* Table: HEC_PREFERENCIAS                                      */
/*==============================================================*/
create table HEC_PREFERENCIAS
(
   IDPERIODO            numeric(3,0) not null,
   IDSEMESTRE           numeric(6,0) not null,
   IDASIGNATURA         numeric(6,0) not null,
   IDTIPOMATERIA        varchar(1) not null,
   IDCARRERA            numeric(6,0) not null,
   HECHO                smallint,
   primary key (IDPERIODO, IDSEMESTRE, IDASIGNATURA, IDTIPOMATERIA, IDCARRERA)
);

alter table HEC_PREFERENCIAS add constraint FK_DIMASIGNATURA_HECPREFERENCIAS foreign key (IDASIGNATURA)
      references DIM_ASIGNATURA (IDASIGNATURA) on delete restrict on update restrict;

alter table HEC_PREFERENCIAS add constraint FK_DIMCARRERA_HECPREFERENCIAS foreign key (IDCARRERA)
      references DIM_CARRERA (IDCARRERA) on delete restrict on update restrict;

alter table HEC_PREFERENCIAS add constraint FK_DIMSEMESTRE_HECPREFERENCIAS foreign key (IDSEMESTRE)
      references DIM_SEMESTRE (IDSEMESTRE) on delete restrict on update restrict;

alter table HEC_PREFERENCIAS add constraint FK_DIMTIEMPO_HECPREFERENCIAS foreign key (IDPERIODO)
      references DIM_TIEMPO (IDPERIODO) on delete restrict on update restrict;

alter table HEC_PREFERENCIAS add constraint FK_DIMTIPOOPTATIVA_HECPREFERENCIAS foreign key (IDTIPOMATERIA)
      references DIM_TIPOOPTATIVAS (IDTIPOMATERIA) on delete restrict on update restrict;