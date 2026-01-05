CREATE TABLE TIPODESARROLLADOR(		
idtipodesarrollador 	INT	primary key,
nombre 	VARCHAR(100), 	
descripcion	VARCHAR(100) ,	
salariobase	numeric(6,2),	
fechaultimaactualizacionsalario	date	
)		
		
CREATE TABLE TAREA (		
idtarea 	INT	PRIMARY KEY,
nombretarea	VARCHAR(100)	NOT NULL,
diasetimadostarea	INT,	
complejidadestimada	INT,	
valorestimadotarea	numeric(6,2),	
fechaultimaactualizacion	date,	
estadovigencia	bit	not null,
CONSTRAINT chk_tarea_complejidad CHECK (complejidadestimada BETWEEN 1 AND 10)		
)		
		
CREATE TABLE TIPOPROYECTO (		
idtipoproyecto	INT	PRIMARY KEY,
nombre	VARCHAR(100) 	NOT NULL,
descriptoresproyecto	VARCHAR(100),	
CONSTRAINT uk_tipoproyecto_nombre UNIQUE (nombre)		
)		
		
CREATE TABLE TIPOEVALUACION (		
idtipoevaluacion	INT	PRIMARY KEY,
nombre	VARCHAR(100)	NOT NULL,
descripcion	VARCHAR(100),	
rangoimportancia	VARCHAR(50),	
constraint chk_tipoevaluacion_rangoimportancia check (rangoimportancia IN ('alta','media'))		
)		
		
CREATE TABLE TIPORECOMENDACION (		
idtiporecomendacion	INT	PRIMARY KEY,
nombre	VARCHAR(100)	NOT NULL,
origenrecomendacion	VARCHAR(50),	
descripcion	VARCHAR(100),	
constraint chk_tiporecomendacion_origenrecomendacion check (origenrecomendacion IN ('profesional','familiar','laboral','académica'))		
)		
		
		
CREATE TABLE HERRAMIENTADESARROLLO (		
idherramientadesarrollo	INT	PRIMARY KEY,
nombre 	VARCHAR(100)	NOT NULL,
versionherramienta	VARCHAR(50),	
tipoherramienta	VARCHAR(50),	
descripcion	VARCHAR(100),	
cotizacionmensualrelativa	numeric(6,2),	
constraint chk_herramientadesarrollo_tipoherramienta check (tipoherramienta IN ('propietario','libre'))		
)		
		
CREATE TABLE RECOMENDACIONEXTERNA(		
idrecomendacionexterna	INT	PRIMARY KEY,
idtiporecomendacion	INT	not null,
nombrespersona	VARCHAR(80),	
apellidospersona	VARCHAR(80),	
nombreempresa	VARCHAR(80),	
fecharecomendacion	DATE,	
telefonopersonal	VARCHAR(80),	
telefonoempresarial	VARCHAR(80),	
emailpersonal	VARCHAR(80),	
emailempresarial	VARCHAR(80),	
estadorecomendacion	VARCHAR(80)	default 'por verificar',
descripcion	VARCHAR(150),	
constraint chk_recomendacionexterna_estadorecomendacion check (estadorecomendacion IN ('verificada','por verificar')),		
constraint fk_recomendacionexterna_tiporecomendacion foreign key(idtiporecomendacion) references tiporecomendacion(idtiporecomendacion)		
)		
		
CREATE TABLE DESARROLLADOR(		
iddesarrollador	INT	PRIMARY KEY,
idtipodesarrollador	INT	NOT NULL,
ci	VARCHAR(10),	
fechanacimiento	date,	
nombresdesarrollador	VARCHAR(60),	
apellidosdesarrollador	VARCHAR(60),	
email	VARCHAR(100)	NOT NULL,
telefono	VARCHAR(15),	
fechaobtencionultimonivelacademico	date,	
areadeestudiofavorita	VARCHAR(200),	
activoenlaempresa	bit	DEFAULT 1,
CONSTRAINT uk_desarrollador_cedula UNIQUE (ci),		
CONSTRAINT fk_desarrollador_tipodesarrollador  FOREIGN KEY (idtipodesarrollador) REFERENCES TipoDesarrollador(idtipodesarrollador)		
)		
		
CREATE TABLE HABILIDADDESARROLLO(		
idhabilidaddesarrollo	INT	primary key,
iddesarrollador	int	not null,
idherramientadesarrollo	int	not null,
nivelexperiencia	VARCHAR(60),	
fechaultimaactualizacion	date,	
descripcionformaenqueganohabilidad	VARCHAR(200),	
empresasdonderealizoactividades	VARCHAR(200),	
constraint chk_habilidaddesarrollo_nivelexperiencia check (nivelexperiencia IN ('básico','intermedio','avanzado','experto')),		
CONSTRAINT fk_habilidaddesarrollo_desarrollador  FOREIGN KEY (iddesarrollador) REFERENCES Desarrollador(iddesarrollador),		
CONSTRAINT fk_habilidaddesarrollo_herramientadesarrollo  FOREIGN KEY (idherramientadesarrollo) REFERENCES herramientadesarrollo(idherramientadesarrollo)		
)		
		
CREATE TABLE EVALUACION(		
idevaluacion	INT	primary key,
idtipoevaluacion	INT	not null,
fechacreacion	date,	
nombreevaluacion	varchar(60),	
descripcionevaluacion	varchar(200),	
escenarioevaluacion	varchar(60),	
puntajeminimorequerido	numeric(4,2),	
puntajemaximo	numeric(4,2),	
constraint chk_evaluacion_escenarioevaluacion check (escenarioevaluacion IN ('online','presencial','otro')),		
CONSTRAINT fk_evaluacion_idtipoevaluacion  FOREIGN KEY (idtipoevaluacion) REFERENCES tipoevaluacion(idtipoevaluacion)		
)		
		
CREATE TABLE RECOMENDACIONINTERNA(		
idrecomendacioninterna	INT	PRIMARY KEY,
iddesarrolladorquerecomienda	INT	not null,
iddesarrolladorrecomendado	INT	not null,
estadorecomendacion	VARCHAR(80),	
fecharecomendacion	DATE,	
observacion	VARCHAR(150),	
CONSTRAINT uk_desarrolladorrecomendado_iddesarrolladorrecomendado UNIQUE (iddesarrolladorrecomendado),		
constraint chk_recomendacioninterna_estadorecomendacion check (estadorecomendacion IN ('Excelente','buena','regular','mala')),		
constraint fk_recomendacioninterna_iddesarrolladorquerecomienda foreign key(iddesarrolladorquerecomienda) references desarrollador(iddesarrollador),		
constraint fk_recomendacioninterna_iddesarrolladorrecomendado foreign key(iddesarrolladorrecomendado) references desarrollador(iddesarrollador)		
)		
		
CREATE TABLE PROYECTO(		
idproyecto	int	primary key,
idtipoproyecto	int	not null,
nombreproyecto	VARCHAR(200),	
descripcion	TEXT,	
fechainicio	DATE,	
fechaestimadafin	DATE,	
fecharealfin	DATE,	
valorproyecto	numeric(10,2),	
estadoproyecto	varchar(30)	DEFAULT 'en ejecución',
complejidad	int,	
observacion	varchar(200),	
constraint chk_proyecto_estadoproyecto check (estadoproyecto IN ('en ejecución','concluido','cancelado','otro')),		
constraint chk_proyecto_fecha1 check (fecharealfin IS NULL OR fecharealfin >= fechainicio),		
constraint chk_proyecto_fecha2 check (fechaestimadafin IS NULL OR fecharealfin >= fechainicio),		
constraint fk_proyecto_tipoproyecto foreign key(idtipoproyecto) references tipoproyecto(idtipoproyecto)		
)		
		
CREATE TABLE GRUPOTRABAJO(		
idgrupotrabajo	int	primary key,
idproyecto	int	not null,
iddesarrollador	int	not null,
presupuesto	numeric(6,2),	
fechaingresogrupo	date,	
fechasalidagrupo	date,	
rolenproyecto	VARCHAR(50),	
condicionsalida	VARCHAR(50)	DEFAULT 'Trabajo concluido',
terminoscontractuales	VARCHAR(200),	
constraint chk_grupotrabajo_condicionsalida check (condicionsalida IN ('trabajo concluido','renuncio','desaparecio','relevo','otro')),		
constraint fk_grupograbajo_proyecto foreign key(idproyecto) references proyecto(idproyecto),		
constraint fk_grupograbajo_desarrollador foreign key(iddesarrollador) references desarrollador(iddesarrollador)		
)		
		
CREATE TABLE HISTORICORENDIMIENTO(		
idhistoricorendimiento	int	primary key,
idhabilidaddesarrollo	int	not null,
idevaluacion	int	not null,
fechaevaluacion	date,	
puntaje	numeric(10,2),	
escenarioevaluacion	varchar(40),	
observaciondelevaluado	varchar(100),	
observacionevaluador	varchar(100),	
constraint chk_historicorendimiento_escenarioevaluacion check (escenarioevaluacion IN ('presencial','virtual','otro')),		
constraint fk_historicorendimiento_habilidaddesarrollo foreign key(idhabilidaddesarrollo) references habilidaddesarrollo(idhabilidaddesarrollo),		
constraint fk_historicorendimiento_evaluacion foreign key(idevaluacion) references evaluacion(idevaluacion)		
)		
		
CREATE TABLE HISTORIALTAREA(		
idhistorialtarea	int	primary key,
idtarea	int	not null,
idgrupotrabajo	int	not null,
idproyecto	int	not null,
estadotarea	varchar(50),	
fechainiciotarea	date,	
fechaestimadafintarea	date,	
fecharealfintarea	date,	
entregablesactividad	varchar(200),	
comentarios	varchar(200),	
constraint chk_historialtarea_estadotarea check (estadotarea IN ('en ejecución','pendiente','por asignarse','concluida','otro')),		
constraint fk_historialtarea_tarea foreign key(idtarea) references tarea(idtarea),		
constraint fk_historialtarea_grupotrabajo foreign key(idgrupotrabajo) references grupotrabajo(idgrupotrabajo),		
constraint fk_historialtarea_proyecto foreign key(idproyecto) references proyecto(idproyecto)		
)		
