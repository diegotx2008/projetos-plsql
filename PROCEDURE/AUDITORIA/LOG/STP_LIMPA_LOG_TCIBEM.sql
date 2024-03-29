CREATE OR REPLACE PROCEDURE STP_LIMPA_LOG_TCIBEM AS
VL_CONT PLS_INTEGER := 0;
V_SEQ PLS_INTEGER := 0;

BEGIN

    FOR REC IN (
                SELECT ROWID AS RID 
                FROM AD_TCIBEMLOG 
                WHERE DHACAO <= SYSDATE-60
                ) LOOP
    
    DELETE AD_TCIBEMLOG WHERE ROWID = REC.RID;
    
    VL_CONT := VL_CONT+1;
    IF ((VL_CONT MOD 100) =0 ) THEN
        COMMIT;
    END IF;
    END LOOP;
    COMMIT;

END;