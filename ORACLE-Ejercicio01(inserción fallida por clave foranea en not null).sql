CREATE TABLE PROVINCIA(
    idprovincia int CONSTRAINT PK_PROVINCIA PRIMARY KEY,
    nombreprovincia varchar(40),
    numerohabitantes long
)

CREATE TABLE CANTON(
    idcanton int CONSTRAINT PK_CANTON PRIMARY KEY,
    idprovincia int not null,
    nombrecanton varchar(40),
    CONSTRAINT FK_CANTON_PROVINCIA FOREIGN KEY(idprovincia) REFERENCES PROVINCIA(idprovincia)  
)

insert into PROVINCIA VALUES(1, 'Manabí',37000);
insert into CANTON(idcanton,nombrecanton) values (1,'Portoviejo');