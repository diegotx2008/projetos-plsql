BEGIN
/*
============================================================
AUTOR: Diego Teixeira de Almeida
DATA CRIAÇÃO:  27/02/2023
JUSTIFICATIVA: Migração de domínio microcity.com.br para voke.tech

============================================================
*/
DECLARE
    CURSOR C1 IS(
        SELECT 
         CODUSU
        ,USU.NOMEUSU
        ,USU.EMAIL
        ,USU.EMAILSOLLIB 
        FROM TSIUSU USU
        WHERE USU.EMAILSOLLIB IS NOT NULL
    );
BEGIN
    FOR R1 IN C1 LOOP
        UPDATE TSIUSU USU
        SET    USU.EMAILSOLLIB = R1.EMAIL
        WHERE  USU.CODUSU = R1.CODUSU;
    END LOOP;
END;
END;

