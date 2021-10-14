drop table if exists PERSONAL;

/*==============================================================*/
/* Table: PERSONAL                                              */
/*==============================================================*/
create table PERSONAL
(
   IDPERSONAL           numeric(8,0) not null,
   APELLIDO             varchar(35),
   FECHA_NACIMIENTO     date,
   CODIGO_CANTON_NACIMIENTO numeric(10,0),
   IDCANTON             numeric(10,0),
   TIPO_SANGRE          varchar(5),
   SEXO                 varchar(1),
   ESTADO_CIVIL         varchar(1),
   DIRECCION            varchar(50),
   CEDULA               varchar(15),
   NOMBRE               varchar(35),
   FOTO                 varchar(255),
   APELLIDO2            varchar(50),
   MINUSVALIDO          varchar(1),
   PARROQUIA            varchar(100),
   TIPO_DISCAPACIDAD    varchar(100),
   TIPO_PYN             varchar(200),
   PORCENTAJE_DISCAPACIDAD varchar(7),
   EGRESADO             varchar(1),
   IDPARROQUIA          numeric(6,0),
   SECTOR               varchar(100),
   IDPARROQUIA_R        numeric(6,0),
   IDCANTON_R           numeric(6,0),
   TIPO_MOVILIZACION    numeric(6,0),
   ACTUALIZADO          varchar(1),
   REVISADO             varchar(1),
   primary key (IDPERSONAL)
);
drop table if exists CURSOS;

/*==============================================================*/
/* Table: CURSOS                                                */
/*==============================================================*/
create table CURSOS
(
   IDCURSO              numeric(6,0) not null,
   NOMBRE               varchar(25),
   primary key (IDCURSO)
);
drop table if exists FACULTAD;

/*==============================================================*/
/* Table: FACULTAD                                              */
/*==============================================================*/
create table FACULTAD
(
   IDFACULTAD           numeric(6,0) not null,
   NOMBRE               varchar(40),
   ESCUDO               varchar(255),
   EXTENCION            varchar(20),
   AREA_ESTUDIO         varchar(40),
   MODALIDAD            varchar(40),
   SISTEMA              varchar(20),
   primary key (IDFACULTAD)
);

drop table if exists ESCUELA;

/*==============================================================*/
/* Table: ESCUELA                                               */
/*==============================================================*/
create table ESCUELA
(
   IDESCUELA            numeric(6,2) not null,
   IDFACULTAD           numeric(6,0),
   NOMBRE               varchar(40),
   primary key (IDESCUELA)
);

alter table ESCUELA add constraint FK_FK_FACULTAD_ESCUELA foreign key (IDFACULTAD)
      references FACULTAD (IDFACULTAD) on delete restrict on update restrict;

drop table if exists CARRERA;

/*==============================================================*/
/* Table: CARRERA                                               */
/*==============================================================*/
create table CARRERA
(
   IDCARRERA            numeric(6,0) not null,
   IDESCUELA            numeric(6,2),
   NOMBRE               varchar(50),
   NUMNIVELES           numeric(2,0),
   REQUISITO            numeric(2,0),
   MEDIA                numeric(4,2),
   CUPOC                numeric(2,0),
   ACTNBU               varchar(1),
   MEDIA_I              numeric(4,2),
   LUGAR                varchar(40),
   NIVEL_FORMACION      varchar(20),
   SUBAREA              varchar(30),
   MODALIDAD            varchar(20),
   ORGANIZACION_MALLA   varchar(20),
   CODIGO_CARRERA       varchar(7),
   NOMENCLATURA         varchar(10),
   HABILITA             varchar(1),
   primary key (IDCARRERA)
);

alter table CARRERA add constraint FK_FK_ESCUELA_CARRERA foreign key (IDESCUELA)
      references ESCUELA (IDESCUELA) on delete restrict on update restrict;

drop table if exists MATERIAS;

/*==============================================================*/
/* Table: MATERIAS                                              */
/*==============================================================*/
create table MATERIAS
(
   IDMATERIA            numeric(8,2) not null,
   IDCARRERA            numeric(6,0),
   IDCURSO              numeric(6,0),
   NOMBRE               varchar(50),
   TIPO                 numeric(4,1),
   CREDITOS             numeric(5,2),
   HORAS                numeric(5,2),
   TIPO_MATERIA         varchar(1),
   CODIGO               varchar(15),
   VIEJA                varchar(1),
   IDMALLACURRICULAR    numeric(6,0),
   TIPO2                numeric(2,1),
   CLASE                varchar(2),
   CODIGO2              varchar(10),
   IDAREA               varchar(5),
   primary key (IDMATERIA)
);

alter table MATERIAS add constraint FK_FK_CARRERA_MATERIAS foreign key (IDCARRERA)
      references CARRERA (IDCARRERA) on delete restrict on update restrict;

alter table MATERIAS add constraint FK_FK_CURSOS_MATERIAS foreign key (IDCURSO)
      references CURSOS (IDCURSO) on delete restrict on update restrict;

drop table if exists PARCIALES;

/*==============================================================*/
/* Table: PARCIALES                                             */
/*==============================================================*/
create table PARCIALES
(
   IDPARCIAL            numeric(6,0) not null,
   IDCONFIGURACION      numeric(6,0),
   NOMBRE_PARCIAL       varchar(50),
   primary key (IDPARCIAL)
);

drop table if exists PERIODO;

/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
create table PERIODO
(
   IDPERIODO            numeric(6,0) not null,
   IDFACULTAD           numeric(6,0),
   IDCONFIGURACION      numeric(2,0),
   FECHA_INICIO         date,
   FECHA_FINAL          date,
   NOMBRE               varchar(50),
   ESTADO               varchar(1),
   ACTUAL               varchar(1),
   MAXIMO_MATERIA       numeric(2,0),
   FECHA_I_M            date,
   FECHA_F_M            date,
   RIGEN_M              varchar(1),
   RIGEN_N              varchar(1),
   FECHA_R              date,
   FECHA_R2             date,
   IDCUESTIONARIO       numeric(4,0),
   FECHA_I_C            date,
   FECHA_F_C            date,
   MAXIMO_CREDITOS      numeric(2,0),
   CICLO                varchar(15),
   IDPAR                numeric(2,0),
   INDICE_PERIODO       numeric(2,0),
   SUPLETORIO           varchar(1),
   primary key (IDPERIODO)
);

alter table PERIODO add constraint FK_FK_FACULTAD_PERIODO foreign key (IDFACULTAD)
      references FACULTAD (IDFACULTAD) on delete restrict on update restrict;
drop table if exists PARAMETROS;

/*==============================================================*/
/* Table: PARAMETROS                                            */
/*==============================================================*/
create table PARAMETROS
(
   IDPARAMETRO          numeric(6,0) not null,
   IDPARCIAL            numeric(6,0),
   PARAMETRO            varchar(70),
   PORCENTAJE           numeric(5,2),
   primary key (IDPARAMETRO)
);

alter table PARAMETROS add constraint FK_FK_PARCIALES_PARAMETRO foreign key (IDPARCIAL)
      references PARCIALES (IDPARCIAL) on delete restrict on update restrict;

drop table if exists MATRICULA;

/*==============================================================*/
/* Table: MATRICULA                                             */
/*==============================================================*/
create table MATRICULA
(
   IDMATRICULA          numeric(6,0) not null,
   IDPERIODO            numeric(6,0) not null,
   IDPERSONAL           numeric(8,0) not null,
   IDCARRERA            numeric(6,0) not null,
   FOLIO                varchar(8),
   CURSO                numeric(4,0),
   PARALELO             varchar(4),
   FECHA                date,
   PAPELETA             varchar(50),
   ANULADO              varchar(1),
   OBSERVACION          varchar(250),
   IDTIPOMATRICULA      numeric(2,0),
   IDCONCEPTO           numeric(2,0),
   VALORMATRICULA       numeric(10,2),
   IDDESCUENTO          varchar(7),
   PORDESCUENTO         numeric(6,2),
   VALORARANCEL         numeric(10,2),
   VALORTOTAL           numeric(10,2),
   CREDITO              varchar(4),
   ADICIONAL            numeric(6,2),
   PAGO                 numeric(10,2),
   PAGOEX               numeric(10,2),
   CREDITOS_TOMADOS     numeric(6,2),
   CREDITO_APROBADOS    numeric(6,2),
   PROM_S               numeric(10,2),
   CREDITOS_APROBADOS_A numeric(6,2),
   IDMATRICULAUNICO     varchar(10),
   primary key (IDMATRICULA, IDPERIODO, IDPERSONAL, IDCARRERA)
);

alter table MATRICULA add constraint FK_FK_CARRERA_MATRICULA foreign key (IDCARRERA)
      references CARRERA (IDCARRERA) on delete restrict on update restrict;

alter table MATRICULA add constraint FK_FK_PERIODO_MATRICULA foreign key (IDPERIODO)
      references PERIODO (IDPERIODO) on delete restrict on update restrict;

alter table MATRICULA add constraint FK_FK_PERSONAL_MATRICULA foreign key (IDPERSONAL)
      references PERSONAL (IDPERSONAL) on delete restrict on update restrict;

drop table if exists DETALLE_MATRICULA;

/*==============================================================*/
/* Table: DETALLE_MATRICULA                                     */
/*==============================================================*/
create table DETALLE_MATRICULA
(
   IDHISTORIAL          numeric(6,0) not null,
   IDMATRICULA          numeric(6,0) not null,
   IDPERIODO            numeric(6,0) not null,
   IDPERSONAL           numeric(8,0),
   IDCARRERA            numeric(6,0) not null,
   IDMATERIA            numeric(8,2),
   SUPLETORIO           numeric(5,2),
   NOTA_FINAL           numeric(5,2),
   REVALIDADO           varchar(1),
   APROBADO             varchar(2),
   SUMA                 numeric(6,2),
   ANULADO              varchar(2),
   ASISTENCIA           numeric(5,2),
   OBSERVACION          varchar(20),
   OBSERVACION1         varchar(50),
   NORMAL               varchar(1),
   EVALUO               numeric(3,1),
   OYENTE               varchar(2),
   AUTORIZADO           varchar(2),
   ATRASO               varchar(2),
   IDMALLACURRICULAR    numeric(2,0),
   primary key (IDHISTORIAL, IDMATRICULA, IDPERIODO, IDCARRERA)
);

alter table DETALLE_MATRICULA add constraint FK_FK_MATERIAS_DETALLEMATRICULA foreign key (IDMATERIA)
      references MATERIAS (IDMATERIA) on delete restrict on update restrict;

alter table DETALLE_MATRICULA add constraint FK_FK_MATRICULA_DETALLEMATRICULA foreign key (IDMATRICULA, IDPERIODO, IDPERSONAL, IDCARRERA)
      references MATRICULA (IDMATRICULA, IDPERIODO, IDPERSONAL, IDCARRERA) on delete restrict on update restrict;

drop table if exists NOTAS;

/*==============================================================*/
/* Table: NOTAS                                                 */
/*==============================================================*/
create table NOTAS
(
   IDHISTORIAL          numeric(6,0),
   IDMATRICULA          numeric(6,0),
   IDPERIODO            numeric(6,0),
   IDCARRERA            numeric(6,0),
   IDPARAMETRO          numeric(6,0),
   NOTA                 numeric(6,2)
);

alter table NOTAS add constraint FK_FK_DETALLEMATRICULA_NOTAS foreign key (IDHISTORIAL, IDMATRICULA, IDPERIODO, IDCARRERA)
      references DETALLE_MATRICULA (IDHISTORIAL, IDMATRICULA, IDPERIODO, IDCARRERA) on delete restrict on update restrict;

alter table NOTAS add constraint FK_FK_PARAMETROS_NOTAS foreign key (IDPARAMETRO)
      references PARAMETROS (IDPARAMETRO) on delete restrict on update restrict;

drop table if exists NOTAS_O;

/*==============================================================*/
/* Table: NOTAS_O                                               */
/*==============================================================*/
create table NOTAS_O
(
   IDMATRICULA          numeric(6,0),
   IDPERIODO            numeric(6,0),
   IDHISTORIAL          numeric(6,0),
   IDPARCIAL            numeric(6,0),
   OBSERVACION          varchar(50),
   IDCARRERA            numeric(6,0)
);

/*==============================================================*/
/* Table: NOTAS_O                                               */
/*==============================================================*/
create table GRADUADOS
(
   ID          numeric(6,0) PRIMARY KEY,
   NOMBRES            varchar(50),
   CEDULA		varchar(10),
   GENERO            varchar(9),
   FECHA_INICIO            date,
   FECHA_GRADUACION			date,
   TIEMPO  int(2),
   TELEFONO VARCHAR(12),
   MODALIDAD VARCHAR(50)
);