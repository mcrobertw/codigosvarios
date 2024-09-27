--CREAMOS LA TABLA CLIENTE 
create table CLIENTE 
(
   ID_CLIENTE           INTEGER              not null,
   NOMBRES              VARCHAR2(30)         not null,
   APELLIDOS            VARCHAR2(30)         not null,
   constraint PK_CLIENTE primary key (ID_CLIENTE)
);

--CREAMOS LA TABLA VEHICULO
create table VEHICULO 
(
   ID_VEHICULO          INTEGER              not null,
   MARCA                VARCHAR2(30)         not null,
   PLACA                VARCHAR2(30)         not null,
   constraint PK_VEHICULO primary key (ID_VEHICULO)
);

--CREAMOS LA TABLA ALQUILER ** escribì mal "ALQUILER"**
create table ALQUILER 
(
   IDALQUILER             INTEGER              not null,
   ID_VEHICULO          INTEGER              not null,
   ID_CLIENTE           INTEGER              not null,
   constraint PK_ALQUILER primary key (IDALQUILER, ID_VEHICULO, ID_CLIENTE)
);

alter table ALQUILER
   add constraint FK_ALQUILER_RELATIONS_VEHICULO foreign key (ID_VEHICULO)
      references VEHICULO (ID_VEHICULO);

alter table ALQUILER
   add constraint FK_ALQUILER_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE);
      
      SELECT * FROM CLIENTE;  --Selecciona todas las columnas de la tabla CLIENTE.
      SELECT * FROM VEHICULO; --Selecciona todas las columnas de la tabla VEHICULO.
      SELECT * FROM ALQUILER; --Selecciona todas las columnas de la tabla ALQUILER. 
      
--CLIENTES
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES, APELLIDOS) VALUES (1, 'Robert', 'Moreira');
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES, APELLIDOS) VALUES (2, 'Ana', 'Mora'); 
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES, APELLIDOS) VALUES (3, 'Marcelo', 'Nieto');
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES, APELLIDOS) VALUES (4, 'Josue', 'Palma');
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES, APELLIDOS) VALUES (5, 'Yimmi', 'Leonel');
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRES, APELLIDOS) VALUES (6, 'Jostin', 'Nieto');

--VEHICULOS
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (100, 'Hyundai', 'PZQ-904');
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (101, 'Kia', 'AZQ-977');
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (102, 'Mitsubishi', 'MBA-007');  
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (103, 'BYD', 'MBT-987');  
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (104, 'NISSAN', 'MHU-143');  
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (105, 'CHEVROLET', 'MHY-854');  
INSERT INTO VEHICULO (ID_VEHICULO, MARCA, PLACA) VALUES (7, 'CHERY', 'MNR-726');  

--ALQUILERES
--EL CLIENTE 1 (ROBERT MOREIRA), alquiló varios carros 10 veces
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (1, 100, 1);  
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (2, 102, 2);  
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (3, 100, 2); 
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (4, 102, 3);  
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (5, 102, 3);  
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (6, 103, 3);  
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (7, 104, 4);  
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (8, 105, 4); 
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (9, 100, 4); 
INSERT INTO ALQUILER (IDALQUILER, ID_VEHICULO, ID_CLIENTE) VALUES (10, 100, 4);


--CURSOR1: muestra la cantidad de veces que un cliente alquiló un carro
                 
  DECLARE --DECLARE: Inicia una sección donde se declaran variables y cursores.
  CONTEOCLIENTE_ALQUILER number:=0; --CONTEOCLIENTE_ALQUILER number:=0;: Declara una variable CONTEOCLIENTE_ALQUILER y la inicializa en 0, para contar el número de veces que un cliente ha alquilado.
  CURSOR c_cliente IS select id_cliente, nombres, apellidos from cliente; --DECLARAR CURSOR
  CURSOR c_relacioncliente IS SELECT  cliente.ID_CLIENTE, cliente.NOMBRES, cliente.APELLIDOS FROM cliente RIGHT JOIN ALQUILER ON cliente.ID_CLIENTE = ALQUILER.ID_CLIENTE; --DECLARAR CURSOR CON la RELACIÓN CLIENTE-ALQUILER
                                
BEGIN
    for registro in c_cliente --Inicia un bucle que itera sobre cada registro del cursor c_cliente.
    loop
        for registro2 in c_relacioncliente --Inicia un segundo bucle que itera sobre cada registro del cursor c_relacioncliente.
        loop
            if(registro2.id_cliente=registro.id_cliente and registro2.nombres is not null) then --Comprueba si el id_cliente del segundo registro coincide con el del primer registro y que el nombre no sea nulo.
                CONTEOCLIENTE_ALQUILER:=CONTEOCLIENTE_ALQUILER+1; --Si la condición anterior es verdadera, incrementa el contador de alquileres de ese cliente.
            end if;
        end loop;
        DBMS_OUTPUT.PUT_LINE('NOMBRES: '||registro.nombres||' '||registro.apellidos||CHR(9)||'ALQUILÒ: '||CONTEOCLIENTE_ALQUILER||' VECES'); --Imprime el nombre del cliente y el número de veces que ha alquilado.
        CONTEOCLIENTE_ALQUILER:=0;  --Reinicia el contador para el siguiente cliente.
    end loop;
END;

--CURSOR 2: muestra la cantidad de veces que un vehiculo fue alquilado


  DECLARE --Inicia otra sección de declaración de variables y cursores.
  CONTEOVEHICULO_ALQUILER number:=0; --Declara una variable CONTEOVEHICULO_ALQUILER e inicializa en 0, para contar el número de veces que un vehículo ha sido alquilado.
  CURSOR c_vehiculo IS select id_vehiculo, placa, marca from vehiculo; --Declara un cursor c_vehiculo que selecciona id_vehiculo, placa y marca de la tabla vehiculo.
  CURSOR c_relacionvehiculo IS SELECT VEHICULO.ID_VEHICULO, VEHICULO.PLACA, VEHICULO.MARCA FROM VEHICULO RIGHT JOIN ALQUILER ON VEHICULO.ID_VEHICULO = ALQUILER.ID_VEHICULO;--DECLARAR CURSOR CON la RELACIÓN VEHICULO-ALQUILER
BEGIN
    for registro3 in c_vehiculo --Inicia un bucle que itera sobre cada registro del cursor c_vehiculo.
    loop
        for registro4 in c_relacionvehiculo --Inicia un segundo bucle que itera sobre cada registro del cursor c_relacionvehiculo.
        loop
            if(registro4.id_vehiculo=registro3.id_vehiculo and registro4.marca is not null) then --Comprueba si el id_vehiculo del cuarto registro coincide con el del tercero y que la marca no sea nula.
                CONTEOVEHICULO_ALQUILER:=CONTEOVEHICULO_ALQUILER+1; --Si la condición anterior es verdadera, incrementa el contador de alquileres de ese vehículo.
            end if;
        end loop;
        DBMS_OUTPUT.PUT_LINE('VEHICULO: '||registro3.marca||' '||registro3.placa||CHR(9)||'SE ALQUILÓ: '||CONTEOVEHICULO_ALQUILER||' VECES'); --Imprime la marca y placa del vehículo junto con el número de veces que ha sido alquilado.
        CONTEOVEHICULO_ALQUILER:=0;  --Reinicia el contador para el siguiente vehículo.
    end loop;
END;
