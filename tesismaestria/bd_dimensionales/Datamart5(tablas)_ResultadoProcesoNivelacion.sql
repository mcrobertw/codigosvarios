drop table if exists SECCION;

/*==============================================================*/
/* Table: SECCION                                               */
/*==============================================================*/
create table SECCION
(
   IDSECCION            smallint not null,
   NOMBRE               varchar(15),
   primary key (IDSECCION)
);


drop table if exists PARALELO;

/*==============================================================*/
/* Table: PARALELO                                              */
/*==============================================================*/
create table PARALELO
(
   IDPARALELO           varchar(3) not null,
   IDSECCION            smallint,
   NOMBRE               varchar(15),
   primary key (IDPARALELO)
);

alter table PARALELO add constraint FK_SECCION_PARALELO foreign key (IDSECCION)
      references SECCION (IDSECCION) on delete restrict on update restrict;


drop table if exists PERIODO;

/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
create table PERIODO
(
   IDPERIODO            smallint not null,
   ANIO                 smallint,
   SEMESTRE             smallint,
   primary key (IDPERIODO)
);

drop table if exists PLAN_ESTUDIO;

/*==============================================================*/
/* Table: PLAN_ESTUDIO                                          */
/*==============================================================*/
create table PLAN_ESTUDIO
(
   IDPLANESTUDIO        smallint not null,
   NOMBRE               varchar(60),
   primary key (IDPLANESTUDIO)
);


drop table if exists RESULTADO_NIVELACION;

/*==============================================================*/
/* Table: RESULTADO_NIVELACION                                  */
/*==============================================================*/
create table RESULTADO_NIVELACION
(
   IDPARALELO           varchar(3) not null,
   IDPLANESTUDIO        smallint not null,
   IDPERIODO            smallint not null,
   CI                   varchar(10) not null,
   ESTUDIANTE           varchar(75),
   PUNTUACION           decimal(5,2),
   primary key (IDPARALELO, IDPLANESTUDIO, IDPERIODO, CI)
);

alter table RESULTADO_NIVELACION add constraint FK_PARALELO_RESULTADOEVALUACION foreign key (IDPARALELO)
      references PARALELO (IDPARALELO) on delete restrict on update restrict;

alter table RESULTADO_NIVELACION add constraint FK_PERIODO_RESULTADOEVALUACION foreign key (IDPERIODO)
      references PERIODO (IDPERIODO) on delete restrict on update restrict;

alter table RESULTADO_NIVELACION add constraint FK_PLANESTUDIO_RESULTADOEVALUACION foreign key (IDPLANESTUDIO)
      references PLAN_ESTUDIO (IDPLANESTUDIO) on delete restrict on update restrict;
