CREATE OR REPLACE TRIGGER TRG_INC_UPD_AD_TFPMOVI
AFTER INSERT OR UPDATE ON  AD_TFPMOVI FOR EACH ROW

DECLARE

/************************************************************************************************
NOME AUTOR: Diego Teixeira de Almeida
DATA......: 03/10/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Trigger criada para evitar de que sejam importados dados duplicados na tabela
*************************************************************************************************/
P_COUNT INT;

PRAGMA AUTONOMOUS_TRANSACTION;   

BEGIN
        P_COUNT:=0;
     
        SELECT COUNT(CODFUNC)
        INTO  P_COUNT
        FROM  AD_TFPMOVI MV
        WHERE MV.REFERENCIA = :NEW.REFERENCIA
        AND   MV.NUNICO = :NEW.NUNICO
        AND   MV.CODEMP = :NEW.CODEMP
        AND   MV.CODFUNC = :NEW.CODFUNC;
        
        IF(P_COUNT > 0) THEN
           RAISE_APPLICATION_ERROR
                                  (-20101,'
                                  <div>
                                      <h1><font color="#990000">ATENÇÃO</font></h1>                                  
                                      <b>Os dados da planilha já foram importados ou existem dados duplicados!</b>
                                  </div>
                                  <br><br><br>
                                  ');
        END IF;             
    
    END;
