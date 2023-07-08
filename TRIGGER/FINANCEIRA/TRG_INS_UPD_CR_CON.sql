create or replace TRIGGER TRG_INS_UPD_CR_CON
BEFORE INSERT OR UPDATE ON SANKHYA.TCSCON
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  
    P_CODCENCUS  TCSCON.CODCENCUS%TYPE := :NEW.CODCENCUS;

BEGIN

/*CRIADO: CASSIO COSTA  16/01/15 17:40HS
SOLICITANTE: MARCIO FATURAMENTO  (IN0199928)

*/
IF  :NEW.CODCENCUS IN(280401,280402,280103,240407,280301,280201,240404)  THEN 
    RAISE_APPLICATION_ERROR(-20101, '<br><br><b><h1><font color="#990000" size="30px">ATENÇÃO</font></h1></b><br> <font size="20px">Verifique se o Centro de Resultado está correto, caso tenha dúvidas entre em contato com o setor de Controladoria</font><br><br>');
END IF; 


END;