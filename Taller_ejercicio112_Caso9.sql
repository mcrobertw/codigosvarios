create table auditoria_basededatos(
ACCION_REALIZADA varchar2(30),
FECHA_ACCION date,
NOMBRE_USUARIO varchar(40)
)
create or replace trigger tr_auditoria_reparto
after insert or update or delete on reparto
DECLARE
  accion varchar2(20);

begin

  IF UPDATING THEN 
     accion:='actualizar';            
  ELSIF DELETING THEN 
        accion:='borrar';
  ELSE
      accion:='insertar';
  END IF;
  --
  INSERT INTO auditoria_basededatos 
        (ACCION_REALIZADA,
         FECHA_ACCION,
         NOMBRE_USUARIO
       )
  values(accion,
         sysdate,
         user
        ); 
end tr_auditoria_reparto;

---
INSERT INTO REPARTO(idprofesor,idasignatura,periodo,calificacion) VALUES(4,100,'2023-1',null);
select * from auditoria_basededatos;
UPDATE REPARTO set calificacion=10 where idprofesor=4;
select * from auditoria_basededatos;
