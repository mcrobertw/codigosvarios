create table ESTUDIANTE (
   ID_ESTUDIANTE        INT4                 not null,
   NOMBRES_ESTUDIANTE   VARCHAR(30)          	 null,
   FECHAINGRESO_ESTUDIANTE DATE                	 null,
   NUMEROREPETICIONES_ESTUDIANTE serial      not null,
   constraint PK_ESTUDIANTE primary key (ID_ESTUDIANTE)
);

create table MATRICULA (
   ID_MATRICULA         INT4                 not null,
   ID_ESTUDIANTE        INT4                 not null,
   FECHA_MATRICULA      DATE                 null,
   NIVEL_MATRICULA      INT4                 null,
  constraint PK_MATRICULA primary key (ID_MATRICULA)

);

-- Llave foranea en la entidad Matricula 
alter table MATRICULA
add constraint FK_MATRICUL_TIENE_ESTUDIAN foreign key (ID_ESTUDIANTE)
references ESTUDIANTE (ID_ESTUDIANTE)
on delete cascade on update cascade;

insert into ESTUDIANTE (ID_ESTUDIANTE, NOMBRES_ESTUDIANTE, FECHAINGRESO_ESTUDIANTE, NUMEROREPETICIONES_ESTUDIANTE)
               values 
               (1, 'Andres', '12-02-2021',0),
               (2, 'Oscar', '12-02-2021',0),
               (3, 'Jeniffer', '12-02-2021',0);

--------------Ingresar datos en matrícula (PARA ANDRÉS)-------------------------
insert into MATRICULA (ID_MATRICULA,ID_ESTUDIANTE, FECHA_MATRICULA, NIVEL_MATRICULA)
			values  
					(101,1,'12-02-2021',1),
					(102,1,'12-08-2022',1),
               (103,1,'12-02-2023',1),
					(104,1,'12-08-2023',1);

--------------Ingresar datos en matrícula(PARA OSCAR)-------------------------
insert into MATRICULA (ID_MATRICULA,ID_ESTUDIANTE, FECHA_MATRICULA, NIVEL_MATRICULA)
			values  
					(105,2,'12-02-2021',1),
					(106,2,'12-08-2022',1),
               (107,2,'12-02-2023',1),
					(108,2,'12-08-2023',1),
               (109,2,'12-02-2024',2),
               (110,2,'12-08-2024',2),
					(111,2,'12-02-2025',2);

--------------Ingresar daros en matrícula(PARA JENNIFER)-------------------------
insert into MATRICULA (ID_MATRICULA,ID_ESTUDIANTE, FECHA_MATRICULA, NIVEL_MATRICULA)
			values  
					(112,3,'12-02-2021',1),
					(113,3,'12-08-2022',2),
					(114,3,'12-02-2025',3);

select * from estudiante;
select * from matricula;

Delete from estudiante;
Delete from matricula;

delete from matricula where id_matricula=105;

create function trigg_1() returns trigger
as 
$$
declare
   numeromatriculas integer;
begin 
  --Esta consulta funciona en temporalidad BEFORE, retorna para cada estudiante que se inserte el número de matrículas que ha tenido
  --en un nivel, si la consulta no retornase nada, quiere decir que no ha estado matriculado antes en ese nivel
  
  IF (TG_OP = 'INSERT') THEN
   select  count(*) into numeromatriculas from matricula where id_estudiante=NEW.ID_ESTUDIANTE and nivel_matricula=NEW.NIVEL_MATRICULA group by id_estudiante, nivel_matricula;
   --FORMA 1, de interpretar la condición
      --Al haber registros coincidiendo estudiante y nivel, y al mismo tiempo estar ejecutando una operación de inserción para ese 
      --mismo estudiante en el mismo nivel, quiere decir que hay repetición, y por tanto se suma 1.
   
   --FORMA 2, de interpretar la condición
      --La consulta retorna el número de matrículas existentes para un estudiante, al estar el trigger en temporalidad BEFORE,
      --si no retorna valores, quiere decir que es la primera vez que un estudiante se matricula en ese nivel.
   if (numeromatriculas is not null) then
      UPDATE ESTUDIANTE SET NUMEROREPETICIONES_ESTUDIANTE = NUMEROREPETICIONES_ESTUDIANTE+1 WHERE ID_ESTUDIANTE=NEW.ID_ESTUDIANTE;
   end if;
   return new;--Cuando se trabaja con trigger en pgsql tienes que retornar NEW (para los insert)
  END IF;
  
  IF (TG_OP = 'DELETE') THEN
   select  count(*) into numeromatriculas from matricula where id_estudiante=OLD.ID_ESTUDIANTE and nivel_matricula=OLD.NIVEL_MATRICULA group by id_estudiante, nivel_matricula;
   if (numeromatriculas is not null) then
      if(numeromatriculas>1)then
         UPDATE ESTUDIANTE SET NUMEROREPETICIONES_ESTUDIANTE = NUMEROREPETICIONES_ESTUDIANTE-1 WHERE ID_ESTUDIANTE=OLD.ID_ESTUDIANTE;
      end if;  
      RETURN old; --Cuando se trabaja con trigger en pgsql tienes que retornar old (para los update y delete)
   end if;
   
  END IF;
end
$$
language plpgsql

---- Trigger a ejecutar en tabla específica----------------
create trigger trigg_1 before insert or delete on MATRICULA
for each row
execute procedure trigg_1()