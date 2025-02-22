<<<<<<< HEAD
CREATE PROCEDURE GERA_DEMANDA_POR_ESCOLA_COM_PREF AS

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='DEMANDA_POR_ESCOLA_COM_PREF')
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
	  B.DT_INSCRICAO AS [DATA INSCRI��O],
	  B.[DT CADASTRO/REATIVA��O] AS [DATA CADASTRO/REATIVA��O],
	  B.AGUARDANDO AS [DIAS AGUARDANDO],
	  B.CD_ALUNO AS [C�DIGO ALUNO],
	  B.NM_ALUNO AS [NOME ALUNO],
	  B.NM_MAE AS [M�E ALUNO],
	  B.DT_NASCIMENTO_ALUNO AS [DT NASC ALUNO],
	  B.[DESC. S�R. ENS.] AS S�RIE,
	  B.LOGRADOURO_ALU AS [ENDERE�O ALUNO],
	  B.NR_ALU AS N�MERO,
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
	  --B.CADUNICO AS [CADASTRO �NICO?],
	  --B.BOLSA_FAMILIA AS [BOLSA FAM�LIA?],
	  FLOOR(FLOOR(SQRT(POWER((COORDENADA_X_ALU - (A.[CD_COORDENADA_GEO_X] * 1000000) ),2) +  POWER((COORDENADA_Y_ALU  - (A.[CD_COORDENADA_GEO_Y] * 1000000)),2)) / 10)/0.6) AS DIST�NCIA,
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
=======
CREATE PROCEDURE GERA_DEMANDA_POR_ESCOLA_COM_PREF AS

IF EXISTS 
(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME ='DEMANDA_POR_ESCOLA_COM_PREF')
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
	  B.DT_INSCRICAO AS [DATA INSCRI��O],
	  B.[DT CADASTRO/REATIVA��O] AS [DATA CADASTRO/REATIVA��O],
	  B.AGUARDANDO AS [DIAS AGUARDANDO],
	  B.CD_ALUNO AS [C�DIGO ALUNO],
	  B.NM_ALUNO AS [NOME ALUNO],
	  B.NM_MAE AS [M�E ALUNO],
	  B.DT_NASCIMENTO_ALUNO AS [DT NASC ALUNO],
	  B.[DESC. S�R. ENS.] AS S�RIE,
	  B.LOGRADOURO_ALU AS [ENDERE�O ALUNO],
	  B.NR_ALU AS N�MERO,
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
	  --B.CADUNICO AS [CADASTRO �NICO?],
	  --B.BOLSA_FAMILIA AS [BOLSA FAM�LIA?],
	  FLOOR(FLOOR(SQRT(POWER((COORDENADA_X_ALU - (A.[CD_COORDENADA_GEO_X] * 1000000) ),2) +  POWER((COORDENADA_Y_ALU  - (A.[CD_COORDENADA_GEO_Y] * 1000000)),2)) / 10)/0.6) AS DIST�NCIA,
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
>>>>>>> b46c277944e78f2cfc8c734a3e235543716689cb
--EXEC GERA_DEMANDA_POR_ESCOLA_COM_PREF