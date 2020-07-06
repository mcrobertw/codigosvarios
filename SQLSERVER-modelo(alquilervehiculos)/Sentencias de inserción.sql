insert into cliente values
(1,'Ingrid Fatima','Santana Sardi','1257894562','femenino','052487896','0982222222','ingrid@hotmail.com','C',0),
(2,'Fabián Alberto','Hidalgo Tigua','1257894585','masculino','05249896','0921111111','fabian@hotmail.com','B',1),
(3,'Liseth María','Jonioux Delgado','1285294585','femenino','052498876','0925555555','lissette@hotmail.com','B',0),
(4,'Orley Sebastian','Montanero Alcivar','1257874521','masculino','052748562','0983333333','orley@hotmail.com','C',1),
(5,'Jennifer María','Chávez Macías','1524789658','femenino','052452789','0927777777','jennifer@hotmail.com','C',1);


insert into marcavehiculo values (1,'hyundai'),(2,'chevrolet'),(3,'great wall'),(4,'toyota'),(5,'nissan'),(6,'kia');

insert into vehiculo values(1,1,90,'PZX-955','01-01-2020','24-12-2019'),(2,2,85,'ABC-123','03-03-2020','06-05-2020'),
						   (3,3,120,'MAB-444-','02-02-2020','11-10-2019'),(4,4,200,'XBA-987','03-04-2020','05-05-2020');
						   
insert into alquilervehiculo values
(1,1,'24-12-2019','Odontóloga por viaje a DeCameron','03-01-2020','lo trajo lavado',10,'carro sin problemas',10,'pago puntual y carro en buen estado'),
(3,3,'11-10-2019','Asesora gobierno viaja a Quito','15-10-2019','10000 km recorrido',10,'carro sin problemas',4,'pago puntual y carro desgastado');
						   

--Preguntas que se pueden hacer a la base de datos
-- ¿De que marcas de la base de datos no hay vehículos en el negocio? en este caso: no hay Nissan, ni Kia.
-- ¿Qué clientes no han alquilado vehículos? en este caso: Fabián, Orley, Jennifer.
-- ¿Qué carros de mi empresa no han sido alquilados todavía? en este caso: el chevrolet y el toyota





