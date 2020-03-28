--Definición de la relación
CREATE TABLE LIBRO(
	idlibro serial constraint pk_libro primary key,
	nombrelibro varchar(40),
	numeropaginas integer,
	isbn varchar(20)
)

--Operación de inserción
insert into libro values(1,'1984',213,'980-12-2075-9'),(2,'Introducción a la computación',704,'9788478291397');

--Definición del cursor
do $$
	declare
		registro Record;
		Cur_libros	Cursor for select * from "libro" order by "nombrelibro";
	begin
		open Cur_libros;
		fetch Cur_libros into registro;
		fetch Cur_libros into registro;
		Raise Notice 'Libro: %, Isbn: %',registro.nombrelibro, registro.isbn;
end $$
language 'plpgsql';
