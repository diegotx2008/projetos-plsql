CREATE OR REPLACE TRIGGER TRG_TRAVA_AD_PLANROL
BEFORE UPDATE OR DELETE ON AD_PLANROL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
	IF(((:OLD.PRINCIPAL = 'SIM') AND (:NEW.PRINCIPAL <> 'SIM')) OR ((:OLD.PRINCIPAL IS NULL) AND (:NEW.PRINCIPAL = 'SIM')))THEN
		RAISE_APPLICATION_ERROR(-20101,'<br><font color="red" size="30px"><b>ATENÇÃO</b></font><br><font color="black" size="20px">Não é possível alterar o status do item principal ou marcar um item que não é principal, entre em contato com o time de Sistemas!</font><br>');
	END IF;           
END;