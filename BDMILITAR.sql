CREATE TABLE MILITAR(			
idmilitar	int	primary key,	
numeroidentificacionmilitar	varchar(15),		
nacionalidad	varchar(50),		
nombresmilitar	varchar(50)	not null,	
apellidosmilitar	varchar(50)	not null,	
ci	varchar(10)	not null,	
fechanacimiento	date	not null,	
lugarnacimiento	varchar(100),		
fechaenlistamiento	date,		
sexo	varchar(1)	not null,	
tiposangre	varchar(2)	not null,	
estadocivil	varchar(20),		
estadomilitar	varchar(10)	not null,	
tienetatuajes	bit	DEFAULT 0,	
direccion	varchar(200),		
emailinstitucional	varchar(100),		
emailpersonal	varchar(100),		
constraint chk_militar_sexo check(sexo in('H', 'M')),			
constraint chk_militar_tiposangre check(tiposangre in('A-', 'A+', 'B-', 'B+', 'O-', 'O+', 'AB-', 'AB+', 'RH-', 'RH+')),			
constraint chk_militar_estadomilitar check(estadomilitar in('Activo', 'Inactivo', 'Retirado')),			
constraint uq_militar_ci unique(ci)			
)			
			
CREATE TABLE RANGO(			
idrango	int	primary key,	
nombrerango	varchar(15),		
rangoanterior	int,		
abreviaturarango	varchar(7),		
niveljerarquicosalarial	int,		
sueldobase	numeric(10,2),		
categoria	varchar(20),		
insignia	varchar(255),		
descripcion	varchar(200),		
constraint chk_rango_niveljerarquico check (niveljerarquico > 0),			
constraint fk_rango_rangonuevo foreign key(rangoanterior) references rango(idrango)			
)			
			
CREATE TABLE TIPODOTACION(			
idtipodotacion	int	primary key,	
nombredotacion	varchar(50),		
codigoinventario	varchar(10),		
categoria	varchar(15),		
descripcion	varchar(100),		
constraint uq_tipodotacion_codigoinventario unique(codigoinventario),			
constraint chk_tipodotacion_categoria check(categoria in('temporal', 'permanente'))			
)			
			
CREATE TABLE TIPOPRUEBA(			
idtipoprueba	int	primary key,	
nombreprueba	varchar(40),		
codigoprueba	varchar(10),		
categoriaprueba	varchar(20),		
dscripcionprueba	varchar(100),		
puntajeaprobatorio	numeric(4, 2)	default '7',	
duracionminutos	int,		
constraint chk_tipoprueba_categoriaprueba check (categoriaprueba IN ('Física','Teórica')),			
constraint chk_tipoprueba_puntajeaprobatorio check(puntajeaprobatorio>=7 and puntajeaprobatorio<=10)			
)			
			
CREATE TABLE DOTACION(			
iddotacion	int	primary key,	
idtipodotacion	int	not null,	
numeroserie	varchar(15),		
codigodotacion	varchar(15),		
estadodotacion	varchar(15),		
condicion	varchar(15),		
fechafabricacion	date,		
fechaadquisicion	date,		
fechabaja	date,		
proveedor	varchar(100),		
costounitario	numeric(10,2),		
observaciones	text,		
constraint fk_dotacion_tipodotacion foreign key(idtipodotacion) references tipodotacion(idtipodotacion),			
constraint uq_dotacion_numeroserie unique(numeroserie),			
constraint uq_dotacion_codigodotacion unique(codigodotacion),			
constraint chk_dotacion_costo check (CostoUnitario >= 0),			
constraint chk_dotacion_condicion check(condicion in('Nuevo', 'Bueno', 'Regular', 'Dañado')),			
constraint chl_dotacion_estadodotacion check(estadodotacion in('En Bodega', 'Asignado', 'En Mantenimiento', 'Extraviado', 'De Baja'))			
)			
			
CREATE TABLE BRIGADA(			
idbrigada	int	primary key,	
idmilitarencargado	int	not null,	
nombrebrigada	varchar(50)	not null,	
abreviaturabrigada	varchar(7),		
insigniabrigada	varchar(255),		
descripcionbrigada	varchar(150),		
efectivostotales	int,		
presupuesto	numeric(10,2),		
tipobrigada	varchar(20),		
estadooperativo	varchar(10)	not null default 'Activo',	
ubicacionbrigada	varchar(200),		
fechacreacionbrigada	date,		
fechainiciooperacionbrigada	date,		
fechafinproyectadaoperacionbrigada	date,		
fechafinrealoperacionbrigada	date,		
constraint chk_brigada_tipobrigada check (tipobrigada IN ('Infantería','Mecanizada','Blindada','Acorazada','Paracaidista','Aerotransportada','Selva','Montaña','Anfibia')),			
constraint fk_brigada_militar foreign key(idmilitarencargado) references militar(idmilitar),			
constraint chk_brigada_estadooperativo check(estadooperativo in ('Activo', 'Inactivo')),			
)			
			
CREATE TABLE REQUISITORANGO(			
idrequisitorango	int	primary key,	
idprueba	int	not null,	
idrango	int	not null,	
cursosobligatorios	varchar(100)	not null,	
calificacionpromedio	numeric(2,0)	not null,	
descripcionrequisito	varchar(100),		
lugarprueba	varchar(100)	NULL,	
estado	varchar(10)	not null default 'vigente',	
constraint fk_requisitorango_tipoprueba foreign key(idprueba) references tipoprueba(idtipoprueba),			
constraint fk_requisitorango_rango foreign key(idrango) references rango(idrango),			
constraint chk_requisitoranto_estadoprueba check(estado in ('vigente', 'no vigente'))			
)			
			
CREATE TABLE HISTORIALASCENSO(			
idhistorialascenso	int	primary key,	
idmilitar	int	not null,	
idrango	int	not null,	
fechasolicitudascenso	date,		
fechaotorgacionascenso	date,		
meritoascenso	varchar(20)	not null,	
bajasconfirmadas	int,		
resultado	varchar(20)	not null default 'aprobado',	
observacion	text,		
documentorespaldo	varchar(200),		
constraint fk_historialascenso_militar foreign key(idmilitar) references militar(idmilitar),			
constraint fk_historialascenso_rango foreign key(idrango) references rango(idrango),			
constraint chk_historialascenso_resultado check(resultado in ('aprobado', 'reprobado'))			
)			
			
CREATE TABLE HISTORIALDOTACION(			
idhistorialdotacion	int	primary key,	
iddotacion	int	not null,	
idmilitarasignado	int	not null,	
fechadesignacion	date,		
responsabledesignacion	varchar(150),		
estadodelbiendesignado	varchar(15),		
fechadevolucion	date,		
responsabledevolucion	varchar(150),		
estadodelbiendevuelto	varchar(15),		
observaciones	text,		
constraint fk_historialdotacion_dotacion foreign key(iddotacion) references dotacion(iddotacion),			
constraint fk_historialdotacion_militar foreign key(idmilitarasignado) references militar(idmilitar),			
constraint chk_historialdotacion_estadodelbiendesignado check(estadodelbiendesignado in('Nuevo', 'Bueno', 'Regular', 'Dañado')),			
constraint chk_historialdotacion_estadodelbiendevuelto check(estadodelbiendevuelto in('Nuevo', 'Bueno', 'Regular', 'Dañado'))			
)			
			
CREATE TABLE CASTIGO(			
idcastigo	int	primary key,	
idmilitarcastigado	int	not null,	
idmilitarsuperior	int	not null,	
nivelgravedad	varchar(20),		
motivocastigo	varchar(20)	not null,	
infraccion	varchar(10)	not null,	
fechainfraccion	date	not null,	
lugarinfraccion	varchar(100)	not null,	
tiposancion	varchar(10)	not null,	
descripcionsancion	varchar(100),		
fechainiciosancion	date	not null,	
fechafinsancion	date	not null,	
estadocastigo	bit	not null,	
observacion	varchar(100),		
archivosancion	varchar(200),		
constraint chk_castigo_gravedad check (nivelgravedad IN ('Leve','Media','Grave')),			
constraint chk_castigo_fechas check (fechainiciosancion <= fechafinsancion),			
constraint fk_castigo_militar foreign key(idmilitarcastigado) references militar(idmilitar),			
constraint fk_castigo_militarsuperior foreign key(idmilitarsuperior) references militar(idmilitar)			
)			
			
CREATE TABLE MISION(			
idmision	int	primary key,	
idbrigada	int	not null,	
estadomision	varchar(10)	not null default 'Activo',	
integrantesmision	int,		
lugarmision	varchar(200),		
unidadprincipal	varchar(50)	not null,	
tipomision	varchar(30)	not null,	
objetivomision	varchar(250)	not null,	
descripcionmision	varchar(200)	not null,	
prioridad	varchar(100)	not null,	
numerobajas	int	DEFAULT 0,	
fechaplanificacion	date,		
fechainiciomision	date,		
fechafinprogramada	date,		
resultadomision	varchar(20)	not null,	
constraint fk_mision_brigada foreign key(idbrigada) references brigada(idbrigada),			
constraint chk_mision_estadomision check(estadomision in('Activo', 'Inactivo')),			
constraint chk_mision_resultadomision check(resultadomision in ('Éxito', 'Fracaso'))			
)			
			
CREATE TABLE HISTORIALASCENSOCALIFICACION(			
idhistorialascensocalificacion	int	primary key,	
idrequisitorango	int	not null,	
idhistorialascenso	int	not null,	
fechahorainicio	datetime,		
fechahorafin	datetime,		
calificacion	numeric(4,2),		
lugarevaluacion	varchar(60),		
observacion	varchar(60),		
constraint fk_historialascensocalificacion_requisitorango foreign key(idrequisitorango) references requisitorango(idrequisitorango),			
constraint fk_historialascensocalificacion_historialascenso foreign key(idhistorialascenso) references historialascenso(idhistorialascenso)			
)			
			
CREATE TABLE HISTORIALBRIGADA(			
ighistorialbrigada	int	primary key,	
idbrigada	int	not null,	
idmilitar	int	not null,	
estadomilitarbrigada	varchar(30),		
funcionmilitar	varchar(250),		
resultadofuncionmilitar	varchar(250),		
ubicaciondelalabordelmilitar	varchar(80),		
fechaingresomilitarbrigada	date,		
fechasalidamilitarbrigada	date,		
constraint fk_historialbrigada_brigada foreign key(idbrigada) references brigada(idbrigada),			
constraint fk_historialbrigada_militar foreign key(idmilitar) references militar(idmilitar),			
constraint fk_historialbrigada_estadomilitarbrigada check (estadomilitarbrigada in ('vacaciones', 'dado de baja','satisfactorio','renuncia','relevo','muerto en operaciones','muerte natural', 'otro')),			
constraint fk_historialbrigada_ubicaciondelalabordelmilitar check (ubicaciondelalabordelmilitar in ('en campo', 'en oficina','otro'))			
)			
