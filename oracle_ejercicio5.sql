--Creación de tablas
create table Persona(
    idpersona int primary key,
    nombres varchar(30),
    apellidos varchar(30),
    genero varchar(2),
    idpadre int,
    idmadre int,
    constraint fk_padre foreign key(idpadre) references persona(idpersona),
    constraint fk_madre foreign key(idmadre) references persona(idpersona)
)

--Inserción de registros
insert into persona(idpersona,nombres,apellidos,genero,idpadre,idmadre) 
    SELECT 1,'Luis','Moreira','M',null,null FROM dual UNION ALL
    SELECT 2,'Carmen','Hidalgo','F',null,null  FROM dual UNION ALL
    SELECT 3,'Gualberto','Centeno','M',null,null  FROM dual UNION ALL
    SELECT 4,'Hermelinda','Ganchozo','F',null,null  FROM dual UNION ALL
    SELECT 5,'Isabela','Moreira','F',1,null  FROM dual UNION ALL
    SELECT 6,'Angela','Moreira','F',1,2  FROM dual UNION ALL
    SELECT 7,'Wilfrido','Moreira','M',1,2  FROM dual UNION ALL
    SELECT 8,'Auxiliadora','Centeno','F',3,4  FROM dual UNION ALL
    SELECT 9,'Leonardo','Centeno','M',3,4  FROM dual UNION ALL
    SELECT 10,'Doris','Veliz','M',null,null  FROM dual UNION ALL
    SELECT 11,'Mayra','Villavicencio','F',null,null  FROM dual UNION ALL
    SELECT 12,'Robert','Moreira','M',7,8  FROM dual UNION ALL
    SELECT 13,'Jimena','Moreira','F',7,8  FROM dual UNION ALL
    SELECT 14,'Cesar','Valdiviezo','M',null,null  FROM dual UNION ALL
    SELECT 15,'Adrián','Centeno','M',9,10  FROM dual UNION ALL
    SELECT 16,'Amaia','Moreira','F',12,11  FROM dual UNION ALL
    SELECT 17,'Dante','Moreira','M',12,11  FROM dual UNION ALL
    SELECT 18,'Abdiel','Valdiviezo','M',14,13  FROM dual UNION ALL
    SELECT 19,'Cael','Valdiviezo','M',14,13  FROM dual


--Consulta 1. ¿Cuántos hijos tiene cada persona?
---Solución 1: Vía SQL
    ----Hallazgo 1. En esta consulta básica se consigue a cada persona con los hijos que tiene, los que no tienen se muestran con null
    select t1.idpersona, t1.nombres, t1.apellidos, t2.nombres as hijo from persona t1 left join persona t2 
        on t1.idpersona=t2.idpadre or t1.idpersona=t2.idmadre order by t1.idpersona;
    
    ---Hallazgo 2. En el conjunto de filas que se obtienen en esta consulta, se muestra un "1" por cada hijo de cada persona, "0" en el caso que no tenga
    select t1.idpersona, t1.nombres, t1.apellidos,
    (CASE t2.nombres WHEN NVL(t2.nombres,0) then '1' else '0' end) as conteohijo 
    from persona t1 left join persona t2 on t1.idpersona=t2.idpadre or t1.idpersona=t2.idmadre order by t1.idpersona;

    ---Hallazgo 3. Consulta definitiva
    select idpersona, nombres, apellidos, sum(conteohijo) as numerohijos 
    from(
        select t1.idpersona, t1.nombres, t1.apellidos,(CASE t2.nombres WHEN NVL(t2.nombres,0) then '1' else '0' end) as conteohijo
        from persona t1 left join persona t2 on t1.idpersona=t2.idpadre or t1.idpersona=t2.idmadre order by t1.idpersona
    ) group by idpersona, nombres, apellidos order by numerohijos;


---Solución 2: Vía CURSOR
DECLARE
  conteohijos number:=0;
  CURSOR c_personas IS select idpersona, nombres, apellidos from persona;
  CURSOR c_relacionparentesco IS select t1.idpersona, t1.nombres, t1.apellidos, t2.nombres as hijo from persona t1 left join persona t2 on t1.idpersona=t2.idpadre or t1.idpersona=t2.idmadre order by t1.idpersona;
BEGIN
    for registro in c_personas
    loop
        for registro2 in c_relacionparentesco
        loop
            if(registro2.idpersona=registro.idpersona and registro2.hijo is not null) then
                conteohijos:=conteohijos+1;
            end if;
        end loop;
        DBMS_OUTPUT.PUT_LINE('NOMBRES: '||registro.nombres||' '||registro.apellidos||CHR(9)||'NÚMEROHIJOS: '||conteohijos);
        conteohijos:=0;  
    end loop;
END;