CREATE TABLE PROVINCIA(
    idprovincia int CONSTRAINT PK_PROVINCIA PRIMARY KEY,
    nombreprovincia varchar(40),
    numerohabitantes int
)

CREATE TABLE CANTON(
    idcanton int CONSTRAINT PK_CANTON PRIMARY KEY,
    idprovincia int CONSTRAINT FK_CANTON_PROVINCIA FOREIGN KEY REFERENCES PROVINCIA(idprovincia),
    nombrecanton varchar(40)
)
