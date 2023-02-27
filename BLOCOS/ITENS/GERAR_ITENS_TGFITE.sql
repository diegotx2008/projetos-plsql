BEGIN
/*
============================================================
AUTOR: Diego Teixeira de Almeida
DATA CRIAÇÃO:  27/02/2023
JUSTIFICATIVA: Gerar os itens faltantes originados da sequela da substituição

============================================================
*/
DECLARE
    CURSOR C1 IS(
             SELECT * FROM  TGFITE 
			 WHERE NUNOTA = 1203374 
			 AND SEQUENCIA = 1             
				);    
    BEGIN 
        FOR R1 IN C1 LOOP
            INSERT INTO TCIIBE(NUNOTA,SEQUENCIA,CODPROD,CODBEM,ATUALBEM,ORDEM)
            VALUES (R1.NUNOTA,R1.SEQUENCIA,R1.CODPROD,'XXXXXX','T',R1.SEQUENCIA);
        END LOOP;
    END;
END;
