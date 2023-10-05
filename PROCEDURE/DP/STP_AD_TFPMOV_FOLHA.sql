create or replace PROCEDURE "STP_AD_TFPMOV_FOLHA" (
       P_CODUSU NUMBER,       
       P_IDSESSAO VARCHAR2,    
       P_QTDLINHAS NUMBER,     
       P_MENSAGEM OUT VARCHAR2 
) AS
       PARAM_CODEVENTO 	VARCHAR2(4000);
       PARAM_DTREF  	DATE;
       FIELD_NUNICO 	NUMBER;

/************************************************************************************************
NOME AUTOR: Diego Teixeira de Almeida
DATA......: 04/10/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Pegar os valores importados da planilha na AD_TFPMOVI para então inserir na TFPMOV.

*************************************************************************************************/   

       CURSOR C1 IS 
        SELECT 
		     I.CODEMP
		    ,I.CODEVENTO
		    ,I.CODFUNC
		    ,I.CODUSU
		    ,I.DTALTER
		    ,NVL(I.INDICE,0) AS INDICE
		    ,I.NUNICO
		    ,I.OBS
		    ,I.REFERENCIA
		    ,I.SEQ
		    ,I.SEQUENCIA
		    ,I.TIPEVENTO
		    ,I.TIPMOV
		    ,NVL(I.VLRMOV,0) AS VLRMOV
            ,I.UNIDADE
        FROM AD_TFPMOV T
        INNER JOIN AD_TFPMOVI I ON I.NUNICO = T.NUNICO        
        WHERE T.NUNICO = FIELD_NUNICO
        AND I.STATUS IS NULL
        GROUP BY 
          	 I.CODEMP
		    ,I.CODEVENTO
		    ,I.CODFUNC
		    ,I.CODUSU
		    ,I.DTALTER
		    ,I.INDICE
		    ,I.NUNICO
		    ,I.OBS
		    ,I.REFERENCIA
		    ,I.SEQ
		    ,I.SEQUENCIA
		    ,I.TIPEVENTO
		    ,I.TIPMOV
		    ,I.VLRMOV
            ,I.UNIDADE
        ORDER BY 2;
BEGIN


       FOR I IN 1..P_QTDLINHAS 
       LOOP                    

			  FIELD_NUNICO := ACT_INT_FIELD(P_IDSESSAO, I, 'NUNICO');

              FOR R1 IN C1 LOOP
                 INSERT INTO TFPMOV (REFERENCIA, CODEMP, CODFUNC, TIPMOV, CODEVENTO, SEQUENCIA, TIPEVENTO, VLRMOV, INDICE, UNIDADE, CODUSU)
                 VALUES (R1.REFERENCIA, R1.CODEMP, R1.CODFUNC, R1.TIPMOV,R1.CODEVENTO,R1.SEQ,R1.TIPEVENTO,R1.VLRMOV, R1.INDICE, R1.UNIDADE, P_CODUSU);

                 UPDATE AD_TFPMOVI SET STATUS = 'S' WHERE NUNICO = FIELD_NUNICO AND SEQ = R1.SEQ;
              END LOOP;

       END LOOP;
  P_MENSAGEM := 'Valores importados com sucesso!';

END;