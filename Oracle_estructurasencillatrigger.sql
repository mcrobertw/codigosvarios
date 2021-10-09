--TABLA
create table PAGO 
(
   IDPAGO               INTEGER              not null,
   IDPRESTAMO           INTEGER,
   FECHAPAGO            DATE,
   VALORPAGO            NUMBER(10,2),
   SALDOPENDIENTEDEUDA  NUMBER(10,2),
   constraint PK_PAGO primary key (IDPAGO)
);

--TRIGGER
CREATE OR REPLACE TRIGGER  TR_PAGO --EN SQLSER NO EXISTE "OR REPLACE"
BEFORE
UPDATE OR INSERT OR DELETE ON PAGO
FOR EACH ROW
DECLARE

BEGIN
    DBMS_OUTPUT.PUT_LINE('HOLA ANTES DE INSERCIÓN');

END;