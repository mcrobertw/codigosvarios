CREATE TABLE JUGADORFUTBOL(
	idjugador int identity constraint JUGADORFUTBOL_PK_idjugador primary key,
	nombres varchar(40),
	apellidos varchar(40),
	fechanacimiendo date
)

insert into JUGADORFUTBOL VALUES('José René','Higuita Zapata','1966/08/27'),
								('Álex Darío','Aguinaga Garzón','1968/07/09'),
								('Carlos','Muñoz Martínez','1964/10/24');

select top 1 * from JUGADORFUTBOL order by fechanacimiendo DESC;