                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            USE Db_Local

DROP TABLE DEMANDA_POR_ESCOLA_COM_PREF
SELECT DISTINCT
	--CAMPOS DA TABELA SME_ESCOLA_DIARIO  - DEVE SER ATUALIZADO DIARAIAMENTE - CREATE AND EXEC PROCEDURE GERA_ESCOLA_DIARIO
	A.DRE,
	A.CD_ESCOLA,
	A.SG_TP_ESCOLA,
	A.NOMESC,
	A.ENDERECO,
	A.NR,
	A.BAIRRO,
	--CAMPOS DA TABELA ALUNOS_CADASTRO - ATUALIZADA DIARIAMENTE
      B.ORIGEM,
	  B.DT_INSCRICAO AS [DATA INSCRIÇÃO],
	  B.[DT CADASTRO/REATIVAÇÃO] AS [DATA CADASTRO/REATIVAÇÃO],
	  B.AGUARDANDO AS [DIAS AGUARDANDO],
	  B.CD_ALUNO AS [CÓDIGO ALUNO],
	  B.NM_ALUNO AS [NOME ALUNO],
	  B.NM_MAE AS [MÃE ALUNO],
	  B.DT_NASCIMENTO_ALUNO AS [DT NASC ALUNO],
	  B.[DESC. SÉR. ENS.] AS SÉRIE,
	  B.LOGRADOURO_ALU AS [ENDEREÇO ALUNO],
	  B.NR_ALU AS NÚMERO,
	  B.COMP_ALU AS COMPL,
	  B.BAIRRO_ALU,
	  B.CEP_ALU AS CEP,
	  B.DISTR_ALU AS DISTRITO,
	  B.SETOR_ALU AS SETOR,
	  B.TP_PREFERENCIA,
	  B.CD_UNIDADE_EDUCACAO AS [PREFERENCIA/ESPECIFICA],
	  C.DRE AS [DRE PREF],
	  C.SG_TP_ESCOLA AS [TIPO ESC PREF ESPEC],
	  C.NOMESC AS [ESCOLA PREF ESPEC],
	  --B.CADUNICO AS [CADASTRO ÚNICO?],
	  --B.BOLSA_FAMILIA AS [BOLSA FAMÍLIA?],
	  FLOOR(FLOOR(SQRT(POWER((COORDENADA_X_ALU - (A.[CD_COORDENADA_GEO_X] * 1000000) ),2) +  POWER((COORDENADA_Y_ALU  - (A.[CD_COORDENADA_GEO_Y] * 1000000)),2)) / 10)/0.6) AS DISTÂNCIA,
	 B.CRDATE AS [DATA BASE]
INTO DEMANDA_POR_ESCOLA_COM_PREF
FROM	SME_ESCOLA_DIARIO A, ALUNOS_CADASTRO B
LEFT JOIN SME_ESCOLA_DIARIO C ON B.CD_UNIDADE_EDUCACAO=C.CD_ESCOLA
WHERE 
A.TP_ESCOLA IN (2,4,10,11,12,17,18,28,31) AND
	(FLOOR(SQRT(POWER((COORDENADA_X_ALU - (A.[CD_COORDENADA_GEO_X] * 1000000) ),2) +  POWER((COORDENADA_Y_ALU  - (A.[CD_COORDENADA_GEO_Y] * 1000000)),2)) / 10)/0.6) <= 5000


--SELECT * FROM DEMANDA_POR_ESCOLA_COM_PREF
------------------------------------------------------------------------------------------------------------
--TABELAS SEPARADAS POR DRE

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='BT')
DROP TABLE BT
SELECT *
INTO BT
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - BT'
--SELECT * FROM BT
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='CL')
DROP TABLE CL
SELECT *
INTO CL
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - CL'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='CS')
DROP TABLE CS
SELECT *
INTO CS
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - CS'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='FB')
DROP TABLE FB
SELECT *
INTO FB
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - FB'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='G')
DROP TABLE G
SELECT *
INTO G
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - G'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='IP')
DROP TABLE IP
SELECT *
INTO IP
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - IP'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='IQ')
DROP TABLE IQ
SELECT *
INTO IQ
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - IQ'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='JT')
DROP TABLE JT
SELECT *
INTO JT
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - JT'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MP')
DROP TABLE MP
SELECT *
INTO MP
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - MP'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='PE')
DROP TABLE PE
SELECT *
INTO PE
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - PE'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='PJ')
DROP TABLE PJ
SELECT *
INTO PJ
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - PJ'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='SA')
DROP TABLE SA
SELECT *
INTO SA
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - SA'

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='SM')
DROP TABLE SM
SELECT *
INTO SM
FROM DEMANDA_POR_ESCOLA_COM_PREF
WHERE DRE = 'DRE - SM'
--SELECT TOP 1 * FROM SME_ESCOLA_DIARIO SELECT TOP 1 * FROM ALUNOS_CADASTRO
--------------------------------------------------------------------------------------------------------------------------------
/*--LISTA DE ALUNOS ED INFANTIL
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='D_ALUNOS_ED_INFANTIL')
DROP TABLE D_ALUNOS_ED_INFANTIL
SELECT DISTINCT
DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.CD_ALUNO,
NM_ALUNO,
CONVERT(VARCHAR,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
SG_SERIE_ENSINO,
C.QT_DISTANCIA AS DISTANCIA_ESCOLA,
CONVERT(VARCHAR, A.CRDATE, 103) AS DT_BASE
--INTO D_ALUNOS_ED_INFANTIL
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
LEFT JOIN  
		 (SELECT DISTINCT
					B.an_letivo AS ANO,
					A.CD_ALUNO,
					C.dc_motivo_transporte,
					B.qt_distancia,
					B.qt_distancia_carro,
					CONVERT(VARCHAR, A.CRDATE-1, 103) AS DT_BASE
					FROM SME_ALUNOS_DIARIO A
					LEFT JOIN D_aluno_candidato_transporte B ON A.CD_ALUNO=B.cd_aluno
					JOIN Db_Local_Aux..MOTIVO_TRANSPORTE C ON B.cd_motivo_transporte=C.cd_motivo_transporte
					WHERE B.an_letivo = YEAR(GETDATE())) C ON A.cd_aluno=C.CD_ALUNO

WHERE CD_SITUACAO_ALUNO=1 AND SG_ETAPA='ED INF' AND TP_ESCOLA<>15
--SELECT * FROM D_ALUNOS_ED_INFANTIL

-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_BT')
DROP TABLE MT_INF_BT
SELECT DRE,CD_ESCOLA,SG_TP_ESCOLA,NOMESC,CD_ALUNO,NM_ALUNO,NM_MAE_ALUNO,DT_NASC,SG_ETAPA,SG_SERIE_ENSINO,ENDEREÇO,NR,BAIRRO,CEP,DIST_AL_UE,DT_BASE
INTO MT_INF_BT
FROM VW_DISTANCIA_ALUNO_ESCOLA
WHERE DRE = 'DRE - BT' AND SG_ETAPA ='ED INF'
--SELECT * FROM MT_INF_BT
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_CL')
DROP TABLE MT_INF_CL
SELECT *
INTO MT_INF_CL
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - CL'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_CS')
DROP TABLE MT_INF_CS
SELECT *
INTO MT_INF_CS
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - CS'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_FB')
DROP TABLE MT_INF_FB
SELECT *
INTO MT_INF_FB
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - FB'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_G')
DROP TABLE MT_INF_G
SELECT *
INTO MT_INF_G
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - G'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_IP')
DROP TABLE MT_INF_IP
SELECT *
INTO MT_INF_IP
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - IP'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_IQ')
DROP TABLE MT_INF_IQ
SELECT *
INTO MT_INF_IQ
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - IQ'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_JT')
DROP TABLE MT_INF_JT
SELECT *
INTO MT_INF_JT
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - JT'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_MP')
DROP TABLE MT_INF_MP
SELECT *
INTO MT_INF_MP
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - MP'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_PE')
DROP TABLE MT_INF_PE
SELECT *
INTO MT_INF_PE
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - PE'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_PJ')
DROP TABLE MT_INF_PJ
SELECT *
INTO MT_INF_PJ
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - PJ'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_SA')
DROP TABLE MT_INF_SA
SELECT *
INTO MT_INF_SA
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - SA'
-------------------------------------------------------------------------------------------------------
IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='MT_INF_SM')
DROP TABLE MT_INF_SM
SELECT *
INTO MT_INF_SM
FROM D_ALUNOS_ED_INFANTIL
WHERE DRE = 'DRE - SM'
-------------------------------------------------------------------------------------------------------

select * from D_ALUNOS_ED_INFANTIL

select top 10 * from VW_ALUNOS_ENDERECO
*/