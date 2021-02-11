--TABLA
create table CLIENTE 
(
   IDCLIENTE            INTEGER              not null,
   CEDULACLIENTE        VARCHAR2(10),
   APELLIDOSCLIENTE     VARCHAR2(50),
   NOMBRESCLIENTE       VARCHAR2(50),
   FECHANACIMIENTOCLIENTE        DATE,
   constraint PK_CLIENTE primary key (IDCLIENTE)
);


--TRIGGER
CREATE OR REPLACE TRIGGER  TR_CLIENTE --EN SQLSER NO EXISTE "OR REPLACE"
BEFORE
DELETE ON CLIENTE
FOR EACH ROW
DECLARE

BEGIN                                                               --INSERT            UPDATE      DELETE
    DBMS_OUTPUT.PUT_LINE('VALOR NUEVO: '||:new.apellidoscliente);--    OK                 OK         NO
    DBMS_OUTPUT.PUT_LINE('VALOR VIEJO: '||:old.apellidoscliente);--    NO                 OK         OK
                                                                        
END;

--Operaciones para comprobar trigger
update cliente set apellidoscliente='Nevarez' where idcliente=4;
delete from CLIENTE where IDCLIENTE=4;
insert into cliente values(4,'1111','Capulina','Mayra','09-09-1985');