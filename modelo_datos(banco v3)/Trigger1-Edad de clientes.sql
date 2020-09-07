create or replace TRIGGER TRCLIENTE_EDAD
AFTER 
INSERT or update ON CLIENTE
FOR EACH ROW 
declare
    excep exception;
    edadcliente number ;
BEGIN
    edadcliente := (sysdate - :new.FECHANACIMIENTOCLIENTE)/365;
    if (edadcliente < 16 or edadcliente >60)  then
        raise excep;
    end if;
    exception
    when excep then
    RAISE_APPLICATION_ERROR(-20002, 'EDAD ADMITIDA ESTA ENTRE 16 Y 60 AÑOS');
END;