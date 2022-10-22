--NOMBRE DE LAS BASES DE DATOS EN POSTGRESQL Y SQL SERVER: BDPRODUCTO
--EN ORACLE se accede a la instancia con el nombre de usuario

--************************************ORACLE*********************
--TABLA DE ORACLE
create table PRODUCTO 
(
   ID_PRODUCTO           VARCHAR2(10),
   DESCRIPCION          VARCHAR2(20),
   COSTO         NUMBER(7,2),
   PRECIO        NUMBER(7,2)
);

--PROCEDIMIENTO ALMACENADO CON ORACLE - PLSQL
create or replace PROCEDURE PA_INSERTARPRODUCTO(PIDPRODUCTO IN PRODUCTO.ID_PRODUCTO%TYPE, PDESCRIPCION IN PRODUCTO.DESCRIPCION%TYPE, 
PCOSTO IN PRODUCTO.COSTO%TYPE, PPRECIO IN PRODUCTO.PRECIO%TYPE)
AS
BEGIN 
INSERT INTO PRODUCTO VALUES (PIDPRODUCTO,PDESCRIPCION,PCOSTO,PPRECIO);
END PA_INSERTARPRODUCTO;
	 --PRUEBA
    CALL PA_INSERTARPRODUCTO(1,'CHOCOLATE',10,10);

	
	
--************************************POSTGRESQL*********************
--TABLA DE POSTGRESQL
create table PRODUCTO 
(
   ID_PRODUCTO           VARCHAR(10),
   DESCRIPCION          VARCHAR(20),
   COSTO         NUMERIC(7,2),
   PRECIO        NUMERIC(7,2)
);
--PROCEDIMIENTO ALMACENADO EN POSTGRESQL (EL %TYPE NO SE USA CON  LOS TIPOS DECIMALES, SE USA DIRECTAMENTE FLOAT PARA QUE EL PROCEDIMIENTO ALMACENADO TOME LOS PARAMETROS
-- COMO "DOUBLE PRECCISSION", CASO CONTRARIO LOS TOMARIA COMO "NUMERIC" Y NO SE RECONOCE EN LAS LLAMADAS DESDE JAVA    - PL/PGSQL
  create or replace function PA_INSERTARPRODUCTO(PIDPRODUCTO PRODUCTO.ID_PRODUCTO%TYPE,
   PDESCRIPCION PRODUCTO.DESCRIPCION%TYPE, 
   PCOSTO FLOAT,PPRECIO FLOAT) returns void as $$
  Begin
    INSERT INTO PRODUCTO VALUES (PIDPRODUCTO,PDESCRIPCION,PCOSTO,PPRECIO);
  end;
  $$ LANGUAGE plpgsql;
  
  --PRUEBA
    SELECT PA_INSERTARPRODUCTO('1','CHOCOLATE',10,10);
	select * from PA_INSERTARPRODUCTO('1','Computadora',600.0,1000.0)
	
	

	
--************************************SQLSERVER*********************
--TABLA DE SQLSERVER
create table PRODUCTO 
(
   ID_PRODUCTO           VARCHAR(10),
   DESCRIPCION          VARCHAR(20),
   COSTO         NUMERIC(7,2),
   PRECIO        NUMERIC(7,2)
);
--PROCEDIMIENTO ALMACENADO EN SQLSERVER  - TSQL
  CREATE PROCEDURE PA_INSERTARPRODUCTO
(@PIDPRODUCTO VARCHAR(10), @PDESCRIPCION VARCHAR(50),  @PCOSTO NUMERIC(7,2), @PPRECIO NUMERIC(7,2))
AS
BEGIN

INSERT INTO PRODUCTO VALUES  (@PIDPRODUCTO, @PDESCRIPCION , @PCOSTO, @PPRECIO)
END 
GO 

--PRUEBA
EXECUTE PA_INSERTARPRODUCTO '1', 'Chocolate', 3,3;


--**********************************MYSQL*********************
--TABLA DE MYSQL
create table PRODUCTO 
(
   ID_PRODUCTO           VARCHAR(10),
   DESCRIPCION          VARCHAR(20),
   COSTO         NUMERIC(7,2),
   PRECIO        NUMERIC(7,2)
);
--PROCEDIMIENTO ALMACENADO EN MYSQL
DELIMITER $$
CREATE PROCEDURE PA_INSERTARPRODUCTO (IN PIDPRODUCTO VARCHAR(10),IN PDESCRIPCION VARCHAR(10), IN PCOSTO NUMERIC(7,2), IN PPRECIO NUMERIC(7,2))
BEGIN
  INSERT INTO PRODUCTO VALUES  (PIDPRODUCTO, PDESCRIPCION , PCOSTO, PPRECIO);
END$$
DELIMITER ;

--PRUEBA
CALL PA_INSERTARPRODUCTO ('1', 'Chocolate', 3,3);