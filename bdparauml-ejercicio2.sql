create table Colectivo (
   idcolectivo        INT4                 not null,
   nombrecolectivo   VARCHAR(30)          	 null,
   lugarreunioncolectivo   VARCHAR(30) null,
   constraint PK_COLECTIVO primary key (idcolectivo) --Este primary key, es lo que en POO se conoce como "identidad" del objeto
);

create table Profesor (
   idprofesor        INT4                 not null,
   nombresprofesor   VARCHAR(30) null,
   apellidosprofesor   VARCHAR(30) null,
   telefonosprofesor   VARCHAR(30) null,
   idcolectivo INT4,
   constraint PK_PROFESOR primary key (idprofesor), --Este primary key, es lo que en POO se conoce como "identidad" del objeto
   constraint FK_PROFESOR_COLECTIVO foreign key (idcolectivo) references colectivo (idcolectivo) on delete set null
);

create table Direccion(
   iddireccion        INT4                 not null,
   lugardireccion   VARCHAR(30) null,
   calledireccion   VARCHAR(30) null,
   descripcioncasa   VARCHAR(30) null,
   idprofesor INT4,
   constraint PK_DIRECCION primary key (iddireccion), --Este primary key, es lo que en POO se conoce como "identidad" del objeto
   constraint FK_DIRECCION_PROFESOR foreign key (idprofesor) references profesor (idprofesor)
	on delete set null --En una "Asociación" cada objeto tiene su propio ciclo de vida y no hay propietarios.
);

insert into colectivo values(1,'software','aula 202'),(2,'proyectos','aula 206'),(3,'redes','aula 305');

insert into profesor values
(100,'Robert','Moreira','0978554719',1),(101,'Elsa','Vera','0997845678',1),
(102,'José','Basurto','0947521245',2),(103,'Adriana','Macías','0854563214',2),
(104,'Edison','Almeida','0927418529',3),(105,'Patricia','Quiroz','0978524569',3);

insert into direccion values
(300,'Portoviejo','Simón Bolívar','villa',100),
(301,'Chone','Manuela Cañizares','villa',100),
(302,'Manta','Flavio Reyes','villa',101),
(303,'Esmeraldas','Playa las palmas','villa',101);
select * from colectivo;
select * from profesor;
select * from direccion;

delete from colectivo;

drop table colectivo;
drop table profesor;
drop table direccion;