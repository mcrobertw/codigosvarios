USE FARMACIA;


DROP TABLE VENDEDOR;

create table VENDEDOR(
	idvendedor integer identity PRIMARY KEY,
	nombreVen varchar(40),
	direVen varchar(50),
	numerolista integer identity
);