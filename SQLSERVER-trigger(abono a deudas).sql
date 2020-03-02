DROP TABLE Pago;
DROP TABLE Deuda;
DROP TABLE Cliente;

create table CLIENTE(
	idcliente INTEGER not null constraint CLIENTE_PK_IDCLIENTE primary key (idcliente),
	Nombre VARCHAR(55),
	apellidos VARCHAR(55),
	sexo VARCHAR(30),
	Telefono VARCHAR(20),
	correo VARCHAR(80),
	direccion VARCHAR(90),
	
);


create table Deuda(
	id_deuda Integer not null primary key,
	id_cliente integer foreign key references Cliente(id_cliente),
	descripcion_deuda VARCHAR(90),
	montoOriginal numeric(7,2),
	montoPendiente numeric(7,2),
	estado varchar(30) check (estado=="PENDIENTE" OR estado=="VIGENTE"),
	id_cliente Integer
);

create table Pago(
	id_pago Integer not null primary key,
	tipo_de_pago VARCHAR(60),
	fecha date,
	valor int,
	id_deuda Integer, foreign key (id_deuda) references Deuda(id_deuda)
);