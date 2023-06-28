create or replace PROCEDURE "STP_INC_TCICTA_PROD" (
       P_CODUSU NUMBER,        -- Código do usuário logado
       P_IDSESSAO VARCHAR2,    -- Identificador da execução. Serve para buscar informações dos parâmetros/campos da execução.
       P_QTDLINHAS NUMBER,     -- Informa a quantidade de registros selecionados no momento da execução.
       P_MENSAGEM OUT VARCHAR2 -- Caso seja passada uma mensagem aqui, ela será exibida como uma informação ao usuário.
) AS
       PARAM_CTADEBDEP VARCHAR2(4000);
       PARAM_CODHISDEP_DEB VARCHAR2(4000);
       PARAM_CTACREDCPTDEP VARCHAR2(4000);
       PARAM_CODHISCPTDEP_CRED VARCHAR2(4000);
       PARAM_CTADEBBXDEP VARCHAR2(4000);
       PARAM_CODHISBXDEP_DEB VARCHAR2(4000);
       PARAM_CTACREDBXDEP VARCHAR2(4000);
       PARAM_CODHISBXDEP_CRED VARCHAR2(4000);
       PARAM_CTADEBBXBEM VARCHAR2(4000);
       PARAM_CODHISBXBEM_DEB VARCHAR2(4000);
       PARAM_CTACREDCPTBXBEM VARCHAR2(4000);
       PARAM_CODHISBXBEM_CRED VARCHAR2(4000);
       PARAM_CODPROD VARCHAR2(4000);
       FIELD_CODPROD NUMBER;
BEGIN
/************************************************************************************************
NOME AUTOR: Diego Teixeira de Almeida
DATA......: 15/06/2023
BANCO DE DADOS: ORACLE
OBJETIVO..: Procedure do botão Cadastrar Contas contábeis da tela de produtos. Esse botão foi criado para poder cadastrar as contas do ativo para que possam depreciar, pois a tela está com um problema onde não está capturando o código do produto quando se tenta vincular as contas do ativo

PARAMETROS DE ENTRADA:
         Contas contábeis e histórico padrão, os mesmos campos contidos na tela Produtos->Bens->Contas do Produto.
EXEMPLO DE USO: Não se aplica
*************************************************************************************************/
       PARAM_CTADEBDEP := ACT_TXT_PARAM(P_IDSESSAO, 'CTADEBDEP');
       PARAM_CODHISDEP_DEB := ACT_TXT_PARAM(P_IDSESSAO, 'CODHISDEP_DEB');
       PARAM_CTACREDCPTDEP := ACT_TXT_PARAM(P_IDSESSAO, 'CTACREDCPTDEP');
       PARAM_CODHISCPTDEP_CRED := ACT_TXT_PARAM(P_IDSESSAO, 'CODHISCPTDEP_CRED');
       PARAM_CTADEBBXDEP := ACT_TXT_PARAM(P_IDSESSAO, 'CTADEBBXDEP');
       PARAM_CODHISBXDEP_DEB := ACT_TXT_PARAM(P_IDSESSAO, 'CODHISBXDEP_DEB');
       PARAM_CTACREDBXDEP := ACT_TXT_PARAM(P_IDSESSAO, 'CTACREDBXDEP');
       PARAM_CODHISBXDEP_CRED := ACT_TXT_PARAM(P_IDSESSAO, 'CODHISBXDEP_CRED');
       PARAM_CTADEBBXBEM := ACT_TXT_PARAM(P_IDSESSAO, 'CTADEBBXBEM');
       PARAM_CODHISBXBEM_DEB := ACT_TXT_PARAM(P_IDSESSAO, 'CODHISBXBEM_DEb');
       PARAM_CTACREDCPTBXBEM := ACT_TXT_PARAM(P_IDSESSAO, 'CTACREDCPTBXBEM');
       PARAM_CODHISBXBEM_CRED := ACT_TXT_PARAM(P_IDSESSAO, 'CODHISBXBEM_CRED');
       PARAM_CODPROD := ACT_TXT_PARAM(P_IDSESSAO, 'CODPROD');

       FOR I IN 1..P_QTDLINHAS 
       LOOP                    

            FIELD_CODPROD := ACT_INT_FIELD(P_IDSESSAO, I, 'CODPROD');
			IF PARAM_CODPROD = FIELD_CODPROD THEN
			/*Conta Contábil Depreciação*/
            INSERT INTO TCICTA(CODPROD,CODBEM,TIPO,CODCTACTB,CODHISTCTB)
            VALUES            (FIELD_CODPROD,'<TODOS>','D',PARAM_CTADEBDEP,PARAM_CODHISDEP_DEB);      

			/*Contra-Partida Depreciação*/		
            INSERT INTO TCICTA(CODPROD,CODBEM,TIPO,CODCTACTB,CODHISTCTB)
            VALUES            (FIELD_CODPROD,'<TODOS>','E',PARAM_CTACREDCPTDEP,PARAM_CODHISCPTDEP_CRED);   

			/*Conta Contábil Baixa Depreciação*/	
            INSERT INTO TCICTA(CODPROD,CODBEM,TIPO,CODCTACTB,CODHISTCTB)
            VALUES            (FIELD_CODPROD,'<TODOS>','X',PARAM_CTADEBBXDEP,PARAM_CODHISBXDEP_DEB);   
			
			/*Contra-Partida Baixa Depreciação*/
            INSERT INTO TCICTA(CODPROD,CODBEM,TIPO,CODCTACTB,CODHISTCTB)
            VALUES            (FIELD_CODPROD,'<TODOS>','1',PARAM_CTACREDBXDEP,PARAM_CODHISBXDEP_CRED);   
			
			/*Conta Contábil Baixa Bem*/
            INSERT INTO TCICTA(CODPROD,CODBEM,TIPO,CODCTACTB,CODHISTCTB)
            VALUES            (FIELD_CODPROD,'<TODOS>','B',PARAM_CTADEBBXBEM,PARAM_CODHISBXBEM_DEB);   			
			
			/*Contra-Partida Baixa Bem*/
            INSERT INTO TCICTA(CODPROD,CODBEM,TIPO,CODCTACTB,CODHISTCTB)
            VALUES            (FIELD_CODPROD,'<TODOS>','2',PARAM_CTACREDCPTBXBEM,PARAM_CODHISBXBEM_CRED);  	
            
            ELSE 
                P_MENSAGEM := '<br><h1>Você inseriu um produto diferente do selecionado, por gentileza confirme se é o mesmo produto';
            END IF;
       END LOOP;
END;
