CREATE TABLE PASAJERO		(
idpasajero	int	primary key,
ci	varchar(10),	
nombres	varchar (30),	
apellidos	varchar (30),	
ciudad	varchar(40),	
sexo	varchar(1),	
direccion	varchar(50),	
email	varchar(50),
CONSTRAINT ch_pasajero_sexo 	check (sexo='H' or sexo='M'),
CONSTRAINT un_pasajero_ci UNIQUE(ci))


CREATE TABLE ESCALA	(
idescala	int	primary key,
origen	varchar(40)	,
destino	varchar(40)	,
tarifa	numeric(6,2))


CREATE TABLE RESERVA(
idreserva	int	primary key,
idpasajero	int	not null,
formapago	varchar(50)	,
auspiciantecrediticio	varchar(50)	,
precio	numeric(6,2)	,
fechadesolicitud	date,	
fechadeexpiracion	date,	
pesosolicitado	NUMERIC(6,2),	
llevamascotas	BIT	default 0,
estado	BIT	,
CONSTRAINT fk_reserva_pasajero FOREIGN KEY(idpasajero) REFERENCES PASAJERO(idpasajero)	)



CREATE TABLE ITINERARIO		(
iditinerario	INT primary key	,
idreserva	int	not null,
idescala	int	not null,
aereolinea	varchar(50)	,
numerovuelo	varchar(20)	,
fechasalida	datetime	,
fechallegada	datetime,	
cabina	varchar(40)	,
asiento	varchar(10)	,
descripcionequipaje	varchar(50)	,
CONSTRAINT fk_itinerario_reserva FOREIGN KEY(idreserva) REFERENCES RESERVA(idreserva)		,
CONSTRAINT fk_itinerario_escala FOREIGN KEY(idescala) REFERENCES ESCALA(idescala)		

)


CREATE TABLE PAGORESERVA	(
idpagoreserva	int,
idreserva	int,
cantidadmascotas	int,
numeromaletas	int,
precioseguroequipaje	numeric(6,2),
CONSTRAINT fk_pagoreserva_reserva FOREIGN KEY(idreserva) REFERENCES RESERVA(idreserva)	
)