USE Db_Local

/*DROP TABLE TAB_END
CREATE TABLE TAB_END (
	ID  INT IDENTITY(0,1),
	ENDERECO NVARCHAR(100) NULL,
	LAT FLOAT NULL,
	LON FLOAT NULL,
	DATA_GERACAO DATETIME NULL	)*/


TRUNCATE TABLE TAB_END

--ENDERE�O 1
DECLARE @END NVARCHAR(200) SET @END = 'Av Cel. Serefredo Fagundes, 1716 - Vila Nova Mazzei'
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.463989553830444 
DECLARE	@LON_X FLOAT SET @LON_X = -46.60341409032333
INSERT INTO TAB_END  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO

--ENDERE�O 2
DECLARE @END NVARCHAR(200) SET @END = 'Avenida Guapira, 2089 CEP: 02265-002'
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.470733149810044 
DECLARE	@LON_X FLOAT SET @LON_X = -46.58647573238085
INSERT INTO TAB_END  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO
/*
--ENDERE�O 3
DECLARE @END NVARCHAR(200) SET @END = 'R Genaro Napoli '
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.744043
DECLARE	@LON_X FLOAT SET @LON_X = -46.669838
INSERT INTO TAB_END  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO

--ENDERE�O 4
DECLARE @END NVARCHAR(200) SET @END = 'Av. Carlos Alberto Bastos Machado'
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.772243
DECLARE	@LON_X FLOAT SET @LON_X = -46.694211
INSERT INTO TAB_END  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO
--ENDERE�O 5
DECLARE @END NVARCHAR(200) SET @END = 'Rua Forte da Barra X R. Nossa Sr.� do Bom Conselho'
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.640153
DECLARE	@LON_X FLOAT SET @LON_X = -46.759521
INSERT INTO TAB_END  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO

--ENDERE�O 6
DECLARE @END NVARCHAR(200) SET @END = 'Rua Itapipinas x Rua Nicolau Jacinto'
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.526829
DECLARE	@LON_X FLOAT SET @LON_X = -46.472296
INSERT INTO TAB_END  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO

/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/*/
SELECT * FROM TAB_END

DROP TABLE CONSULTA_ENDERECO
	
SELECT 
ID,
ENDERECO,
--LAT,
--LON,
--CONVERT(VARCHAR,DATA_GERACAO,103) AS DT_PESQUISA,
ORIGEM,
DT_INSCRICAO AS [DATA INSCRI��O],
[DT CADASTRO/REATIVA��O] AS [DATA CADASTRO/REATIVA��O],
AGUARDANDO AS [DIAS AGUARDANDO],
CD_ALUNO AS [C�DIGO ALUNO],
NM_ALUNO AS [NOME ALUNO],
NM_MAE AS [M�E ALUNO],
DT_NASCIMENTO_ALUNO AS [DT NASC ALUNO],
[DESC. S�R. ENS.] AS S�RIE,
LOGRADOURO_ALU AS [ENDERE�O ALUNO],
NR_ALU AS N�MERO,
COMP_ALU AS COMPL,
BAIRRO_ALU AS BAIRRO,
CEP_ALU AS CEP,
DISTR_ALU AS DISTRITO,
SETOR_ALU AS SETOR,
DIST�NCIA = FLOOR(FLOOR(SQRT(POWER((LAT * 1000000 - (CD_COORDENADA_GEO_Y * 1000000) ),2) +  
				 POWER((LON * 1000000 - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6), 
TP_PREFERENCIA,
CD_SOLICITACAO_MATRICULA_PREFERENCIAL AS [PREFERENCIA/ESPECIFICA],
--[DRE PREF],
--[TIPO ESC PREF ESPEC],
CD_UNIDADE_EDUCACAO AS [ESCOLA PREF ESPEC],
CONVERT(VARCHAR,CRDATE-1, 103)  AS DT_BASE
INTO CONSULTA_ENDERECO
FROM TAB_END, ALUNOS_CADASTRO
WHERE (FLOOR(SQRT(POWER((LAT * 1000000 - (CD_COORDENADA_GEO_Y * 1000000) ),2) +  
				 POWER((LON * 1000000 - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6) <=5000
/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/


DROP TABLE ##TEMP0
SELECT A.*INTO ##TEMP0 FROM CONSULTA_ENDERECO A
WHERE ID = 0
-------------------------------------------------
DROP TABLE ##TEMP1
SELECT A.*INTO ##TEMP1 FROM CONSULTA_ENDERECO A
WHERE ID = 1

--SELECT * FROM ALUNOS_CADASTRO

/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

