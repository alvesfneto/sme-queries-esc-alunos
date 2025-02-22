/*****ESTA ROTINA BAIXA AS TABELAS DO DIA ANTERIOR 
      DA BASE PRODAM/EOL ESPELHO SE1426_SScommand:workbench.trust.manage
*****/

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_MUNICIPIO')
DROP TABLE M_MUNICIPIO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_MUNICIPIO								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[MUNICIPIO]  
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_HISTORICO_UNIDADE')
DROP TABLE M_HISTORICO_UNIDADE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_HISTORICO_UNIDADE								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[historico_unidade]  
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ESCOLA')
DROP TABLE M_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ESCOLA								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ESCOLA  
GO
---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_SERIE_ENSINO')
DROP TABLE M_SERIE_ENSINO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_SERIE_ENSINO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SERIE_ENSINO	   
GO

---------------  		
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_UNIDADE_EDUCACAO')
DROP TABLE M_UNIDADE_EDUCACAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_UNIDADE_EDUCACAO					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.UNIDADE_EDUCACAO	
GO
	
-------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_ESCOLA')
DROP TABLE M_TIPO_ESCOLA	
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_ESCOLA							
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_ESCOLA
GO
       							
-------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_UNIDADE_EDUCACAO')
DROP TABLE M_TIPO_UNIDADE_EDUCACAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_UNIDADE_EDUCACAO				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_UNIDADE_EDUCACAO 
GO

---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_UNIDADE_ADMINISTRATIVA')
DROP TABLE M_UNIDADE_ADMINISTRATIVA        						 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_UNIDADE_ADMINISTRATIVA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.UNIDADE_ADMINISTRATIVA
GO
         					
---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_UNIDADE_ADMINISTRATIVA')
DROP TABLE M_TIPO_UNIDADE_ADMINISTRATIVA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_UNIDADE_ADMINISTRATIVA			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_UNIDADE_ADMINISTRATIVA  
GO
    		 
----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_LOGRADOURO')
DROP TABLE M_TIPO_LOGRADOURO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_LOGRADOURO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_LOGRADOURO
GO

---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_DISPOSITIVO_COMUNICACAO_UNIDADE')
DROP TABLE M_DISPOSITIVO_COMUNICACAO_UNIDADE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_DISPOSITIVO_COMUNICACAO_UNIDADE		
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.DISPOSITIVO_COMUNICACAO_UNIDADE
GO

--------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_DISTRITO_MEC')
DROP TABLE M_DISTRITO_MEC
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_DISTRITO_MEC						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.DISTRITO_MEC
GO

----------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ETAPA_ENSINO')
DROP TABLE M_ETAPA_ENSINO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ETAPA_ENSINO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ETAPA_ENSINO
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_MODALIDADE_ENSINO')
DROP TABLE M_MODALIDADE_ENSINO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_MODALIDADE_ENSINO					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MODALIDADE_ENSINO
GO

---------------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_DEPENDENCIA_ADMINISTRATIVA')
DROP TABLE Db_Local.DBO.D_TIPO_DEPENDENCIA_ADMINISTRATIVA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_DEPENDENCIA_ADMINISTRATIVA		
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_DEPENDENCIA_ADMINISTRATIVA
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_CORRESPONDENCIA_SERIE_EOL')
DROP TABLE Db_Local.DBO.D_CORRESPONDENCIA_SERIE_EOL
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_CORRESPONDENCIA_SERIE_EOL			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.CORRESPONDENCIA_SERIE_EOL

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_AMBIENTE_ESCOLA')
DROP TABLE Db_Local.DBO.D_AMBIENTE_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_AMBIENTE_ESCOLA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.AMBIENTE_ESCOLA  A 
--WHERE  EXISTS (SELECT * FROM D_TURMA_ESCOLA B WHERE A.CD_AMBIENTE_ESCOLA = B.CD_AMBIENTE_ESCOLA)
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_AMBIENTE')
DROP TABLE Db_Local.DBO.D_TIPO_AMBIENTE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_AMBIENTE						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_AMBIENTE
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_DURACAO_TIPO_TURNO')
DROP TABLE Db_Local.DBO.D_DURACAO_TIPO_TURNO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_DURACAO_TIPO_TURNO					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[DURACAO_TIPO_TURNO] 
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_NECESSIDADE_ESPECIAL_ALUNO')
DROP TABLE Db_Local.DBO.D_NECESSIDADE_ESPECIAL_ALUNO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_NECESSIDADE_ESPECIAL_ALUNO			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[NECESSIDADE_ESPECIAL_ALUNO] 
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_PROGRAMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_PROGRAMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_PROGRAMA_ESCOLA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[PROGRAMA_ESCOLA]
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_SUB_PREFEITURA')
DROP TABLE Db_Local.DBO.D_SUB_PREFEITURA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_SUB_PREFEITURA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[SUB_PREFEITURA]
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_MATRICULA_TURMA_ESCOLA_INDICACAO')
DROP TABLE Db_Local.DBO.D_MATRICULA_TURMA_ESCOLA_INDICACAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_MATRICULA_TURMA_ESCOLA_INDICACAO	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MATRICULA_TURMA_ESCOLA_INDICACAO MTEI 
GO


-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_PRIORIDADE_LISTA')
DROP TABLE Db_Local.DBO.D_TIPO_PRIORIDADE_LISTA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_PRIORIDADE_LISTA	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_PRIORIDADE_LISTA A 

GO
-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_FAIXA_SERIE')
DROP TABLE Db_Local.DBO.D_FAIXA_SERIE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_FAIXA_SERIE	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.FAIXA_SERIE

GO
-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_SOLICITACAO_MATRICULA_PREFERENCIAL')
DROP TABLE Db_Local.DBO.M_SOLICITACAO_MATRICULA_PREFERENCIAL
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_SOLICITACAO_MATRICULA_PREFERENCIAL	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SOLICITACAO_MATRICULA_PREFERENCIAL A 
WHERE DT_FIM IS NULL

GO
-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ALUNO_CLASSIFICADO_TRANSPORTE')
DROP TABLE Db_Local.DBO.D_ALUNO_CLASSIFICADO_TRANSPORTE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ALUNO_CLASSIFICADO_TRANSPORTE	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ALUNO_CLASSIFICADO_TRANSPORTE A 
WHERE DT_FIM IS NULL


--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_SOLICITACAO_MATRICULA')
DROP TABLE M_SOLICITACAO_MATRICULA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_SOLICITACAO_MATRICULA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SOLICITACAO_MATRICULA
WHERE AN_LETIVO > 2010
CREATE INDEX INDEX_M_CD_ALUNO ON M_SOLICITACAO_MATRICULA (CD_ALUNO)
CREATE INDEX INDEX_M_CD_SOLICITACAO_MATRICULA ON M_SOLICITACAO_MATRICULA (CD_SOLICITACAO_MATRICULA)
CREATE INDEX INDEX_M_CD_UNIDADE_EDUCACAO ON M_SOLICITACAO_MATRICULA (CD_UNIDADE_EDUCACAO)
CREATE INDEX INDEX_M_CD_MICRO_REGIAO ON M_SOLICITACAO_MATRICULA (CD_MICRO_REGIAO)
GO
--select * from D_SOLICITACAO_MATRICULA
--------------        						 
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_SOLICITACAO_MATRICULA_PRIORIDADE')
DROP TABLE M_SOLICITACAO_MATRICULA_PRIORIDADE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_SOLICITACAO_MATRICULA_PRIORIDADE	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SOLICITACAO_MATRICULA_PRIORIDADE  
GO


--------------  
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ALUNO')
DROP TABLE M_ALUNO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ALUNO								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ALUNO 
	CREATE INDEX INDEX_M_ALUNO ON M_ALUNO (CD_ALUNO) 
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TURMA_ESCOLA')
DROP TABLE M_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TURMA_ESCOLA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA WHERE AN_LETIVO  > 2020

		CREATE INDEX INDEX_M_TURMA_ESCOLA ON M_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_DIA_SEMANA_AULA_TURMA')
DROP TABLE Db_Local.DBO.D_DIA_SEMANA_AULA_TURMA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_DIA_SEMANA_AULA_TURMA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.[DIA_SEMANA_AULA_TURMA] A 
WHERE EXISTS (SELECT B.CD_TURMA_ESCOLA FROM D_TURMA_ESCOLA B WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA)
	CREATE INDEX INDEX_M_DIA_SEMANA_AULA_TURMA ON M_DIA_SEMANA_AULA_TURMA (CD_TURMA_ESCOLA)
GO
--select * from D_DIA_SEMANA_AULA_TURMA
--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_MATRICULA')
DROP TABLE M_MATRICULA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_MATRICULA							
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MATRICULA  WHERE AN_LETIVO  > 2022

CREATE INDEX INDEX_M_MATRICULA ON M_MATRICULA (CD_MATRICULA)
GO


--SELECT * FROM D_MATRICULA WHERE AN_LETIVO='2024'
--------------    
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_HISTORICO_MATRICULA')
DROP TABLE M_HISTORICO_MATRICULA  		
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_HISTORICO_MATRICULA					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA WHERE AN_LETIVO  > 2020   
	CREATE INDEX INDEX_M_HISTORICO_MATRICULA ON M_HISTORICO_MATRICULA (CD_MATRICULA)
GO
--select * from D_HISTORICO_MATRICULA
--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_MATRICULA_TURMA_ESCOLA')
DROP TABLE M_MATRICULA_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_MATRICULA_TURMA_ESCOLA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MATRICULA_TURMA_ESCOLA A 
WHERE EXISTS (SELECT B.CD_MATRICULA FROM D_MATRICULA B WHERE A.CD_MATRICULA = B.CD_MATRICULA)      				

CREATE INDEX INDEX_M_MATRICULA_TURMA_ESCOLA ON M_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
GO
--select * from D_MATRICULA_TURMA_ESCOLA
----------------
/*IF EXISTS 
(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_HISTORICO_MATRICULA_TURMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_HISTORICO_MATRICULA_TURMA_ESCOLA	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA A 
WHERE EXISTS (SELECT B.CD_TURMA_ESCOLA FROM  DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA B 
WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND B.AN_LETIVO  > 2020)
	CREATE INDEX INDEX_M_HISTORICO_MATRICULA_TURMA_ESCOLA ON M_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
	CREATE INDEX INDEX_M_CD_TURMA_ESOCLA ON M_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO


IF EXISTS 
(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_HISTORICO_MATRICULA_TURMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA


SELECT * INTO Db_Local.DBO.M_HISTORICO_MATRICULA_TURMA_ESCOLA

 FROM OPENQUERY ( DB_EDUCACAO_1_PRODAM ,'SELECT *, GETDATE() AS CRDATE FROM SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA' ) A


WHERE EXISTS (SELECT B.CD_TURMA_ESCOLA FROM  DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA B 
WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND B.AN_LETIVO  > 2020)
	CREATE INDEX INDEX_M_HISTORICO_MATRICULA_TURMA_ESCOLA ON M_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
	CREATE INDEX INDEX_M_CD_TURMA_ESOCLA ON M_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO
*/
-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_MICRO_REGIAO')
DROP TABLE M_MICRO_REGIAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_MICRO_REGIAO						
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.MICRO_REGIAO') 
GO

---------------   
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ENDERECO_ALUNO')
DROP TABLE M_ENDERECO_ALUNO		    			
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ENDERECO_ALUNO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ENDERECO_ALUNO 
CREATE INDEX INDEX_CD_ALUNO ON M_ENDERECO_ALUNO (CD_ALUNO)
CREATE INDEX INDEX_CI_ENDERECO ON M_ENDERECO_ALUNO (CI_ENDERECO)
CREATE INDEX INDEX_CD_ENDERECO_ALUNO ON M_ENDERECO_ALUNO (CD_ENDERECO_ALUNO)
GO
   							
--------------
--select * from M_ENDERECO_ALUNO_TIPO_ENDERECO
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ENDERECO_ALUNO_TIPO_ENDERECO')
DROP TABLE M_ENDERECO_ALUNO_TIPO_ENDERECO	
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ENDERECO_ALUNO_TIPO_ENDERECO		
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ENDERECO_ALUNO_TIPO_ENDERECO	 
CREATE INDEX INDEX_CD_ENDERECO_ALUNO ON M_ENDERECO_ALUNO_TIPO_ENDERECO (CD_ENDERECO_ALUNO) --erro em 23082023
GO
--select * from D_ENDERECO_ALUNO_TIPO_ENDERECO
----------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_FAIXA_SERIE')
DROP TABLE M_FAIXA_SERIE	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_FAIXA_SERIE							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.FAIXA_SERIE') 


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_RESPONSAVEL_ALUNO')
DROP TABLE M_RESPONSAVEL_ALUNO	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_RESPONSAVEL_ALUNO							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426.DBO.RESPONSAVEL_ALUNO') 
CREATE INDEX INDEX_RESPONSAVEL_ALUNO_CD_ALUNO ON M_RESPONSAVEL_ALUNO (CD_ALUNO)

GO   

--select * from D_RESPONSAVEL_ALUNO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_DISPOSITIVO_COMUNICACAO_ALUNO')
DROP TABLE M_DISPOSITIVO_COMUNICACAO_ALUNO	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_DISPOSITIVO_COMUNICACAO_ALUNO							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.DISPOSITIVO_COMUNICACAO_ALUNO 		WHERE DT_FIM IS NULL') 
CREATE INDEX INDEX_M_DISPOSITIVO_COMUNICACAO_ALUNO_CD_ALUNO ON M_DISPOSITIVO_COMUNICACAO_ALUNO (CD_ALUNO)

GO   
--select * from D_DISPOSITIVO_COMUNICACAO_ALUNO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_TURMA')
DROP TABLE M_TIPO_TURMA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_TURMA						
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.TIPO_TURMA') 
GO
--select * from D_TIPO_TURMA
------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_HISTORICO_MATRICULA_TURMA_ESCOLA')
DROP TABLE Db_Local.DBO.M_HISTORICO_MATRICULA_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE 
INTO Db_Local.DBO.M_HISTORICO_MATRICULA_TURMA_ESCOLA	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA A 
WHERE EXISTS (SELECT B.AN_LETIVO,B.CD_TURMA_ESCOLA FROM  DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA B 
WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND B.AN_LETIVO >  2022)
	
	CREATE INDEX INDEX_M_HISTORICO_MATRICULA_TURMA_ESCOLA ON M_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
	CREATE INDEX INDEX_M_CD_TURMA_ESOCLA ON M_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO
--select * from D_HISTORICO_MATRICULA_TURMA_ESCOLA
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_TIPO_PROGRAMA')
DROP TABLE M_TIPO_PROGRAMA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_TIPO_PROGRAMA								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[TIPO_PROGRAMA]  
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ENDERECO')
DROP TABLE M_ENDERECO	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ENDERECO							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.ENDERECO') 
CREATE INDEX INDEX_CI_ENDERECO ON M_ENDERECO (CI_ENDERECO)
CREATE INDEX INDEX_CD_MUNICIPIO ON M_ENDERECO (CD_MUNICIPIO)
GO   
--select * from D_ENDERECO



IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ficha_validacao_aluno')
DROP TABLE M_ficha_validacao_aluno
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ficha_validacao_aluno						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[ficha_validacao_aluno]
GO

--SELECT * FROM D_ficha_validacao_aluno



IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_ficha_validacao_veiculo')
DROP TABLE M_ficha_validacao_veiculo
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_ficha_validacao_veiculo						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[ficha_validacao_veiculo]
GO



IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_INSTITUICAO')
DROP TABLE M_INSTITUICAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_INSTITUICAO						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[instituicao]
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'M_convenio_creche_escola')
DROP TABLE M_convenio_creche_escola
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.M_convenio_creche_escola						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[convenio_creche_escola]
GO

----------------------------------------------------------------------------------------------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'SME_CLASSES')
     DROP TABLE SME_CLASSES
SELECT * INTO SME_CLASSES FROM SME_CLASSES_DIARIO
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'SME_ALUNOS')
     DROP TABLE SME_ALUNOS
SELECT * INTO SME_ALUNOS FROM SME_ALUNOS_DIARIO
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'SME_ESCOLA')
     DROP TABLE SME_ESCOLA
SELECT * INTO SME_ESCOLA FROM SME_ESCOLA_DIARIO
GO
----------------------------------------------------------------------------------------------------

--select * from d_misme_dir_indir_total
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_DIR_INDIR_TOTAL')
     DROP TABLE MISME_DIR_INDIR_TOTAL
SELECT * INTO  MISME_DIR_INDIR_TOTAL FROM D_MISME_DIR_INDIR_TOTAL
GO

--select * from d_misme_dre_distr_setor ??????????????????????????????????????
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_DRE_DISTR_SETOR')
     DROP TABLE MISME_DRE_DISTR_SETOR
SELECT * INTO MISME_DRE_DISTR_SETOR FROM D_MISME_DRE_DISTR_SETOR
GO

--select * from D_MISME_EE_ESCOLA_TOTAL
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_EE_ESCOLA_TOTAL')
     DROP TABLE MISME_EE_ESCOLA_TOTAL
SELECT * INTO MISME_EE_ESCOLA_TOTAL FROM D_MISME_EE_ESCOLA_TOTAL
GO

--select * from  D_MISME_ESCOLA_MTN
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_ESCOLA_MTN')
     DROP TABLE MISME_ESCOLA_MTN
SELECT * INTO MISME_ESCOLA_MTN FROM D_MISME_ESCOLA_MTN
GO

--select * from  D_MISME_ESCOLA_TOTAL
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_ESCOLA_TOTAL')
     DROP TABLE MISME_ESCOLA_TOTAL
SELECT * INTO MISME_ESCOLA_TOTAL FROM D_MISME_ESCOLA_TOTAL
GO

--select * from  D_MISME_ESCOLA_TURNO
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_ESCOLA_TURNO')
     DROP TABLE MISME_ESCOLA_TURNO
SELECT * INTO MISME_ESCOLA_TURNO FROM D_MISME_ESCOLA_TURNO
GO

--select * from  D_MISME_ESCOLA_TOTAL_COMPAT
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'MISME_ESCOLA_TOTAL_COMPAT')
     DROP TABLE MISME_ESCOLA_TOTAL_COMPAT
SELECT * INTO MISME_ESCOLA_TOTAL_COMPAT FROM D_MISME_ESCOLA_TOTAL_COMPAT
GO




