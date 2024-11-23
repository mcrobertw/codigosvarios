--BLOQUE DE CÓDIGO 1. (Línea 2 a 53)
drop table reparto;
drop table asignatura;
drop table profesor;

--Creación de tablas
create table profesor(
idprofesor int primary key,
nombresprofesor varchar2(30),
numeroasignaturas int default 0
)
create table asignatura(
idasignatura int primary key,
nombreasignatura varchar2(70),
idasignaturaprerequisito1 int,
idasignaturaprerequisito2 int,
CONSTRAINT fk_prerequisito1
  FOREIGN KEY(idasignaturaprerequisito1) references asignatura(idasignatura), 
CONSTRAINT fk_prerequisito2
  FOREIGN KEY(idasignaturaprerequisito2) references asignatura(idasignatura)
)

create table reparto(
 idprofesor int,
 idasignatura int,
 periodo varchar2(20),
 calificacion numeric(4,2),
 CONSTRAINT nuncamismasignaturaenperiodo primary key(idprofesor,idasignatura,periodo),
 CONSTRAINT fk_reparto_profesor
  FOREIGN KEY(idprofesor) references profesor(idprofesor),
 CONSTRAINT fk_reparto_asignatura
  FOREIGN KEY(idasignatura) references asignatura(idasignatura)
)

--Inserción de registros
INSERT INTO PROFESOR (idprofesor,nombresprofesor) VALUES (1,'Robert');
INSERT INTO PROFESOR (idprofesor,nombresprofesor) VALUES (2,'Gabriel');
INSERT INTO PROFESOR (idprofesor,nombresprofesor) VALUES (3,'Jimena');
INSERT INTO PROFESOR (idprofesor,nombresprofesor) VALUES (4,'Wilmer');
INSERT INTO ASIGNATURA(idasignatura,nombreasignatura) VALUES(100,'Estructura de Datos');
INSERT INTO ASIGNATURA(idasignatura,nombreasignatura) VALUES(101,'Programación orientada a objetos');
INSERT INTO ASIGNATURA VALUES(102,'Análisis  y Diseño de Bases de Datos',100,101);
INSERT INTO ASIGNATURA VALUES(103,'Gestión de Bases de datos',102,null);
INSERT INTO ASIGNATURA VALUES(104,'Ingeniería de software I',103,null);
select * from reparto;
select * from profesor;
select * from asignatura;
delete from reparto;


CREATE OR REPLACE TRIGGER trigger_profesor_f
BEFORE INSERT
ON reparto
FOR EACH ROW
DECLARE
    indicador1 number:=0;
    idmejorprofesor number:=0;
    mayorcalificaciondocente number:=0;
    excep exception;
	
	--Cursor explicito. Calificación docente que ha tenido cada profesor que ha dado la asignatura
    CURSOR c_comparacionprofesor is select reparto.idprofesor,reparto.calificacion from profesor, reparto,asignatura where profesor.idprofesor = reparto.idprofesor
                                                        AND asignatura.idasignatura = reparto.idasignatura 
														AND reparto.calificacion is not null
														AND reparto.idasignatura=:NEW.idasignatura;

begin
    --cursor implicito. Consultar si el profesor no ha tenido ninguna calificación docente
    select count(distinct(reparto.idasignatura)) INTO indicador1 from profesor, reparto,asignatura where profesor.idprofesor = reparto.idprofesor
            AND asignatura.idasignatura = reparto.idasignatura
			AND reparto.calificacion is not null
            AND profesor.idprofesor =:new.idprofesor;

    if indicador1>0 then
        idmejorprofesor:=:new.idprofesor;
        mayorcalificaciondocente:=:new.calificacion;
        for registro in c_comparacionprofesor 
        loop
            if (registro.calificacion>mayorcalificaciondocente) then
                mayorcalificaciondocente:=registro.calificacion;
                idmejorprofesor:=registro.idprofesor;
            end if;    
        end loop;
        if(idmejorprofesor!=:new.idprofesor) then
                 raise excep;
        end if;

    end if;
    exception
    when excep then
    RAISE_APPLICATION_ERROR(-20002, 'No se está asignando al mejor profesor.');

    
end;

INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(2,101,'2023-1');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(2,102,'2023-1');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(2,103,'2023-1');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(2,100,'2023-2');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(2,101,'2023-2');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(1,102,'2024-1');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(1,103,'2024-2');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(3,104,'2023-1');
INSERT INTO REPARTO(idprofesor,idasignatura,periodo) VALUES(3,100,'2022-2');

--PRUEBA 1: Insertar a un profesor nuevo en la asignatura
INSERT INTO REPARTO(idprofesor,idasignatura,periodo,calificacion) VALUES(1,102,'2023-2',5);
INSERT INTO REPARTO(idprofesor,idasignatura,periodo,calificacion) VALUES(2,102,'2024-1',7);
INSERT INTO REPARTO(idprofesor,idasignatura,periodo,calificacion) VALUES(1,102,'2025-1',4);
INSERT INTO REPARTO(idprofesor,idasignatura,periodo,calificacion) VALUES(4,102,'2025-2',null);

