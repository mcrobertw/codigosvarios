--En este ejercicio se trata de 
CREATE TABLE estudiante
(
    e_id integer NOT NULL,
    e_nombres character varying(40),
    e_apellidos character varying(40),
    nivel smallint,
    CONSTRAINT estudiante_pkey PRIMARY KEY (e_id),
    CONSTRAINT estudiante_nivel_check CHECK (nivel >= 0 AND nivel <= 10)
)

CREATE TABLE graduado
(
    g_id integer NOT NULL,
    g_nombres character varying(40),
    g_apellidos character varying(40),
    CONSTRAINT graduado_pkey PRIMARY KEY (g_id)
)	


create or replace function sp_estudiante_a_graduado() returns Trigger
as
$$
begin
	if new.nivel=0 then
		insert into "graduado" values (new.e_id,new.e_nombres,new.e_apellidos);
	end if;
	return new;
End
$$
Language plpgsql

create trigger TR_insert after insert or update on estudiante
for each row 
execute procedure sp_estudiante_a_graduado();

insert into estudiante values(1,'Juan','Piguave',3);
insert into estudiante values(2,'Lorenzo','Piguave',0);
insert into estudiante values(3,'Pepe','Manzaba',3);
insert into estudiante values(4,'Ines','Manzaba',3);
update estudiante set nivel=0 where e_apellidos='Manzaba';