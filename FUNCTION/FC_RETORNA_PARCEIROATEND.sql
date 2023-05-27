create or replace FUNCTION FC_RETORNA_PARCEIROATEND(P_NUNOTA INT,P_NUMCONTRATO INT)
RETURN VARCHAR
IS
V_PARCEIROATEND VARCHAR2(100);
/*
***********************************************************************************************
NOME AUTOR: Diego Teixeira de Almeida
DATA......: 10/05/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Retorna a o parceiro de atendimento

PARAMETROS DE ENTRADA:
         P_NUNOTA:       Numero único da AD_PLANROL
         P_NUMCONTRATO:  Numero do contrato da AD_PLANROL                                      

EXEMPLO DE USO: SELECT FC_RETORNA_PARCEIROATEND( 1244794, 18321) FROM DUAL
************************************************************************************************
*/
BEGIN

     SELECT WM_CONCAT(DISTINCT D.NUNICOPARC||'-'||PP.RAZAOSOCIAL)
     INTO V_PARCEIROATEND
     FROM AD_PLANEPARCATEND D 
     INNER JOIN  AD_GESTPARCP P ON P.NUNICO = D.NUNICOPARC 
     INNER JOIN TGFPAR PP ON PP.CODPARC = P.CODPARC
     WHERE  D.NUMCONTRATO = P_NUMCONTRATO AND D.NUNOTA = P_NUNOTA;


     RETURN     V_PARCEIROATEND; 
END;