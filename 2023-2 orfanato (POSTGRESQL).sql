--Crear Tabla causa
create table causa(
	idcausa int primary key,
	descripcion varchar(200)
);

--tabla casa
create table casa(
	idcasa int primary key,
	direccion varchar(200),
	valorarriendo float,
	estado varchar(20),
	telefono varchar(50),
	descripcion varchar(20),
	ncuarto int
);

--Tabla Huerfano
create table huerfano(
	idhuerfano int primary key,
	nombres varchar(50),
	apellidos varchar(50),
	ci varchar(20)unique, 
	fechanacimiento date,
	tiposangre varchar(40),
	sexo varchar(1)
);

--Tabla Tio
create table tio(
	idtio int primary key,
	nombres varchar(50),
	apellidos varchar(50),
	ci varchar(10)unique,
	fechanacimiento date,
	tiposangre varchar(4),
	correoelectronico varchar(50),
	sexo varchar(1),
	direccion varchar(200),
	licencia varchar(3)
);

--Tabla Huerfano-causa
create table huerfanocausa(
	idcausa int references causa(idcausa),
	idhuerfano int references huerfano(idhuerfano),
	primary key(idcausa, idhuerfano),
	observacion varchar(200),
	fechacausa date
);

--Tabla Hermano-casa
create table hermanocasa(
	idcasa int references casa(idcasa),
	idtio int references tio(idtio),
	idhuerfano int references huerfano(idhuerfano),
	primary key(idcasa, idtio, idhuerfano),
	fechaentrada date,
	fechasalida date
);
