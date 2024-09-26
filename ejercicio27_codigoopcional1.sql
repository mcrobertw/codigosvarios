/*==============================================================*/
/* Este código fue generado después de diseñar las tablas        */
/* utilizando la herramienta CASE PowerDesigner.                 */
/* El diseño de la base de datos sigue un enfoque estructurado,  */
/* pasando por tres fases:                                       */
/* - Modelo Conceptual: Definimos los principales conceptos      */
/*   (entidades como CLIENTE, VEHICULO y ALQUILER) y sus         */
/*   relaciones sin entrar en detalles técnicos.                 */
/* - Modelo Lógico: Refinamos el modelo añadiendo atributos      */
/*   a las entidades, claves primarias y relaciones más          */
/*   detalladas (por ejemplo, FOREIGN KEY), asegurándonos de que */
/*   siga reglas de normalización.                               */
/* - Modelo Físico: Generamos el esquema en un SGBD específico,  */
/*   en este caso PostgreSQL, definiendo tipos de datos exactos  */
/*   (por ejemplo, INT4, VARCHAR), índices, y constraints.       */
/*==============================================================*/


/*==============================================================*/
/* CREACIÓN DE LA TABLA: ALQUILER                                */
/*==============================================================*/
/* En el modelo conceptual, ALQUILER se definió como una entidad */
/* que representa la acción de alquilar un vehículo.             */
/* En el modelo lógico, se definieron los atributos clave:       */
/* - IDALQUILER: Identificador único del alquiler (clave primaria)*/
/* - IDVEHICULO: Relación con la entidad VEHICULO (clave foránea)*/
/* - IDCLIENTE: Relación con la entidad CLIENTE (clave foránea)  */
/* Ahora en el modelo físico, implementamos estos atributos como */
/* columnas con tipos de datos específicos.                     */

create table ALQUILER (
   IDALQUILER           INT4                 not null, /* PK del alquiler */
   IDVEHICULO           INT4                 not null, /* FK a la tabla VEHICULO */
   IDCLIENTE            INT4                 not null, /* FK a la tabla CLIENTE */
   constraint PK_ALQUILER primary key (IDALQUILER) /* Definición de la clave primaria */
);


/*==============================================================*/
/* CREACIÓN DE LA TABLA: CLIENTE                                 */
/*==============================================================*/
/* En el modelo conceptual, CLIENTE se definió como la entidad que*/
/* representa a las personas que alquilan los vehículos. En el    */
/* modelo lógico, agregamos atributos como:                       */
/* - IDCLIENTE: Identificador único del cliente (clave primaria)  */
/* - NOMBRE y APELLIDO: Datos de identificación del cliente.      */
/* En el modelo físico, estos atributos se implementan como       */
/* columnas con tipos de datos específicos.                      */

create table CLIENTE (
   IDCLIENTE            INT4                 not null, /* PK del cliente */
   NOMBRE               VARCHAR(30)          null,     /* Nombre del cliente */
   APELLIDO             VARCHAR(30)          null,     /* Apellido del cliente */
   constraint PK_CLIENTE primary key (IDCLIENTE) /* Clave primaria */
);


/*==============================================================*/
/* CREACIÓN DE LA TABLA: VEHICULO                                */
/*==============================================================*/
/* En el modelo conceptual, VEHICULO es la entidad que representa*/
/* los coches disponibles para alquilar. En el modelo lógico,    */
/* se definieron los atributos relevantes para esta entidad:     */
/* - IDVEHICULO: Identificador único del vehículo                */
/* - PLACA: Matrícula del coche                                  */
/* - MARCA: Marca del vehículo                                   */
/* En el modelo físico, se implementan estos atributos como      */
/* columnas con tipos de datos específicos.                     */

create table VEHICULO (
   IDVEHICULO           INT4                 not null, /* PK del vehículo */
   PLACA                VARCHAR(10)          null,     /* Matrícula del vehículo */
   MARCA                VARCHAR(30)          null,     /* Marca del vehículo */
   constraint PK_VEHICULO primary key (IDVEHICULO) /* Clave primaria */
);



/*==============================================================*/
/* DEFINICIÓN DE RELACIONES ENTRE LAS TABLAS                     */
/*==============================================================*/
/* En el modelo lógico, se establecieron las relaciones entre las */
/* entidades, por ejemplo, que cada ALQUILER debe estar asociado  */
/* a un CLIENTE y un VEHICULO. Estas relaciones se implementan    */
/* ahora en el modelo físico como claves foráneas (FOREIGN KEY).  */

/* Relacionamos la columna IDCLIENTE de ALQUILER con la tabla CLIENTE */
alter table ALQUILER
   add constraint FK_ALQUILER_CLIENTE_A_CLIENTE foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE)
      on delete restrict on update restrict;

/* Relacionamos la columna IDVEHICULO de ALQUILER con la tabla VEHICULO */
alter table ALQUILER
   add constraint FK_ALQUILER_VEHICULO__VEHICULO foreign key (IDVEHICULO)
      references VEHICULO (IDVEHICULO)
      on delete restrict on update restrict;


/*==============================================================*/
/* CONSULTAS E INSERCIÓN DE DATOS                                */
/*==============================================================*/

/* Consultas para verificar que las tablas se han creado correctamente */
select * from alquiler;
select * from cliente;
select * from vehiculo;

--Inserción de datos en la tabla CLIENTE. 
INSERT INTO CLIENTE (IDCLIENTE, NOMBRE, APELLIDO) 
VALUES (1, 'Jose', 'Alonzo'), 
       (2, 'Pedro', 'Chavez'), 
       (3, 'Miguel', 'Mera'),
       (4, 'Robert', 'Moreira'),
	   (5, 'Oscar', 'González'),

--Inserción de datos en la tabla VEHICULO 
INSERT INTO VEHICULO (IDVEHICULO, PLACA, MARCA) 
VALUES (1, 'ECU-719', 'Toyota'), 
       (2, 'HFB-301', 'Kia'), 
       (3, 'LAT-151', 'Chevrolet'),
       (4, 'GTR-456', 'Ferrary');

--Inserción de datos en la tabla ALQUILER 
INSERT INTO ALQUILER (IDALQUILER, IDVEHICULO, IDCLIENTE)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 3, 1),
(5, 1, 2),
(6, 1, 1),
(7, 2, 2),
(8, 1, 1),
(9, 2, 2),
(10, 2, 3),
(12, 4, 4);


/*==============================================================*/
/* BLOQUES DO CON CURSORES IMPLÍCITOS PARA CONTAR ALQUILERES POR */
/* VEHÍCULO Y POR CLIENTE                                        */
/*==============================================================*/

/* En PostgreSQL, los bloques DO permiten ejecutar código PL/pgSQL
   de forma dinámica. En estos bloques, se utiliza un **cursor implícito** 
   para iterar sobre los resultados de una consulta SELECT y procesar 
   cada fila individualmente. Este enfoque es útil cuando necesitamos 
   realizar operaciones sobre cada registro de manera secuencial. 

   A continuación, se utilizan dos bloques DO que recorren los registros 
   de las tablas VEHICULO y CLIENTE para contar cuántos vehículos ha alquilado 
   cada cliente, y cuántas veces ha sido alquilado cada vehículo.
*/

/*==============================================================*/
/* PRIMER BLOQUE: CONTAR CUÁNTAS VECES SE HA ALQUILADO CADA VEHÍCULO */
/*==============================================================*/
/* En este primer bloque DO, declaramos una variable tipo RECORD
   que actuará como el contenedor para cada fila obtenida en el 
   cursor implícito.
   
   - Se realiza un LEFT JOIN entre las tablas VEHICULO y ALQUILER 
     para obtener todos los vehículos, incluso aquellos que no 
     han sido alquilados (por eso usamos LEFT JOIN).
   - Luego, agrupamos los resultados por el ID del vehículo, la marca 
     y la placa, contando cuántas veces ha sido alquilado cada vehículo.

   Para cada registro procesado en el bucle, se utiliza la función 
   `raise notice` para mostrar los detalles del vehículo y el número 
   de veces que ha sido alquilado.
*/
do $$
declare
    registro RECORD; /* Variable de tipo RECORD para almacenar cada fila */
begin
    for registro in /* Inicio del cursor implícito que recorre cada fila obtenida */
        select ve.MARCA, ve.PLACA, count(al.IDALQUILER) as alquilado
        from VEHICULO ve
        left join ALQUILER al on ve.IDVEHICULO = al.IDVEHICULO
        group by ve.IDVEHICULO, ve.MARCA, ve.PLACA /* Agrupamos por vehículo */
    loop
        /* raise notice muestra un mensaje en la consola de PostgreSQL */
        raise notice 'Marca: % , Placa: % , Alquilado: %', 
            registro.MARCA, registro.PLACA, registro.alquilado;
    end loop; /* Fin del bucle FOR que recorre cada fila */
end $$;


/*==============================================================*/
/* SEGUNDO BLOQUE: CONTAR CUÁNTOS VEHÍCULOS HA ALQUILADO CADA CLIENTE */
/*==============================================================*/
/* El segundo bloque es muy similar al primero, pero en este caso
   contamos cuántos vehículos ha alquilado cada cliente. 

   - Realizamos un LEFT JOIN entre las tablas CLIENTE y ALQUILER para 
     obtener todos los clientes, incluso aquellos que no han alquilado 
     vehículos.
   - Agrupamos los resultados por el ID del cliente, su nombre y apellido, 
     y contamos cuántos vehículos ha alquilado cada cliente.
   
   Para cada cliente, mostramos su nombre, apellido y el número de 
   vehículos alquilados.
*/
do $$
declare
    registro RECORD; /* Variable de tipo RECORD para almacenar cada fila */
begin
    for registro in /* Inicio del cursor implícito que recorre cada fila obtenida */
        select cl.NOMBRE, cl.APELLIDO, count(al.IDVEHICULO) as alquilado
        from CLIENTE cl
        left join ALQUILER al on cl.IDCLIENTE = al.IDCLIENTE
        group by cl.IDCLIENTE, cl.NOMBRE, cl.APELLIDO /* Agrupamos por cliente */
    loop
        /* raise notice muestra un mensaje en la consola de PostgreSQL */
        raise notice 'Nombre y Apellido: % % , Alquilado: %', 
            registro.NOMBRE, registro.APELLIDO, registro.alquilado;
    end loop; /* Fin del bucle FOR que recorre cada fila */
end $$;

