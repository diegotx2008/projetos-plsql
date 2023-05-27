CREATE OR REPLACE TRIGGER TRG_INC_UPD_DLT_AD_TCIBEM_LOG
BEFORE  INSERT OR UPDATE OR DELETE  ON TCIBEM FOR EACH ROW

DECLARE 

	P_ACAO      VARCHAR2(10); 
	P_CHAVEPK   VARCHAR(400);
    P_CODUSU    INT;


BEGIN

    P_CHAVEPK := ''||:NEW.CODBEM||'';
    P_CODUSU := TSIUSU_LOG_PKG.V_CODUSULOG;

  IF INSERTING THEN  

	IF :NEW.CODEMP IS NOT NULL THEN   
        STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODEMP',P_CODUSU,'INSERT',:NEW.CODEMP,' ');
	END IF; 

	IF :NEW.CODPROD IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODPROD',P_CODUSU,'INSERT',:NEW.CODEMP,' ');  
	END IF; 

	IF :NEW.CODBEM IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODBEM',P_CODUSU,'INSERT',:NEW.CODBEM,' ');  
	END IF; 

	IF :NEW.NUMCONTRATO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'NUMCONTRATO',P_CODUSU,'INSERT',:NEW.NUMCONTRATO,' ');  
	END IF; 

	IF :NEW.NUNOTASAIDA IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'NUNOTASAIDA',P_CODUSU,'INSERT',:NEW.NUNOTASAIDA,' ');
	END IF; 

	IF :NEW.AD_CODSAP IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_CODSAP',P_CODUSU,'INSERT',:NEW.AD_CODSAP,' ');
	END IF; 

	IF :NEW.AD_LEASING IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_LEASING',P_CODUSU,'INSERT',:NEW.AD_LEASING,' ');
	END IF; 			

	IF :NEW.TEMDEPRECIACAO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'TEMDEPRECIACAO',P_CODUSU,'INSERT',:NEW.TEMDEPRECIACAO,' ');
	END IF; 	

	IF :NEW.VLRAQUISICAO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRAQUISICAO',P_CODUSU,'INSERT',:NEW.VLRAQUISICAO,' ');
	END IF; 		

	IF :NEW.VLRDEP IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRDEP',P_CODUSU,'INSERT',:NEW.VLRDEP,' ');
	END IF; 

	IF :NEW.AD_SALDORES IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_SALDORES',P_CODUSU,'INSERT',:NEW.AD_SALDORES,' ');
	END IF; 

	IF :NEW.VLRSALDO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRSALDO',P_CODUSU,'INSERT',:NEW.VLRSALDO,' ');
	END IF;     

	IF :NEW.AD_VLRCOMPLEM IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_VLRCOMPLEM',P_CODUSU,'INSERT',:NEW.AD_VLRCOMPLEM,' ');
	END IF; 

    IF TO_CHAR(:NEW.AD_DTENTRADA,'DD/MM/YYYY HH24:MM:SS') IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_DTENTRADA',P_CODUSU,'INSERT',TO_CHAR(:NEW.AD_DTENTRADA,'DD/MM/YYYY HH24:MM:SS'),' ');
	END IF; 

    IF TO_CHAR(:NEW.DTINICIODEP,'DD/MM/YYYY HH24:MM:SS') IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'DTINICIODEP',P_CODUSU,'INSERT',TO_CHAR(:NEW.DTINICIODEP,'DD/MM/YYYY HH24:MM:SS'),' ');
	END IF; 

	IF TO_CHAR(:NEW.DTFIMDEP,'DD/MM/YYYY HH24:MM:SS') IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'DTFIMDEP',P_CODUSU,'INSERT',TO_CHAR(:NEW.DTFIMDEP,'DD/MM/YYYY HH24:MM:SS'),' ');
	END IF; 

    RETURN;

  ELSIF DELETING THEN 

	P_CHAVEPK := :OLD.CODBEM;

	IF :OLD.CODEMP IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODEMP',P_CODUSU,'DELETE',' ',:OLD.CODEMP);
	END IF;  

	IF :OLD.CODPROD IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODPROD',P_CODUSU,'DELETE',' ',:OLD.CODPROD);
	END IF;  

	IF :OLD.CODBEM IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODBEM',P_CODUSU,'DELETE',' ',:OLD.CODBEM);
	END IF;  

	IF :OLD.NUMCONTRATO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'NUMCONTRATO',P_CODUSU,'DELETE',' ',:OLD.NUMCONTRATO);
	END IF;  

	IF :OLD.NUNOTASAIDA IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'NUNOTASAIDA',P_CODUSU,'DELETE',' ',:OLD.NUNOTASAIDA);
	END IF;  

	IF :OLD.AD_CODSAP IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_CODSAP',P_CODUSU,'DELETE',' ',:OLD.AD_CODSAP);
	END IF;  

	IF :OLD.AD_LEASING IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_LEASING',P_CODUSU,'DELETE',' ',:OLD.AD_LEASING);
	END IF; 

	IF :OLD.TEMDEPRECIACAO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'TEMDEPRECIACAO',P_CODUSU,'DELETE',' ',:OLD.TEMDEPRECIACAO);
	END IF; 	

	IF :OLD.VLRAQUISICAO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRAQUISICAO',P_CODUSU,'DELETE',' ',:OLD.VLRAQUISICAO);
	END IF;

	IF :OLD.VLRDEP IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRDEP',P_CODUSU,'DELETE',' ',:OLD.VLRDEP);
	END IF;

	IF :OLD.AD_SALDORES IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_SALDORES',P_CODUSU,'DELETE',' ',:OLD.AD_SALDORES);
	END IF;

	IF :OLD.VLRSALDO IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRSALDO',P_CODUSU,'DELETE',' ',:OLD.VLRSALDO);
	END IF;    

	IF :OLD.AD_VLRCOMPLEM IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_VLRCOMPLEM',P_CODUSU,'DELETE',' ',:OLD.AD_VLRCOMPLEM);
	END IF;

	IF TO_CHAR(:OLD.DTINICIODEP,'DD/MM/YYYY HH24:MM:SS') IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'DTINICIODEP',P_CODUSU,'DELETE',' ',TO_CHAR(:OLD.DTINICIODEP,'DD/MM/YYYY HH24:MM:SS'));
	END IF; 

	IF TO_CHAR(:OLD.DTFIMDEP,'DD/MM/YYYY HH24:MM:SS') IS NOT NULL THEN   
		STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'DTFIMDEP',P_CODUSU,'DELETE',' ',TO_CHAR(:OLD.DTFIMDEP,'DD/MM/YYYY HH24:MM:SS'));
	END IF; 

    RETURN;

  ELSIF UPDATING THEN 
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODEMP', P_CODUSU, 'UPDATE',:NEW.CODEMP,:OLD.CODEMP);
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODPROD', P_CODUSU, 'UPDATE',:NEW.CODPROD,:OLD.CODPROD);
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'CODBEM', P_CODUSU, 'UPDATE',:NEW.CODBEM,:OLD.CODBEM);    
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'NUMCONTRATO', P_CODUSU, 'UPDATE',:NEW.NUMCONTRATO,:OLD.NUMCONTRATO);  
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'NUNOTASAIDA', P_CODUSU, 'UPDATE',:NEW.NUNOTASAIDA,:OLD.NUNOTASAIDA);  
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_CODSAP', P_CODUSU, 'UPDATE',:NEW.AD_CODSAP,:OLD.AD_CODSAP);  
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_LEASING', P_CODUSU, 'UPDATE',:NEW.AD_LEASING,:OLD.AD_LEASING);  	
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'TEMDEPRECIACAO', P_CODUSU, 'UPDATE',:NEW.TEMDEPRECIACAO,:OLD.TEMDEPRECIACAO); 	
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRAQUISICAO', P_CODUSU, 'UPDATE',:NEW.VLRAQUISICAO,:OLD.VLRAQUISICAO); 	
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRDEP', P_CODUSU, 'UPDATE',:NEW.VLRDEP,:OLD.VLRDEP); 	
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_SALDORES', P_CODUSU, 'UPDATE',:NEW.AD_SALDORES,:OLD.AD_SALDORES); 	
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'VLRSALDO', P_CODUSU, 'UPDATE',:NEW.VLRSALDO,:OLD.VLRSALDO); 
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'AD_VLRCOMPLEM', P_CODUSU, 'UPDATE',:NEW.AD_VLRCOMPLEM,:OLD.AD_VLRCOMPLEM); 		
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'DTINICIODEP', P_CODUSU, 'UPDATE',TO_CHAR(:NEW.DTINICIODEP,'DD/MM/YYYY HH24:MM:SS'),TO_CHAR(:OLD.DTINICIODEP,'DD/MM/YYYY HH24:MM:SS'));
    STP_GRAVAR_LOG_TCIBEM('TCIBEM', P_CHAVEPK,'DTFIMDEP', P_CODUSU, 'UPDATE',TO_CHAR(:NEW.DTFIMDEP,'DD/MM/YYYY HH24:MM:SS'),TO_CHAR(:OLD.DTFIMDEP,'DD/MM/YYYY HH24:MM:SS'));

    RETURN;
  END IF;

END;