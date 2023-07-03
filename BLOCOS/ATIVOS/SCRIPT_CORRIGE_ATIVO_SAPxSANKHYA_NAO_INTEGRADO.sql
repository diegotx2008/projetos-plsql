BEGIN

DECLARE

P_COUNT INT;

	CURSOR C1 IS (
		SELECT 
		 SAP.NUMDOCSAP
		,SP.AD_NUNOTA
		,SAP.CODITEM
		,SAP.CODATIVO
		,SAP.SEQ
		,SAP.DTENTSAP
		,SAP.DTNFENT
		,SAP.NSERIEATV
		,PRO.CODPROD
		FROM AD_INTATIVOSAPI SAP, TGFPRO PRO,AD_INTATIVOSAP SP
		WHERE 
				SAP.NUMDOCSAP  = SP.NUMDOCSAP
		AND     SAP.CODITEM = PRO.COMPLDESC
		AND     SAP.NSERIEATV IN(SELECT CP.CODBEM FROM AD_TCIBEMBACKUP CP WHERE CP.CODBEM  NOT IN (SELECT CODBEM FROM TCIBEM))
	);


BEGIN

	FOR R1 IN C1 LOOP
		
		SELECT COUNT(IBE.CODBEM) INTO P_COUNT FROM TCIIBE IBE WHERE IBE.CODBEM = R1.NSERIEATV;
		
		IF P_COUNT = 0 THEN
            FOR ATIVO IN (
               SELECT ATI.CODATIVO, ATI.NSERIEATV, ATI.DTINDEPREC, ATI.DTFIMDEPREC, ATI.NUMNFENT, ATI.DTNFENT,
                      DEP.PRCTRESIDUAL, DEP.PRECOCOMPRA, DEP.VLRADEPRECIAR, DEP.VLRRESIDUAL, DEP.VLRDEPRECIADO 
                FROM AD_INTATIVOSAPI ATI
                INNER JOIN AD_INTATIVOSAPD DEP ON (ATI.CODATIVO = DEP.CODATIVO)
                WHERE ATI.NUMDOCSAP = R1.NUMDOCSAP AND DEP.CODATIVO = R1.CODATIVO
            )
            LOOP
                VARIAVEIS_PKG.V_ATUALIZANDO := TRUE;

                INSERT INTO TCIIBE (NUNOTA,SEQUENCIA ,CODPROD ,CODBEM ,ORDEM, ATUALBEM)
                    VALUES (R1.AD_NUNOTA, R1.SEQ, R1.CODPROD, R1.NSERIEATV, R1.SEQ, STP_ATUALBEM_TGFTOP(6100));
                COMMIT;

                INSERT INTO TCIBEM (CODBEM, CODPROD, VLRDEP, VLRSALDO, DTCOMPRA, DTINICIODEP, DTFIMDEP, NUMNOTA,
                                    VLRAQUISICAO, CODEMP, DESCRABREV, AD_SALDORES, AD_PERCDEPRE, AD_CODSAP, AD_TAGRFID, NUNOTA, AD_CONTRATO175, AD_LOCAL_WMS, NUMCONTRATO)
                    VALUES (ATIVO.NSERIEATV, R1.CODPROD, ATIVO.VLRADEPRECIAR , ATIVO.VLRDEPRECIADO, ATIVO.DTNFENT, ATIVO.DTINDEPREC, ATIVO.DTFIMDEPREC, ATIVO.NUMNFENT,
                            ATIVO.PRECOCOMPRA, 20, 'TRANSFERIDO SAP', ATIVO.VLRRESIDUAL, ATIVO.PRCTRESIDUAL, ATIVO.CODATIVO, ATIVO.CODATIVO, R1.AD_NUNOTA, 14886, 'GDO', 0
                        );
                VARIAVEIS_PKG.V_ATUALIZANDO := FALSE;                        
			END LOOP;
		END IF;
	END LOOP;						
END;

END;