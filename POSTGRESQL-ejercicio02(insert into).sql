CREATE TABLE LIBRO(
	idlibro serial constraint pk_libro primary key,
	nombrelibro varchar(40),
	numeropaginas integer,
	isbn varchar(20)
)

insert into libro values('1984',213,'980-12-2075-9');