insert into cliente values(1,'1111','Gómez','Dayanna','09-09-1985');
insert into cliente values(2,'2222','Loor','Geovanna','10-07-1990');

insert into prestamo values (100,1,'14-02-2020',250,'');
insert into prestamo values (99,1,'14-02-2020',100,'');


--Solicitud que activa disparador en la tabla CLIENTE
insert into cliente values(3,'3333','Moreira','Amaia','08-06-2020');

--Solicitud que activa disparador en la tabla PAGO
insert into pago values(1,100,'07-09-2020',200,50);
insert into pago values(1,100,'07-09-2020',200,0);

