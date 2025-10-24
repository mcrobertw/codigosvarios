CREATE TABLE ROL(		
idrol	int	primary key,
nombre_rol	varchar(50)	not null,
descripcion	VARCHAR(255),	
estado	VARCHAR(10),	
fechacreacion	DATETIME)	
		
CREATE TABLE usuario(		
idusuario	int	primary key,
idrol	int	not null,
ciusuario	varchar(10),	
nombres	varchar (100)	not null,
apellidos	varchar (100)	not null,
correo	varchar(100)	not null,
nickname	varchar(100)	not null,
clave	varchar(200)	not null,
fechacreacion	datetime	DEFAULT GETDATE(),
fechaultimologin	datetime,	
estado	varchar(20)	NOT NULL DEFAULT 'pendientedeverificacion',
CONSTRAINT un_usuario_ci UNIQUE(ciusuario),		
CONSTRAINT fk_usuario_rol FOREIGN KEY (idrol) REFERENCES ROL(idrol),		
CONSTRAINT CHK_EstadoUsuario CHECK (Estado IN ('activo', 'inactivo', 'pendientedeverificacion', 'bloqueado'))		
)		


CREATE TABLE conveniocompania(		
idcompania	int	primary key,
nombre	varchar (100)	not null,
ruc	varchar (20)	not null,
telefono	varchar (20)	not null,
correo	varchar(100)	not null,
direccion	varchar(50)	not null,
fechainicioconvenio	int	not null,
fechafinconvenio	date	not null,
descripcion	date	not null,
condiciones	text	not null)
		
CREATE TABLE descuento(		
iddescuento	int	primary key,
descripcion	varchar (100)	not null,
fechainicio	date	not null,
fechafinal	date,	
estado	varchar (100)	NOT NULL DEFAULT 'activo',
CONSTRAINT CHK_EstadoDescuento CHECK (Estado IN ('activo', 'inactivo'))		
)		
		
CREATE TABLE promocion(		
idpromocion 	int	primary key,
nombrepromocion	varchar(100)	not null,
porcentajedescuento	decimal(5,2)	not null,
porcentajebeneficio	decimal(5,2)	not null,
fechainicio	date	not null,
fechafinal	date,	
tipopromocion	varchar(20)	NOT NULL DEFAULT 'servicio',
estado	varchar (100)	NOT NULL DEFAULT 'activo',
canaldeaplicacion	varchar(10)	NOT NULL DEFAULT 'oficina',
CONSTRAINT CHK_EstadoPromocion CHECK (Estado IN ('activo', 'inactivo')),		
CONSTRAINT CHK_CanalPromocion CHECK (CanalDeAplicacion IN ('web', 'oficina', 'ambos')),		
CONSTRAINT CHK_TipoPromocion CHECK (TipoPromocion IN ('servicio', 'paquete', 'item'))		
)		
		
CREATE TABLE  habitacion(		
idhabitacion	int	primary key,
numerohabitacion	varchar(10)	not null,
descripcion	varchar(255),	
tipohabitacion	varchar(50)	not null,
estado	varchar(20)	DEFAULT 'disponible',
preciobase	decimal(10,2)	not null,
numerocamas	int	NOT NULL DEFAULT 1,
fechaultimomantenimiento	datetime,	
CONSTRAINT CHK_EstadoHabitacion CHECK (estado IN ('disponible', 'ocupada', 'mantenimiento', 'limpieza'))		
)		
		
CREATE TABLE empleado(		
idempleado	int	primary key,
ciempleado	varchar(10),	
nombre	varchar(100)	not null,
apellido	varchar (100)	not null,
cargo	varchar(50)	not null,
fechaingreso	date	not null,
telefono	VARCHAR(15),	
email	VARCHAR(100),	
direccion	VARCHAR(255),	
salario	DECIMAL(10, 2),	
estado	VARCHAR(15)	NOT NULL DEFAULT 'activo',
CONSTRAINT CHK_EstadoEmpleado CHECK (Estado IN ('activo', 'inactivo', 'vacaciones')),				
CONSTRAINT un_empleado_ci UNIQUE(ciempleado)		
)		
		
CREATE TABLE horario(		
idhorario	int	primary key,
descripcion	VARCHAR(100)	NOT NULL,
horaentrada	time	not null,
horasalida	time	not null,
tipojornada	VARCHAR(20)	DEFAULT 'completo',
aplicapagoextra	BIT	NOT NULL DEFAULT 0,
estado	VARCHAR(20)	NOT NULL DEFAULT 'activo',
CONSTRAINT CHK_EstadoHorario CHECK (Estado IN ('activo', 'inactivo')),		
CONSTRAINT CHK_TipoJornada CHECK (TipoJornada IN ('completo', 'medio tiempo', 'rotativo'))		
)		
		
CREATE TABLE tipolabor(		
idtipolabor	INT	PRIMARY KEY,
descripcion	VARCHAR(100)	NOT NULL,
perfilprofesional	VARCHAR(50)	NOT NULL,
prioridad	VARCHAR(10)	NOT NULL DEFAULT 'media',
estado	VARCHAR(10)	NOT NULL DEFAULT 'activo',
CONSTRAINT CHK_PrioridadLabor CHECK (prioridad IN ('alta', 'media', 'baja')),		
CONSTRAINT CHK_EstadoTipoLabor CHECK (estado IN ('activo', 'inactivo'))		
)		
		
CREATE TABLE asistencia(		
idasistencia 	int	primary key,
idempleado	int	not null,
idhorario	int	not null,
horaentrada	datetime	not null,
horasalida	datetime	not null,
atraso	BIT	NOT NULL DEFAULT 0,
observacionatraso	VARCHAR(255),	
novedadpositiva	VARCHAR(255),	
novedadnegativa	VARCHAR(255),	
CONSTRAINT fk_asistencia_empleado FOREIGN KEY (idempleado) REFERENCES empleado(idempleado),		
CONSTRAINT fk_asistencia_horario FOREIGN KEY (idhorario) REFERENCES horario (idhorario)		
)		
		
		
CREATE TABLE labor(		
idlabor	INT	PRIMARY KEY,
idhabitacion	INT	NOT NULL,
idempleado	INT	NOT NULL,
idtipolabor	INT	NOT NULL,
fechatarea	DATE	NOT NULL,
Descripcion	TEXT,	
fechacreacion	DATETIME	DEFAULT GETDATE(),
fechafinalizacion	DATETIME,	
obervacion	VARCHAR(255),	
costomateriales	DECIMAL(10, 2)	DEFAULT 0,
estado	VARCHAR(20)	DEFAULT 'pendiente',
CONSTRAINT fk_labor_habitacion FOREIGN KEY (idhabitacion) REFERENCES habitacion(idhabitacion),		
CONSTRAINT fk_labor_empleado FOREIGN KEY (idempleado) REFERENCES empleado(idempleado),		
CONSTRAINT fk_labor_tipolabor FOREIGN KEY (idtipolabor) REFERENCES TipoLabor(idtipolabor)		
)		
		
CREATE TABLE reserva(		
idreserva	INT	PRIMARY KEY,
idcompania	INT	NOT NULL,
idhabitacion	INT	NOT NULL,
idusuario	INT	NOT NULL,
iddescuento	INT,	
idpromocion	INT,	
cantidadpersonas	int	not null,
fechaentrada	DATETIME	NOT NULL,
fechasalida	DATETIME	NOT NULL,
estadoreserva	VARCHAR(20)	NOT NULL DEFAULT 'confirmada',
preciofinal	DECIMAL(10, 2),	
metodopago	VARCHAR(20),	
comentarios	VARCHAR(20),	
total	decimal(10,2)	not null,
anticipo	decimal(10,2)	not null,
saldopendiente	decimal(10,2)	not null,
CONSTRAINT fk_reserva_conveniocompania FOREIGN KEY (idcompania) REFERENCES conveniocompania(idcompania),		
CONSTRAINT fk_reserva_habitacion FOREIGN KEY (idhabitacion) REFERENCES habitacion(idhabitacion),		
CONSTRAINT fk_reserva_usuario FOREIGN KEY (idusuario) REFERENCES usuario(idusuario),		
CONSTRAINT fk_reserva_descuento FOREIGN KEY (iddescuento) REFERENCES descuento(iddescuento),		
CONSTRAINT fk_reserva_promocion FOREIGN KEY (idpromocion) REFERENCES promocion(idpromocion),		
CONSTRAINT CHK_EstadoReserva CHECK (estadoreserva IN ('confirmada', 'anulada'))		
)		
