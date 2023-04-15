CREATE OR REPLACE PROCEDURE STP_GRAVA_DADOS_AD_TSIDATABASE
AS
BEGIN   
DECLARE

    V_NUNICO  INT;   A

    CURSOR C1 IS
    (
         SELECT * FROM
         (SELECT
         SEGMENT_NAME,
         SEGMENT_TYPE,
         BYTES/1024/1024/1024 GB,
         TABLESPACE_NAME
         FROM
         DBA_SEGMENTS
         ORDER BY 3 DESC ) WHERE
         ROWNUM <= 300
    ); 
    BEGIN

        FOR R1 IN C1 LOOP

            STP_KEYGEN_TGFNUM('AD_TSIDATABASE',1,'AD_TSIDATABASE', 'NUNICO', 0, V_NUNICO);

            INSERT INTO AD_TSIDATABASE(NUNICO,OBJETO,TIPO,TAMANHO,TABLESPACE,DATAREGISTRO)
            VALUES                    (V_NUNICO,R1.SEGMENT_NAME,R1.SEGMENT_TYPE,R1.GB,R1.TABLESPACE_NAME,SYSDATE);
        END LOOP;       

    END;

END;