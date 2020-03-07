CREATE TABLE LIBRO(
	idlibro integer PRIMARY KEY,
	nombrelibro varchar(40),
	numeropaginas integer,
	isbn varchar(20)
)

insert into libro(idlibro,nombrelibro) values(1,'BASES DE DATOS');