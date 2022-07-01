DROP TABLE LIBRO;

CREATE TABLE LIBRO(
	idlibro integer PRIMARY KEY,
	nombrelibro varchar(50),
	numeropaginas integer,
	isbn varchar(20)
)

insert into libro(idlibro,nombrelibro,numeropaginas,isbn) 
    SELECT 1,'EL DESAFÍO DE LA INNOVACIÓN','148','978-959-16-1026-3' FROM dual UNION ALL
    SELECT 2,'Fundamentos de sistemas operativos','828','84-481-4641-7' FROM dual

insert all
    into libro values (3,'UML Aplicaciones en Java y C++','411','978-84-9964-516-2')
    into libro values (4,'Ingeniería del software un enfoque práctico','777','978-607-15-0314-5')
select * from dual;

create or replace trigger tr_comprobar--(TRIGGER A NIVEL DE SENTENCIA)
after insert
on libro

declare

begin
    DBMS_OUTPUT.PUT_LINE('Contando ejecución trigger');
end;

create or replace trigger tr_comprobar--(TRIGGER A NIVEL DE FILA)
after insert
on libro
for each row
declare

begin
    DBMS_OUTPUT.PUT_LINE('Contando ejecución trigger');
end;

select * from libro;
delete from libro;