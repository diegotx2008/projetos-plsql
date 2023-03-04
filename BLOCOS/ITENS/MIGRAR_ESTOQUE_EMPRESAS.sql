BEGIN 

DECLARE
    CURSOR EMP_OLD IS(
                SELECT 
                 EST.CODEMP
                ,EST.CODPROD
                ,EST.CODLOCAL
                ,EST.CONTROLE
                ,EST.CODPARC
                ,EST.TIPO
                ,EST.ESTOQUE
                ,EST.ROWID
                FROM TGFEST EST 
                WHERE EST.CODPROD IN(
                                    18725,
                                    25791,
                                    25611,
                                    24797,
                                    24797,
                                    25611,
                                    27153,
                                    19034,
                                    22874,
                                    21296,
                                    26759,
                                    23344,
                                    26643
                                    )
                AND EST.CODLOCAL = 1030300
                AND EST.CODEMP = 1
    );

    BEGIN
    
        FOR R1 IN EMP_OLD LOOP
        
            INSERT INTO AD_TGFESTLOG
                    (CODEMP,CODLOCAL,CODPROD,CONTROLE,ESTOQUE,DATAOPERACAO)
            VALUES  (R1.CODEMP,R1.CODLOCAL,R1.CODPROD,R1.CONTROLE,R1.ESTOQUE,SYSTIMESTAMP);      
            
            
            UPDATE TGFEST EST
            SET 
             EST.CODPROD  = R1.CODPROD
            ,EST.CODLOCAL = R1.CODLOCAL
            ,EST.CONTROLE = R1.CONTROLE
            ,EST.CODPARC  = R1.CODPARC
            ,EST.TIPO     = R1.TIPO
            ,EST.ESTOQUE  = (EST.ESTOQUE + R1.ESTOQUE)
            WHERE   EST.CODEMP   = 21
            AND     EST.CODPROD  = R1.CODPROD
            AND     EST.CODLOCAL = R1.CODLOCAL;    
         
            DELETE 
            FROM TGFEST EST 
            WHERE EST.CODPROD = R1.CODPROD 
            AND EST.CODLOCAL  = R1.CODLOCAL
            AND EST.CODEMP    = 1
            AND EST.ROWID     = R1.ROWID;    
            
            --COMMIT;
        END LOOP;
    
    END;
END;