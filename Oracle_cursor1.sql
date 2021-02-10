--BASE DE DATOS: https://github.com/mcrobertw/codigosvarios/blob/master/modelo_datos(banco%20v3)/sentencias%20de%20creaci%C3%B3n.sql
--SENTENCIAS DE INSERCIÓN: https://github.com/mcrobertw/codigosvarios/blob/master/modelo_datos(banco%20v3)/sentencias%20de%20inserci%C3%B3n.sql

--SGBD: Oracle
DECLARE
  valor varchar(2);
  CURSOR c_retornoclientes IS select apellidoscliente from cliente;  --CURSOR EXPLICITO (Defines y se ve algo)
BEGIN
    
    for registro in c_retornoclientes
    loop
        DBMS_OUTPUT.PUT_LINE('registro es:'||registro.apellidoscliente);
    end loop;
    
END;