/*****ESTA ROTINA BAIXA AS TABELAS DO DIA ANTERIOR 
      DA BASE PRODAM/EOL ESPELHO SE1426_SS
*****/
USE Db_Local

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_MUNICIPIO')
DROP TABLE D_MUNICIPIO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_MUNICIPIO								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[MUNICIPIO]  
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_HISTORICO_UNIDADE')
DROP TABLE D_HISTORICO_UNIDADE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_HISTORICO_UNIDADE								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[historico_unidade]  
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ESCOLA')
DROP TABLE D_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ESCOLA								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ESCOLA  
GO
---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_SERIE_ENSINO')
DROP TABLE D_SERIE_ENSINO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_SERIE_ENSINO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SERIE_ENSINO	   
GO

---------------  		
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_UNIDADE_EDUCACAO')
DROP TABLE D_UNIDADE_EDUCACAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_UNIDADE_EDUCACAO					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.UNIDADE_EDUCACAO	
GO
	
-------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_ESCOLA')
DROP TABLE D_TIPO_ESCOLA	
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_ESCOLA							
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_ESCOLA
GO
       							
-------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_UNIDADE_EDUCACAO')
DROP TABLE D_TIPO_UNIDADE_EDUCACAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_UNIDADE_EDUCACAO				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_UNIDADE_EDUCACAO 
GO

---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_UNIDADE_ADMINISTRATIVA')
DROP TABLE D_UNIDADE_ADMINISTRATIVA        						 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_UNIDADE_ADMINISTRATIVA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.UNIDADE_ADMINISTRATIVA
GO
         					
---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_UNIDADE_ADMINISTRATIVA')
DROP TABLE D_TIPO_UNIDADE_ADMINISTRATIVA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_UNIDADE_ADMINISTRATIVA			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_UNIDADE_ADMINISTRATIVA  
GO
    		 
----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_LOGRADOURO')
DROP TABLE D_TIPO_LOGRADOURO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_LOGRADOURO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_LOGRADOURO
GO

---------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_DISPOSITIVO_COMUNICACAO_UNIDADE')
DROP TABLE D_DISPOSITIVO_COMUNICACAO_UNIDADE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_DISPOSITIVO_COMUNICACAO_UNIDADE		
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.DISPOSITIVO_COMUNICACAO_UNIDADE
GO

--------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_DISTRITO_MEC')
DROP TABLE D_DISTRITO_MEC
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_DISTRITO_MEC						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.DISTRITO_MEC
GO

----------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ETAPA_ENSINO')
DROP TABLE D_ETAPA_ENSINO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ETAPA_ENSINO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ETAPA_ENSINO
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_MODALIDADE_ENSINO')
DROP TABLE D_MODALIDADE_ENSINO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_MODALIDADE_ENSINO					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MODALIDADE_ENSINO
GO

---------------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_DEPENDENCIA_ADMINISTRATIVA')
DROP TABLE Db_Local.DBO.D_TIPO_DEPENDENCIA_ADMINISTRATIVA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_DEPENDENCIA_ADMINISTRATIVA		
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_DEPENDENCIA_ADMINISTRATIVA
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_CORRESPONDENCIA_SERIE_EOL')
DROP TABLE Db_Local.DBO.D_CORRESPONDENCIA_SERIE_EOL
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_CORRESPONDENCIA_SERIE_EOL			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.CORRESPONDENCIA_SERIE_EOL

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_AMBIENTE_ESCOLA')
DROP TABLE Db_Local.DBO.D_AMBIENTE_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_AMBIENTE_ESCOLA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.AMBIENTE_ESCOLA  A 
--WHERE  EXISTS (SELECT * FROM D_TURMA_ESCOLA B WHERE A.CD_AMBIENTE_ESCOLA = B.CD_AMBIENTE_ESCOLA)
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_AMBIENTE')
DROP TABLE Db_Local.DBO.D_TIPO_AMBIENTE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_AMBIENTE						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_AMBIENTE
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_DURACAO_TIPO_TURNO')
DROP TABLE Db_Local.DBO.D_DURACAO_TIPO_TURNO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_DURACAO_TIPO_TURNO					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[DURACAO_TIPO_TURNO] 
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_NECESSIDADE_ESPECIAL_ALUNO')
DROP TABLE Db_Local.DBO.D_NECESSIDADE_ESPECIAL_ALUNO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_NECESSIDADE_ESPECIAL_ALUNO			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[NECESSIDADE_ESPECIAL_ALUNO] 
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_PROGRAMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_PROGRAMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_PROGRAMA_ESCOLA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[PROGRAMA_ESCOLA]
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_SUB_PREFEITURA')
DROP TABLE Db_Local.DBO.D_SUB_PREFEITURA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_SUB_PREFEITURA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[SUB_PREFEITURA]
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_MATRICULA_TURMA_ESCOLA_INDICACAO')
DROP TABLE Db_Local.DBO.D_MATRICULA_TURMA_ESCOLA_INDICACAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_MATRICULA_TURMA_ESCOLA_INDICACAO	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MATRICULA_TURMA_ESCOLA_INDICACAO MTEI 
GO


-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_PRIORIDADE_LISTA')
DROP TABLE Db_Local.DBO.D_TIPO_PRIORIDADE_LISTA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_PRIORIDADE_LISTA	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TIPO_PRIORIDADE_LISTA A 

GO
-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_FAIXA_SERIE')
DROP TABLE Db_Local.DBO.D_FAIXA_SERIE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_FAIXA_SERIE	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.FAIXA_SERIE

GO
-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_SOLICITACAO_MATRICULA_PREFERENCIAL')
DROP TABLE Db_Local.DBO.D_SOLICITACAO_MATRICULA_PREFERENCIAL
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_SOLICITACAO_MATRICULA_PREFERENCIAL	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SOLICITACAO_MATRICULA_PREFERENCIAL A 
WHERE DT_FIM IS NULL

GO
-----------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ALUNO_CLASSIFICADO_TRANSPORTE')
DROP TABLE Db_Local.DBO.D_ALUNO_CLASSIFICADO_TRANSPORTE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ALUNO_CLASSIFICADO_TRANSPORTE	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ALUNO_CLASSIFICADO_TRANSPORTE A 
WHERE DT_FIM IS NULL


--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_SOLICITACAO_MATRICULA')
DROP TABLE D_SOLICITACAO_MATRICULA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_SOLICITACAO_MATRICULA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SOLICITACAO_MATRICULA
WHERE AN_LETIVO > 2010
CREATE INDEX INDEX_D_CD_ALUNO ON D_SOLICITACAO_MATRICULA (CD_ALUNO)
CREATE INDEX INDEX_D_CD_SOLICITACAO_MATRICULA ON D_SOLICITACAO_MATRICULA (CD_SOLICITACAO_MATRICULA)
CREATE INDEX INDEX_D_CD_UNIDADE_EDUCACAO ON D_SOLICITACAO_MATRICULA (CD_UNIDADE_EDUCACAO)
CREATE INDEX INDEX_D_CD_MICRO_REGIAO ON D_SOLICITACAO_MATRICULA (CD_MICRO_REGIAO)
GO
--select * from D_SOLICITACAO_MATRICULA
--------------        						 
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_SOLICITACAO_MATRICULA_PRIORIDADE')
DROP TABLE D_SOLICITACAO_MATRICULA_PRIORIDADE
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_SOLICITACAO_MATRICULA_PRIORIDADE	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.SOLICITACAO_MATRICULA_PRIORIDADE  
GO


--------------  
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ALUNO')
DROP TABLE D_ALUNO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ALUNO								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ALUNO 
	CREATE INDEX INDEX_D_ALUNO ON D_ALUNO (CD_ALUNO) 
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TURMA_ESCOLA')
DROP TABLE D_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TURMA_ESCOLA						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA WHERE AN_LETIVO  > 2010

		CREATE INDEX INDEX_D_TURMA_ESCOLA ON D_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO

-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_DIA_SEMANA_AULA_TURMA')
DROP TABLE Db_Local.DBO.D_DIA_SEMANA_AULA_TURMA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_DIA_SEMANA_AULA_TURMA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.[DIA_SEMANA_AULA_TURMA] A 
WHERE EXISTS (SELECT B.CD_TURMA_ESCOLA FROM D_TURMA_ESCOLA B WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA)
	CREATE INDEX INDEX_D_DIA_SEMANA_AULA_TURMA ON D_DIA_SEMANA_AULA_TURMA (CD_TURMA_ESCOLA)
GO
--select * from D_DIA_SEMANA_AULA_TURMA
--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_MATRICULA')
DROP TABLE D_MATRICULA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_MATRICULA							
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MATRICULA  WHERE AN_LETIVO  > 2022

CREATE INDEX INDEX_D_MATRICULA ON D_MATRICULA (CD_MATRICULA)
GO


--SELECT * FROM D_MATRICULA WHERE AN_LETIVO='2024'
--------------    
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_HISTORICO_MATRICULA')
DROP TABLE D_HISTORICO_MATRICULA  		
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_HISTORICO_MATRICULA					
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA WHERE AN_LETIVO  > 2020   
	CREATE INDEX INDEX_D_HISTORICO_MATRICULA ON D_HISTORICO_MATRICULA (CD_MATRICULA)
GO
--select * from D_HISTORICO_MATRICULA
--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_MATRICULA_TURMA_ESCOLA')
DROP TABLE D_MATRICULA_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_MATRICULA_TURMA_ESCOLA				
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.MATRICULA_TURMA_ESCOLA A 
WHERE EXISTS (SELECT B.CD_MATRICULA FROM D_MATRICULA B WHERE A.CD_MATRICULA = B.CD_MATRICULA)      				

CREATE INDEX INDEX_D_MATRICULA_TURMA_ESCOLA ON D_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
GO
--select * from D_MATRICULA_TURMA_ESCOLA
----------------
/*IF EXISTS 
(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_HISTORICO_MATRICULA_TURMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA A 
WHERE EXISTS (SELECT B.CD_TURMA_ESCOLA FROM  DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA B 
WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND B.AN_LETIVO  > 2020)
	CREATE INDEX INDEX_D_HISTORICO_MATRICULA_TURMA_ESCOLA ON D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
	CREATE INDEX INDEX_D_CD_TURMA_ESOCLA ON D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO


IF EXISTS 
(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_HISTORICO_MATRICULA_TURMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA


SELECT * INTO Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA

 FROM OPENQUERY ( DB_EDUCACAO_1_PRODAM ,'SELECT *, GETDATE() AS CRDATE FROM SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA' ) A


WHERE EXISTS (SELECT B.CD_TURMA_ESCOLA FROM  DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA B 
WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND B.AN_LETIVO  > 2020)
	CREATE INDEX INDEX_D_HISTORICO_MATRICULA_TURMA_ESCOLA ON D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
	CREATE INDEX INDEX_D_CD_TURMA_ESOCLA ON D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO
*/
-----------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_MICRO_REGIAO')
DROP TABLE D_MICRO_REGIAO
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_MICRO_REGIAO						
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.MICRO_REGIAO') 
GO

---------------   
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ENDERECO_ALUNO')
DROP TABLE D_ENDERECO_ALUNO		    			
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ENDERECO_ALUNO						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ENDERECO_ALUNO 
CREATE INDEX INDEX_CD_ALUNO ON D_ENDERECO_ALUNO (CD_ALUNO)
CREATE INDEX INDEX_CI_ENDERECO ON D_ENDERECO_ALUNO (CI_ENDERECO)
CREATE INDEX INDEX_CD_ENDERECO_ALUNO ON D_ENDERECO_ALUNO (CD_ENDERECO_ALUNO)
GO
   							
--------------
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ENDERECO_ALUNO_TIPO_ENDERECO')
DROP TABLE D_ENDERECO_ALUNO_TIPO_ENDERECO	
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ENDERECO_ALUNO_TIPO_ENDERECO		
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.ENDERECO_ALUNO_TIPO_ENDERECO	 
CREATE INDEX INDEX_CD_ENDERECO_ALUNO ON D_ENDERECO_ALUNO_TIPO_ENDERECO (CD_ENDERECO_ALUNO) --erro em 23082023
GO
--select * from D_ENDERECO_ALUNO_TIPO_ENDERECO
----------------

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_FAIXA_SERIE')
DROP TABLE D_FAIXA_SERIE	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_FAIXA_SERIE							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.FAIXA_SERIE') 


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_RESPONSAVEL_ALUNO')
DROP TABLE D_RESPONSAVEL_ALUNO	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_RESPONSAVEL_ALUNO							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426.DBO.RESPONSAVEL_ALUNO') 
CREATE INDEX INDEX_RESPONSAVEL_ALUNO_CD_ALUNO ON D_RESPONSAVEL_ALUNO (CD_ALUNO)

GO   

--select * from D_RESPONSAVEL_ALUNO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_DISPOSITIVO_COMUNICACAO_ALUNO')
DROP TABLE D_DISPOSITIVO_COMUNICACAO_ALUNO	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_DISPOSITIVO_COMUNICACAO_ALUNO							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.DISPOSITIVO_COMUNICACAO_ALUNO 		WHERE DT_FIM IS NULL') 
CREATE INDEX INDEX_D_DISPOSITIVO_COMUNICACAO_ALUNO_CD_ALUNO ON D_DISPOSITIVO_COMUNICACAO_ALUNO (CD_ALUNO)

GO   
--select * from D_DISPOSITIVO_COMUNICACAO_ALUNO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_TURMA')
DROP TABLE D_TIPO_TURMA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_TURMA						
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.TIPO_TURMA') 
GO
--select * from D_TIPO_TURMA
------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_HISTORICO_MATRICULA_TURMA_ESCOLA')
DROP TABLE Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE 
INTO Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA	
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA A 
WHERE EXISTS (SELECT B.AN_LETIVO,B.CD_TURMA_ESCOLA FROM  DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.TURMA_ESCOLA B 
WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND B.AN_LETIVO >  2022)
	
	CREATE INDEX INDEX_D_HISTORICO_MATRICULA_TURMA_ESCOLA ON D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_MATRICULA)
	CREATE INDEX INDEX_D_CD_TURMA_ESOCLA ON D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)
GO
--select * from D_HISTORICO_MATRICULA_TURMA_ESCOLA
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_TIPO_PROGRAMA')
DROP TABLE D_TIPO_PROGRAMA
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_TIPO_PROGRAMA								
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[TIPO_PROGRAMA]  
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ENDERECO')
DROP TABLE D_ENDERECO	   				 
SELECT *, GETDATE() AS CRDATE INTO Db_Local.DBO.D_ENDERECO							
FROM OPENQUERY (DB_EDUCACAO_1_PRODAM, 'SELECT * FROM SE1426_SS.DBO.ENDERECO') 
CREATE INDEX INDEX_CI_ENDERECO ON D_ENDERECO (CI_ENDERECO)
CREATE INDEX INDEX_CD_MUNICIPIO ON D_ENDERECO (CD_MUNICIPIO)
GO   
--select * from D_ENDERECO



IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ficha_validacao_aluno')
DROP TABLE D_ficha_validacao_aluno
SELECT *, GETDATE() AS CRDATE INTO DB_LOCAL.DBO.D_ficha_validacao_aluno						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[ficha_validacao_aluno]
GO

--SELECT * FROM D_ficha_validacao_aluno



IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ficha_validacao_veiculo')
DROP TABLE D_ficha_validacao_veiculo
SELECT *, GETDATE() AS CRDATE INTO DB_LOCAL.DBO.D_ficha_validacao_veiculo						
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[ficha_validacao_veiculo]
GO



IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_INSTITUICAO')
DROP TABLE D_INSTITUICAO
SELECT *, GETDATE() AS CRDATE INTO DB_LOCAL.DBO.D_INSTITUICAO						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[instituicao]
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_convenio_creche_escola')
DROP TABLE D_convenio_creche_escola
SELECT *, GETDATE() AS CRDATE INTO DB_LOCAL.DBO.D_convenio_creche_escola						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[convenio_creche_escola]
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_SERIE_TURMA_ESCOLA')
DROP TABLE D_SERIE_TURMA_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO DB_LOCAL.DBO.D_SERIE_TURMA_ESCOLA						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[SERIE_TURMA_ESCOLA]
GO

IF EXISTS (SELECT * FROM Db_local.DBO.SYSOBJECTS WHERE NAME = 'D_TURMA_GRADE_TERRITORIO_EXPERIENCIA') DROP TABLE D_TURMA_GRADE_TERRITORIO_EXPERIENCIA
SELECT *,GETDATE() AS CRDATE INTO D_TURMA_GRADE_TERRITORIO_EXPERIENCIA FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[TURMA_GRADE_TERRITORIO_EXPERIENCIA]
GO

IF EXISTS (SELECT * FROM Db_local.DBO.SYSOBJECTS WHERE NAME = 'D_ESCOLA_GRADE') DROP TABLE D_ESCOLA_GRADE
SELECT *,GETDATE() AS CRDATE INTO D_ESCOLA_GRADE FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[ESCOLA_GRADE]
GO

IF EXISTS (SELECT * FROM Db_local.DBO.SYSOBJECTS WHERE NAME = 'D_GRADE') DROP TABLE D_GRADE
SELECT *,GETDATE() AS CRDATE INTO D_GRADE FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[GRADE]
GO

IF EXISTS (SELECT * FROM Db_local.DBO.SYSOBJECTS WHERE NAME = 'D_TERRITORIO_SABER') DROP TABLE D_TERRITORIO_SABER
SELECT *,GETDATE() AS CRDATE INTO D_TERRITORIO_SABER FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[TERRITORIO_SABER]
GO

IF EXISTS (SELECT * FROM Db_local.DBO.SYSOBJECTS WHERE NAME = 'D_TIPO_EXPERIENCIA_PEDAGOGICA') DROP TABLE D_TIPO_EXPERIENCIA_PEDAGOGICA
SELECT *,GETDATE() AS CRDATE INTO D_TIPO_EXPERIENCIA_PEDAGOGICA FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[TIPO_EXPERIENCIA_PEDAGOGICA]
GO


EXEC GERA_ALUNOS_DIARIO
EXEC GERA_ESCOLAS_DIARIO
EXEC GERA_CLASSES_DIARIO


--
