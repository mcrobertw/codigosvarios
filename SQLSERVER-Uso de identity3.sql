USE FARMACIA;

DROP TABLE VENDEDOR;

create table VENDEDOR(
	idvendedor integer identity PRIMARY KEY,
	nombreVen varchar(40),
	direVen varchar(50),
);

insert into vendedor values('Juan Piguave', 'Portoviejo'),('Lorenzo Piguave','Manta');

Delete from vendedor;

insert into vendedor values('luis Piguave', 'Portoviejo'),('Oliver Piguave','Manta');

select *from vendedor;