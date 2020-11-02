create or replace TRIGGER TR_PAGO
before INSERT OR UPDATE ON PAGO
FOR EACH ROW 
declare
    totalpagos number:=0;
    montooriginal number:=0;
    excep exception;
BEGIN
    select sum(valorpago) into totalpagos from pago where idprestamo=:new.idprestamo;
    if(totalpagos is null) then --para evitar que este en nulo la variable "totalpagos" para cuando no hay pagos de las deudas
        totalpagos:=0;
    end if;
    --DBMS_OUTPUT.PUT_LINE('total de pagos antes del insert o update: '||totalpagos);
    select sum(totalprestamo) into montooriginal from prestamo where idprestamo=:new.idprestamo;
    --DBMS_OUTPUT.PUT_LINE('Monto original de prestamo es: '||montooriginal);
    if ((totalpagos+:new.valorpago)>montooriginal)  then
        raise excep;
    end if;
    
exception
    when excep then
    RAISE_APPLICATION_ERROR(-20002, 'Cliente esta pagando más de lo que debe');
END TR_PAGO;