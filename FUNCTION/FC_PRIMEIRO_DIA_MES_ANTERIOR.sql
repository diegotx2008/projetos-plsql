CREATE OR REPLACE FUNCTION FC_PRIMEIRO_DIA_MES_ANTERIOR(P_DATE  DATE,P_MES NUMBER)
RETURN DATE
IS 
  RESULT DATE;
   
/************************************************************************************************
NOME AUTOR:     Diego Teixeira de Almeida
DATA......:     27/09/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Retorna o primeiro dia do mês de acordo com o parâmetro P_MES se for 1 retorna o mês anterior, se 2 retorna 2 meses atrás a...

PARAMETROS DE ENTRADA:
         P_DATE: Data base para referência
         P_MES:  Numero de meses que quer retornar

EXEMPLO DE USO: SELECT FC_PRIMEIRO_DIA_MES_ANTERIOR('01/10/2023',1) FROM DUAL
*************************************************************************************************/  
BEGIN
  SELECT ADD_MONTHS(TRUNC(P_DATE, 'MM'),-P_MES) INTO RESULT
  FROM DUAL;
  RETURN RESULT; 
END;