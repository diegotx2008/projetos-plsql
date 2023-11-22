create or replace FUNCTION FC_GET_REGIAO_ENTREGA(P_CODPARC IN NUMBER)
RETURN VARCHAR2
IS
    P_EXTENSO VARCHAR2 (4000);
BEGIN
/************************************************************************************************
NOME AUTOR: Diego Teixeira de Almeida
DATA......: 16/11/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Retorna a cidade concatenada com o estado

PARAMETROS DE ENTRADA:
         P_CODPARC: Código do parceiro                                     

EXEMPLO DE USO: SELECT FC_GET_REGIAO_ENTREGA(12345) FROM DUAL
*************************************************************************************************/
    SELECT 
        (UPPER(CID.NOMECID)||'-' ||UPPER(UFS.UF))  
        INTO P_EXTENSO
    FROM 
        TGFPAR PAR, TSICID CID, TSIUFS UFS
    WHERE
        PAR.CODCID = CID.CODCID AND
        CID.UF = UFS.CODUF AND
        PAR.CODPARC = P_CODPARC ; 
    RETURN TRIM(P_EXTENSO);

END;