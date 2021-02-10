--SGBD: Oracle

CREATE TABLE PERSONA(
	idpersona integer primary key,
	nombrespersona varchar2(30),
	apellidospersona varchar2(30),
	genero varchar2(20),
	idpadre integer,
	idmadre integer
)

alter table persona add constraint fk_padre foreign key(idpadre) references persona(idpersona);
alter table persona add constraint fk_madre foreign key(idmadre) references persona(idpersona);