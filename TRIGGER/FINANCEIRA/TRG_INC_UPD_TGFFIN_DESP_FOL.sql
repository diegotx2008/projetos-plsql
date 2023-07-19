create or replace TRIGGER TRG_INC_UPD_TGFFIN_DESP_FOL
BEFORE INSERT OR UPDATE ON  TGFFIN FOR EACH ROW
WHEN (NEW.CODNAT IN (10030100,10031400))
BEGIN

/************************************************************************************************
NOME AUTOR: Diego Teixeira de Almeida
DATA......: 19/07/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Trigger criada para que quando houver lançamentos com determinadas naturezas que elas seja feitas com os devidos centros de resultado
*************************************************************************************************/


	IF (:NEW.CODNAT = 10030100) THEN         
		:NEW.CODCENCUS:= 540201;
	END IF;

	IF (:NEW.CODNAT IN (10031400)) THEN
		:NEW.CODCENCUS:= 500112;      
	END IF;


END;