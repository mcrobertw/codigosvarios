create table DEUDA(
	iddeuda INTEGER not null constraint DEUDA_PK_IDDEUDA primary key(iddeuda),
	idcliente INTEGER constraint DEUDA_FKDEUDACLIENTE_idcliente foreign key  references CLIENTE(idcliente),
	descripcion_deuda VARCHAR(90),
	montooriginal NUMERIC(7,2),
	montopendiente NUMERIC(7,2) check (montopendiente<=montooriginal),
	estado VARCHAR(30) check (estado='PENDIENTE' OR estado='VIGENTE'),
);