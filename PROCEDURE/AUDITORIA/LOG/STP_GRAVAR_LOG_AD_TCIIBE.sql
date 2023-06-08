create or replace PROCEDURE "STP_GRAVAR_LOG_AD_TCIIBELOG"
(
	P_OBJETO IN VARCHAR2,
	P_CHAVE  IN VARCHAR2,
	P_CODUSU IN INT,
	P_ACAO   IN VARCHAR2,
	P_NUNOTA IN INT,
	P_SEQUENCIA IN INT,
	P_SEQUENCIA_OLD IN INT,
	P_CODPROD IN INT,
	P_CODPROD_OLD IN INT,
	P_CODBEM IN INT,
	P_CODBEM_OLD IN INT,
	P_CODUSU_OLD IN INT
)
AS
BEGIN 
DECLARE     

			V_USUARIO_BANCO 	VARCHAR2(60);
            V_USUARIO_REDE  	VARCHAR2(60);
            V_NOMEMAQUINA   	VARCHAR2(60);
            V_IPMAQUINA     	VARCHAR2(60);
            V_PROGRAMA      	VARCHAR2(60);
            V_USUARIOSIS    	VARCHAR2(60);
            V_CODUSUAUX     	VARCHAR2(100);
			V_CURRENT_SCHEMA 	VARCHAR2(100);
			V_NLS_TERRITORY 	VARCHAR2(100);
			V_OS_USER 			VARCHAR2(100);           
			DATAOPERACAO 	 	TIMESTAMP DEFAULT SYSTIMESTAMP;
            V_NUNICO            INT;


BEGIN 



    IF (P_CODUSU IS NULL) OR (P_CODUSU = 0) THEN

      V_CODUSUAUX := TSIUSU_LOG_PKG.V_CODUSULOG;
      V_USUARIOSIS := TSIUSU_LOG_PKG.V_NOMEUSULOG;

    ELSE

      V_CODUSUAUX := P_CODUSU;

      BEGIN

        SELECT 
			 USU.NOMEUSU 
		INTO V_USUARIOSIS 
		FROM TSIUSU USU 
		WHERE USU.CODUSU = V_CODUSUAUX;

      EXCEPTION WHEN NO_DATA_FOUND THEN
        V_USUARIOSIS := 'USUARIO NAO LOCALIZADO NA TSIUSU ' || V_CODUSUAUX;
      END;

    END IF;

    SELECT   
        USERNAME, 
        OSUSER,
        MACHINE,
        SYS_CONTEXT('USERENV','IP_ADDRESS'),
        PROGRAM,
		SYS_CONTEXT('USERENV','CURRENT_SCHEMA'),
		SYS_CONTEXT('USERENV','NLS_TERRITORY'),
		SYS_CONTEXT('USERENV','OS_USER')
    INTO
        V_USUARIO_BANCO,
        V_USUARIO_REDE,
        V_NOMEMAQUINA,
        V_IPMAQUINA,
        V_PROGRAMA,
		V_CURRENT_SCHEMA,
		V_NLS_TERRITORY,
		V_OS_USER
    FROM
        V$SESSION
    WHERE  AUDSID = (SELECT USERENV('SESSIONID') FROM DUAL)
        AND ROWNUM = 1;

    STP_KEYGEN_TGFNUM('AD_TCIIBE',1,'AD_TCIIBE', 'NUNOTA', 0, V_NUNICO);

    V_CODUSUAUX  := TSIUSU_LOG_PKG.V_CODUSULOG;

    INSERT INTO AD_TCIIBELOG
    (
        NUNICO,
        OBJETO,
        DHACAO,
        ACAO,
        USUBANCO,
        USUREDE,
        NOMEMAQUINA,
        IPMAQUINA,
        PROGRAMA,
        USULANC,
        CHAVE,
		DATAOPERACAO,
        AD_CURRENT_SCHEMA,
		AD_NLS_TERRITORY,
		AD_OS_USER,
        CODUSUSANKHYA,		
		NUNOTA,
		SEQUENCIA, 
		SEQUENCIA_OLD,
		CODPROD, 
		CODPROD_OLD,
		CODBEM,
		CODBEM_OLD,
		CODUSU,
		CODUSU_OLD
    )
    VALUES
    (
        V_NUNICO,
        P_OBJETO,
        SYSTIMESTAMP,
        P_ACAO,		
        V_USUARIO_BANCO,
        V_USUARIO_REDE,
        V_NOMEMAQUINA,
        V_IPMAQUINA,
        V_PROGRAMA,
        V_USUARIOSIS,
		P_CHAVE,
		SYSDATE,
		V_CURRENT_SCHEMA,
		V_NLS_TERRITORY,
		V_OS_USER,
        V_CODUSUAUX,
		P_NUNOTA,		
		P_SEQUENCIA, 
		P_SEQUENCIA_OLD,
		P_CODPROD, 
		P_CODPROD_OLD,
		P_CODBEM,
		P_CODBEM_OLD,
		P_CODUSU,
		P_CODUSU_OLD        
    );
END;

END;
