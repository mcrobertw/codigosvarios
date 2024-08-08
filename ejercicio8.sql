CREATE TABLE empleado (
idempleado INT PRIMARY KEY,
ci VARCHAR(10),
nombreempleado VARCHAR(30),
apellidosempleado VARCHAR(30),
sueldobase decimal (7,2)
);
 
CREATE TABLE vehiculo (
idvehiculo INT PRIMARY KEY,
marca VARCHAR(25),
color VARCHAR(25),
placa varchar (25),
anio int
);
 
CREATE TABLE lavadocarro (
idlavado INT PRIMARY KEY,
idempleado INT,
idvehiculo INT,
fechaingreso date,
fechasalida date,
valorservicio decimal (7,2),
FOREIGN KEY (idempleado) REFERENCES Empleado(idempleado),
FOREIGN KEY (idvehiculo) REFERENCES Vehiculo(idvehiculo)
);

-- CREACION DE LA FUNCION DEL TRIGGER
CREATE OR REPLACE FUNCTION public.control_valorservicio()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    sueldo_base DECIMAL(7,2); 
	total_valor_servicio DECIMAL(7,2); 
	fecha_existente DATE;
BEGIN
    -- Obtener el sueldo base del empleado
    SELECT sueldobase INTO sueldo_base 
    FROM Empleado 
    WHERE idempleado = NEW.idempleado;

    -- Verificar si ya existe un registro en el mismo mes para el empleado
    SELECT fechaingreso INTO fecha_existente
    FROM LAVADOCARRO
    WHERE idempleado = NEW.idempleado 
      AND DATE_TRUNC('month', fechaingreso) = DATE_TRUNC('month', NEW.fechaingreso);

    -- Calcular el total del valorservicio para el mes actual, incluyendo el nuevo registro
    SELECT COALESCE(SUM(valorservicio), 0) INTO total_valor_servicio
    FROM LAVADOCARRO
    WHERE idempleado = NEW.idempleado 
      AND DATE_TRUNC('month', fechaingreso) = DATE_TRUNC('month', NEW.fechaingreso);
    
    -- Añadir el valor del nuevo registro al total
    total_valor_servicio := total_valor_servicio + NEW.valorservicio;

    -- Verificar si el total supera la mitad del sueldo base
    IF total_valor_servicio > (sueldo_base / 2) THEN
        RAISE EXCEPTION 'La sumatoria del valorservicio en el mes no puede superar la mitad del sueldo base del empleado.';
    END IF;

    RETURN NEW;
END;
$BODY$;

-- CREACION DEL TRIGGER
CREATE TRIGGER trg_control_valorservicio
BEFORE INSERT ON LAVADOCARRO
FOR EACH ROW
EXECUTE FUNCTION public.control_valorservicio();

INSERT INTO lavadocarro (idlavado, idempleado, idvehiculo, fechaingreso, fechasalida, valorservicio) VALUES 
(1, 1, 1, '2024-08-01', CAST(null AS date), 60.00),
(2, 1, 2, '2024-08-10', CAST(null AS date), 40.00);
SELECT * FROM LAVADOCARRO;

INSERT INTO lavadocarro (idlavado, idempleado, idvehiculo, fechaingreso, fechasalida, valorservicio) VALUES 
(3, 1, 3, '2024-08-15', CAST(null AS date), 60.00);
SELECT * FROM LAVADOCARRO;
