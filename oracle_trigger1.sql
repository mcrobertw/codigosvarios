create table cliente(
idcliente integer primary key,
nombrescliente varchar(30),
apellidoscliente varchar (30),
edad integer
)

select *from cliente;

--OPERACION INSERTAR
insert into cliente values(1,'Robert Wilfrido','Moreira Centeno',37);
insert into cliente 
    SELECT 2,'Gabriel Marcelo','Moreira Centeno',21 FROM dual UNION ALL
    SELECT 3,'Maria Jimena','Moreira Centeno',35 FROM dual

--OPERACIÓN ELIMINAR
DELETE FROM CLIENTE;

--OPERACIÓN ACTUALIZAR
UPDATE CLIENTE SET apellidoscliente='Moreira Hidalgo' where idcliente=1;




CREATE OR REPLACE TRIGGER TR_CLIENTE2
BEFORE
DELETE OR INSERT OR UPDATE ON CLIENTE
-- DISPARADOR A NIVEL DE SENTENCIA
DECLARE

BEGIN
    IF INSERTING THEN 
        DBMS_OUTPUT.PUT_LINE('INSERTANDO: '||USER);
    END IF;
    IF UPDATING THEN
         DBMS_OUTPUT.PUT_LINE('ACTUALIZANDO: '||USER);
    END IF;
    IF DELETING THEN 
     DBMS_OUTPUT.PUT_LINE('ELIMINANDO: '||USER);
    END IF;
    
END;