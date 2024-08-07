USE [Db_local]
GO
/****** Object:  StoredProcedure [dbo].[GERA_CLASSES_DIARIO]    Script Date: 23/04/2024 08:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GERA_CLASSES_DIARIO]

AS

--DROP PROCEDURE GERA_CLASSES_DIARIO
/**/-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------/**/
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_TURMA_ESCOLA') 																														 /**/
/**/	DROP TABLE ##D_TURMA_ESCOLA																																										 /**/
/**/																																																	 /**/
/**/SELECT * INTO ##D_TURMA_ESCOLA FROM D_TURMA_ESCOLA																																	 /**/
/**/WHERE 																																																 /**/
/**/	AN_LETIVO = DATEPART(YEAR,GETDATE())																																							 /**/
/**/	AND ST_TURMA_ESCOLA <> 'E' AND CD_ESCOLA <> 888888																																										 /**/
/**/---------																																															 /**/
/**/CREATE INDEX TURMA_ESCOLA							ON ##D_TURMA_ESCOLA (CD_TURMA_ESCOLA)																											 /**/
/**/------------------------------------------------------------------------------------------------------------------------																			 /**/
/**/																																																	 /**/
/**/																																																	 /**/
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_MATRICULA') 																																 /**/
/**/	DROP TABLE ##D_MATRICULA																																										 /**/
/**/																																																	 /**/
/**/SELECT * INTO ##D_MATRICULA FROM D_MATRICULA m 																																		 /**/
/**/where an_letivo = datepart(year,getdate())																																							 /**/
/**/----------------																																													 /**/
/**/CREATE INDEX CD_MATRICULA								ON ##D_MATRICULA (CD_MATRICULA)																												 /**/
/**/----------------																																													 /**/
/**/------------------------------------------------------------------------------------------------------------------------																			 /**/
/**/																																																	 /**/
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_MATRICULA_TURMA_ESCOLA') 																													 /**/
/**/	DROP TABLE ##D_MATRICULA_TURMA_ESCOLA																																							 /**/
/**/																																																	 /**/
/**/SELECT 																																																 /**/
/**/	CD_TURMA_ESCOLA, CD_SITUACAO_ALUNO, A.CD_RENDIMENTO_PARECER_CONCLUSIVO,																															 /**/
/**/	QTD_MATR = COUNT(DISTINCT A.CD_MATRICULA), 																																						 /**/
/**/	QTD_MATR_2 = COUNT(DISTINCT(CASE WHEN ST_MATRICULA IN (1,2) THEN A.CD_MATRICULA END))																											 /**/
/**/	INTO ##D_MATRICULA_TURMA_ESCOLA																																									 /**/
/**/FROM Db_Local.DBO.D_MATRICULA_TURMA_ESCOLA A 																																						 /**/
/**/LEFT JOIN ##D_MATRICULA B ON A.CD_MATRICULA = B.CD_MATRICULA																																		 /**/
/**/WHERE EXISTS (	SELECT * FROM ##D_TURMA_ESCOLA B 																																					 /**/
/**/				WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA)																																		 /**/
/**/GROUP BY 																																															 /**/
/**/	CD_TURMA_ESCOLA, 																																												 /**/
/**/	CD_SITUACAO_ALUNO,																																												 /**/
/**/	A.CD_RENDIMENTO_PARECER_CONCLUSIVO																																								 /**/
/**/----------																																															 /**/
/**/CREATE INDEX CD_TURMA_ESCOLA							ON ##D_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)																								 /**/
/**/CREATE INDEX CD_SITUACAO_ALUNO							ON ##D_MATRICULA_TURMA_ESCOLA (CD_SITUACAO_ALUNO)																							 /**/
/**/------------------------------------------------------------------------------------------------------------------------																			 /**/
/**/																																																	 /**/	
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_HISTORICO_MATRICULA') 																														 /**/
/**/	DROP TABLE ##D_HISTORICO_MATRICULA																																								 /**/
/**/																																																	 /**/
/**/SELECT * INTO ##D_HISTORICO_MATRICULA FROM DBO.D_HISTORICO_MATRICULA				HM																										 /**/
/**/WHERE an_letivo = datepart(year,getdate())  																																						 /**/
/**/			CREATE INDEX CD_MATRICULA								ON ##D_HISTORICO_MATRICULA (CD_MATRICULA)																						 /**/
/**/------------------------------------------------------------------------------------------------------------------------																			 /**/
/**/																																																	 /**/
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_HISTORICO_MATRICULA_TURMA_ESCOLA') 																											 /**/
/**/	DROP TABLE ##D_HISTORICO_MATRICULA_TURMA_ESCOLA																																					 /**/
/**/																																																	 /**/
/**/SELECT 																																																 /**/
/**/	CD_TURMA_ESCOLA, CD_SITUACAO_ALUNO, 																																							 /**/
/**/	QTD_DIG = COUNT(DISTINCT A.CD_MATRICULA), 																																						 /**/
/**/	QTD_MATR = COUNT(DISTINCT A.CD_MATRICULA), 																																						 /**/
/**/	QTD_MATR_2 = COUNT(DISTINCT(CASE WHEN CD_SITUACAO_ALUNO = 5 AND ST_MATRICULA IN (1,2) THEN A.CD_MATRICULA END)),																				 /**/
/**/	PAR1 =  COUNT(DISTINCT(CASE WHEN CD_SITUACAO_ALUNO = 5 AND A.CD_RENDIMENTO_PARECER_CONCLUSIVO IN (1) THEN A.CD_MATRICULA ELSE NULL END)),															 /**/
/**/	PAR2 =  COUNT(DISTINCT(CASE WHEN CD_SITUACAO_ALUNO = 5 AND A.CD_RENDIMENTO_PARECER_CONCLUSIVO IN (2) THEN A.CD_MATRICULA ELSE NULL END)),															 /**/
/**/	PAR3 =  COUNT(DISTINCT(CASE WHEN CD_SITUACAO_ALUNO = 5 AND A.CD_RENDIMENTO_PARECER_CONCLUSIVO IN (3) THEN A.CD_MATRICULA ELSE NULL END))															 /**/
/**/INTO ##D_HISTORICO_MATRICULA_TURMA_ESCOLA FROM Db_Local.DBO.D_HISTORICO_MATRICULA_TURMA_ESCOLA A 																									 /**/
/**/LEFT JOIN ##D_HISTORICO_MATRICULA B ON A.CD_MATRICULA = B.CD_MATRICULA																																 /**/
/**/WHERE EXISTS (	SELECT * FROM ##D_TURMA_ESCOLA B 																																					 /**/
/**/				WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA)																																		 /**/
/**/	AND IN_UTILIZACAO_ESTORNO IS NULL																																								 /**/
/**/GROUP BY 																																															 /**/
/**/	CD_TURMA_ESCOLA, 																																												 /**/
/**/	CD_SITUACAO_ALUNO																																												 /**/
/**/-------------																																														 /**/
/**/	CREATE INDEX CD_TURMA_ESCOLA							ON ##D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_TURMA_ESCOLA)																				 /**/
/**/	CREATE INDEX CD_SITUACAO_ALUNO							ON ##D_HISTORICO_MATRICULA_TURMA_ESCOLA (CD_SITUACAO_ALUNO)																				 /**/
/**/------------------------------------------------------------------------------------------------------------------------------------																 /**/
/**/																																																	 /**/
/**/																																																	 /**/
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_AMBIENTE_ESCOLA')	 																														 /**/
/**/	DROP TABLE ##D_AMBIENTE_ESCOLA																																									 /**/
/**/																																																	 /**/
/**/SELECT * INTO ##D_AMBIENTE_ESCOLA FROM D_AMBIENTE_ESCOLA A																																			 /**/
/**/WHERE EXISTS (	SELECT * FROM ##D_TURMA_ESCOLA B 																																					 /**/
/**/				WHERE A.CD_AMBIENTE_ESCOLA = B.CD_AMBIENTE_ESCOLA)																																	 /**/
/**/---------																																															 /**/
/**/CREATE INDEX CD_AMBIENTE_ESCOLA								ON ##D_AMBIENTE_ESCOLA (CD_AMBIENTE_ESCOLA)																								 /**/
/**/------------------------------------------------------------------------------------------------------------------------------------																 /**/
/**/																																																	 /**/
/**/																																																	 /**/
/**/IF EXISTS 																																															 /**/
/**/	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##D_DIA_SEMANA_AULA_TURMA')	 																													 /**/
/**/	DROP TABLE ##D_DIA_SEMANA_AULA_TURMA																																							 /**/
/**/																																																	 /**/
/**/SELECT 																																																 /**/
/**/	CD_TURMA_ESCOLA  																																												 /**/
/**/	,SEG =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 2 ) THEN 1 ELSE 0 END 		 /**/
/**/	,TER =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 3 ) THEN 1 ELSE 0 END 		 /**/
/**/	,QUA =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 4 ) THEN 1 ELSE 0 END 		 /**/
/**/	,QUI =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 5 ) THEN 1 ELSE 0 END 		 /**/
/**/	,SEX =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 6 ) THEN 1 ELSE 0 END 		 /**/
/**/	,SAB =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 7 ) THEN 1 ELSE 0 END 		 /**/
/**/	,DOM =		CASE WHEN EXISTS (SELECT * FROM D_DIA_SEMANA_AULA_TURMA B WITH (NOLOCK) WHERE A.CD_TURMA_ESCOLA = B.CD_TURMA_ESCOLA AND NR_DIA_SEMANA = 1 ) THEN 1 ELSE 0 END,		 /**/
/**/	QTD_DIAS = COUNT(DISTINCT(CASE WHEN NR_DIA_SEMANA IS NOT NULL THEN NR_DIA_SEMANA ELSE NULL END))																								 /**/
/**/INTO ##D_DIA_SEMANA_AULA_TURMA FROM Db_Local.DBO.D_DIA_SEMANA_AULA_TURMA A																														 /**/
/**/WHERE EXISTS (SELECT * FROM ##D_TURMA_ESCOLA C WHERE A.CD_TURMA_ESCOLA = C.CD_TURMA_ESCOLA)																											 /**/
/**/GROUP BY CD_TURMA_ESCOLA																																											 /**/
/**/	CREATE INDEX CD_TURMA_ESCOLA							ON ##D_DIA_SEMANA_AULA_TURMA (CD_TURMA_ESCOLA)																							 /**/
/**/	--SELECT * FROM ##D_DIA_SEMANA_AULA_TURMA																																						 /**/
/**/																																																	 /**/
/**/-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------/**/


IF EXISTS 																																										
	(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##TABELA')	 																												
	DROP TABLE ##TABELA																																							


SELECT
	 UE.CD_UNIDADE_EDUCACAO
	,TE.AN_LETIVO
	,TE.CD_TURMA_ESCOLA
	,TE.CD_TIPO_PERIODICIDADE
	,TE.DC_TURMA_ESCOLA
	,TE.CD_TIPO_ATENDIMENTO 
	,TE.CD_TIPO_TURMA
	,TE.CD_TIPO_PROGRAMA
	,TE.ST_TURMA_ESCOLA 
	,TE.HO_ENTRADA
	,TE.HO_SAIDA
	,TE.DT_INICIO_TURMA--
	,TE.DT_FIM_TURMA--
	,TE.DT_INICIO--
	,TE.DT_FIM--
	,TE.CD_TIPO_TURNO
	,TE.QT_VAGA_OFERECIDA
	,EE.CD_MODALIDADE_ENSINO
	,EE.CD_ETAPA_ENSINO
	,EE.SG_ETAPA
	,SE.CD_CICLO_ENSINO
	,SE.CD_SERIE_ENSINO
	,SE.DC_SERIE_ENSINO
	,TE.CD_AMBIENTE_ESCOLA
	,TA.DC_TIPO_AMBIENTE
	,NR_SALA
	,QT_AREA_UTIL
	,QT_IDEAL_PESSOA
	,QT_REAL_PESSOA
	,TE.CD_TURMA_PRODESP
	,QTD_DIAS = CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 5 ELSE ISNULL(DSAT.QTD_DIAS,0) END --SELECT * FROM D_CORRESPONDENCIA_SERIE_EOL
	,SEG =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.SEG,0)  END 
	,TER =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.TER,0)  END 
	,QUA =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.QUA,0)  END 
	,QUI =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.QUI,0)  END 
	,SEX =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.SEX,0)  END 
	,SAB =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 0 ELSE ISNULL(DSAT.SAB,0)  END 
	,DOM =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 0 ELSE ISNULL(DSAT.DOM,0)  END 
	,DURACAO = CASE WHEN LEN(QT_HORA_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_HORA_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_HORA_DURACAO) END +':' + 	CASE WHEN LEN(QT_MINUTO_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) END  
	,AL_DI =	SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 1				THEN MTE.QTD_MATR ELSE 0 END))--29SEG
	,AL_PEN_REM=SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 6				THEN MTE.QTD_MATR ELSE 0 END))--1,01SEG
	,AL_DESLOC =SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 11				THEN MTE.QTD_MATR ELSE 0 END))--1,35SEG
	,AL_AT =	SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO IN (1,5,6,10,13)		THEN MTE.QTD_MATR_2 ELSE 0 END))--3,30
	,AL_TRANSF =SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 3				THEN MTE.QTD_MATR ELSE 0 END))--2,05
	,AL_FALEC = SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 7				THEN MTE.QTD_MATR ELSE 0 END))--
	,AL_NCOM =	SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 8				THEN MTE.QTD_MATR ELSE 0 END))
	,AL_EXCL =	SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 4				THEN MTE.QTD_MATR ELSE 0 END))
	,AL_CESSA = SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 12				THEN MTE.QTD_MATR ELSE 0 END))
	,AL_REMAN = SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 14				THEN MTE.QTD_MATR ELSE 0 END))
	,AL_RECLAS =SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 15				THEN MTE.QTD_MATR ELSE 0 END))
	,AL_APROV = SUM((CASE WHEN MTE.CD_RENDIMENTO_PARECER_CONCLUSIVO = 1 THEN ISNULL(MTE.QTD_MATR,0) ELSE 0 END))
	,AL_REPRON =SUM((CASE WHEN MTE.CD_RENDIMENTO_PARECER_CONCLUSIVO = 2 THEN ISNULL(MTE.QTD_MATR,0) ELSE 0 END))
	,AL_REPROF =SUM((CASE WHEN MTE.CD_RENDIMENTO_PARECER_CONCLUSIVO = 3 THEN ISNULL(MTE.QTD_MATR,0) ELSE 0 END))
	,AL_EVAD =	SUM((CASE WHEN MTE.CD_SITUACAO_ALUNO = 2				THEN MTE.QTD_MATR ELSE 0 END))
	,TE.CRDATE
 INTO ##TABELA 	
	 FROM D_UNIDADE_EDUCACAO									UE																			
	 JOIN ##D_TURMA_ESCOLA						TE	WITH (NOLOCK) ON UE.CD_UNIDADE_EDUCACAO = TE.CD_ESCOLA								
LEFT JOIN ##D_MATRICULA_TURMA_ESCOLA				MTE WITH (NOLOCK) ON TE.CD_TURMA_ESCOLA = MTE.CD_TURMA_ESCOLA								
LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL			CSE WITH (NOLOCK) ON TE.CD_CORRESPONDENCIA_SERIE = CSE.CD_CORRESPONDENCIA_SERIE			
LEFT JOIN D_SERIE_ENSINO							SE	WITH (NOLOCK) ON CSE.CD_SERIE_EOL2007 = SE.CD_SERIE_ENSINO	
LEFT JOIN D_ETAPA_ENSINO							EE	WITH (NOLOCK) ON SE.CD_ETAPA_ENSINO = EE.CD_ETAPA_ENSINO
LEFT JOIN ##D_AMBIENTE_ESCOLA					AE	WITH (NOLOCK) ON TE.CD_AMBIENTE_ESCOLA = AE.CD_AMBIENTE_ESCOLA
LEFT JOIN D_TIPO_AMBIENTE						TA	WITH (NOLOCK) ON AE.TP_AMBIENTE = TA.TP_AMBIENTE
LEFT JOIN ##D_DIA_SEMANA_AULA_TURMA				DSAT WITH (NOLOCK) ON TE.CD_TURMA_ESCOLA = DSAT.CD_TURMA_ESCOLA --SELECT * FROM ##D_DIA_SEMANA_AULA_TURMA
LEFT JOIN D_DURACAO_TIPO_TURNO					MTT WITH (NOLOCK) ON TE.CD_DURACAO = MTT.CD_DURACAO 
WHERE 
	UE.TP_UNIDADE_EDUCACAO = 1 
	AND UE.TP_SITUACAO_UNIDADE = 1

	--AND TE.CD_TIPO_TURMA = 1 
	--AND TE.CD_TURMA_ESCOLA = 1916269
GROUP BY  
UE.CD_UNIDADE_EDUCACAO
	,TE.AN_LETIVO
	,TE.CD_TURMA_ESCOLA
	,TE.CD_TIPO_PERIODICIDADE
	,TE.DC_TURMA_ESCOLA
	,TE.CD_TIPO_ATENDIMENTO
	,TE.CD_TIPO_TURMA
	,TE.CD_TIPO_PROGRAMA
	,TE.ST_TURMA_ESCOLA 
	,TE.HO_ENTRADA
	,TE.HO_SAIDA
	,TE.DT_INICIO_TURMA
	,TE.DT_FIM_TURMA
	,TE.DT_INICIO
	,TE.DT_FIM
	,TE.CD_TIPO_TURNO
	,TE.QT_VAGA_OFERECIDA
	,QT_IDEAL_PESSOA
	,QT_REAL_PESSOA
	,QT_AREA_UTIL
	,TE.CD_AMBIENTE_ESCOLA
	,TA.DC_TIPO_AMBIENTE
	,NR_SALA
	,EE.CD_MODALIDADE_ENSINO
	,EE.CD_ETAPA_ENSINO
	,EE.SG_ETAPA
	,SE.CD_CICLO_ENSINO
	,SE.CD_SERIE_ENSINO
	,SE.DC_SERIE_ENSINO
	,TE.CD_TURMA_PRODESP
	,CASE WHEN LEN(QT_HORA_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_HORA_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_HORA_DURACAO) END +':' + 	CASE WHEN LEN(QT_MINUTO_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) END  
	,CD_SERIE_EOL2007
	,TE.CRDATE
	,DSAT.QTD_DIAS
	,SEG
	,TER
	,QUA
	,QUI
	,SEX
	,SAB
	,DOM









INSERT ##TABELA
SELECT --TOP 5 
	 UE.CD_UNIDADE_EDUCACAO
	,TE.AN_LETIVO
	,TE.CD_TURMA_ESCOLA
	,TE.CD_TIPO_PERIODICIDADE
	,TE.DC_TURMA_ESCOLA
	,TE.CD_TIPO_ATENDIMENTO
	,TE.CD_TIPO_TURMA
	,TE.CD_TIPO_PROGRAMA
	,TE.ST_TURMA_ESCOLA 
	,TE.HO_ENTRADA
	,TE.HO_SAIDA
	,TE.DT_INICIO_TURMA--
	,TE.DT_FIM_TURMA--
	,TE.DT_INICIO--
	,TE.DT_FIM--
	,TE.CD_TIPO_TURNO
	,TE.QT_VAGA_OFERECIDA
	,EE.CD_MODALIDADE_ENSINO
	,EE.CD_ETAPA_ENSINO
	,EE.SG_ETAPA
	,SE.CD_CICLO_ENSINO
	,SE.CD_SERIE_ENSINO
	,SE.DC_SERIE_ENSINO
	,TE.CD_AMBIENTE_ESCOLA
	,TA.DC_TIPO_AMBIENTE
	,NR_SALA
	,QT_AREA_UTIL
	,QT_IDEAL_PESSOA
	,QT_REAL_PESSOA
	,TE.CD_TURMA_PRODESP
	,QTD_DIAS = CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 5 ELSE ISNULL(DSAT.QTD_DIAS,0) END --SELECT * FROM D_CORRESPONDENCIA_SERIE_EOL
	,SEG =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.SEG,0)  END 
	,TER =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.TER,0)  END 
	,QUA =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.QUA,0)  END 
	,QUI =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.QUI,0)  END 
	,SEX =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 1 ELSE ISNULL(DSAT.SEX,0)  END 
	,SAB =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 0 ELSE ISNULL(DSAT.SAB,0)  END 
	,DOM =		CASE WHEN CSE.CD_SERIE_EOL2007 IS NOT NULL THEN 0 ELSE ISNULL(DSAT.DOM,0)  END 
	,DURACAO = CASE WHEN LEN(QT_HORA_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_HORA_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_HORA_DURACAO) END +':' + 	CASE WHEN LEN(QT_MINUTO_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) END  
	,AL_DI =	SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 1		THEN HMTE.QTD_MATR END ))
	,AL_PEN_REM=SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 6		THEN HMTE.QTD_MATR  ELSE 0 END))
	,AL_DESLOC =SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 11		THEN HMTE.QTD_MATR  ELSE 0 END))
	,AL_AT =	SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO IN (5)	THEN HMTE.QTD_MATR_2 ELSE 0   END))
	,AL_TRANSF =SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 3		THEN HMTE.QTD_MATR	ELSE 0 END))
	,AL_FALEC = SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 7		THEN HMTE.QTD_MATR	ELSE 0 END))
	,AL_NCOM =	SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 8		THEN HMTE.QTD_MATR	ELSE 0 END))
	,AL_EXCL =	SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 4		THEN HMTE.QTD_MATR	ELSE 0 END))
	,AL_CESSA = SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO =12		THEN HMTE.QTD_MATR	ELSE 0 END ))
	,AL_REMAN = SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO =14		THEN HMTE.QTD_MATR	ELSE 0 END ))
	,AL_RECLAS =SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO =15		THEN HMTE.QTD_MATR	ELSE 0 END ))
	,AL_APROV = SUM(PAR1)
	,AL_REPRON =SUM(PAR2)
	,AL_REPROF =SUM(PAR3)
	,AL_EVAD =	SUM((CASE WHEN HMTE.CD_SITUACAO_ALUNO = 2 THEN HMTE.QTD_MATR END ))
	,TE.CRDATE

	 FROM D_UNIDADE_EDUCACAO									UE																			
	 JOIN ##D_TURMA_ESCOLA						TE	WITH (NOLOCK) ON UE.CD_UNIDADE_EDUCACAO = TE.CD_ESCOLA								
LEFT JOIN ##D_HISTORICO_MATRICULA_TURMA_ESCOLA	HMTE WITH (NOLOCK)  ON TE.CD_TURMA_ESCOLA = HMTE.CD_TURMA_ESCOLA							
LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL			CSE WITH (NOLOCK) ON TE.CD_CORRESPONDENCIA_SERIE = CSE.CD_CORRESPONDENCIA_SERIE			
LEFT JOIN D_SERIE_ENSINO							SE	WITH (NOLOCK) ON CSE.CD_SERIE_EOL2007 = SE.CD_SERIE_ENSINO							
LEFT JOIN D_ETAPA_ENSINO							EE	WITH (NOLOCK) ON SE.CD_ETAPA_ENSINO = EE.CD_ETAPA_ENSINO
LEFT JOIN ##D_AMBIENTE_ESCOLA					AE	WITH (NOLOCK) ON TE.CD_AMBIENTE_ESCOLA = AE.CD_AMBIENTE_ESCOLA
LEFT JOIN D_TIPO_AMBIENTE						TA	WITH (NOLOCK) ON AE.TP_AMBIENTE = TA.TP_AMBIENTE
LEFT JOIN ##D_DIA_SEMANA_AULA_TURMA				DSAT WITH (NOLOCK) ON TE.CD_TURMA_ESCOLA = DSAT.CD_TURMA_ESCOLA
LEFT JOIN D_DURACAO_TIPO_TURNO					MTT WITH (NOLOCK) ON TE.CD_DURACAO = MTT.CD_DURACAO
WHERE 
	UE.TP_UNIDADE_EDUCACAO = 1 
	AND UE.TP_SITUACAO_UNIDADE = 1
	--AND TE.CD_TIPO_TURMA = 1 
	--AND TE.CD_TURMA_ESCOLA = 1916269


GROUP BY  UE.CD_UNIDADE_EDUCACAO
	,TE.AN_LETIVO
	,TE.CD_TURMA_ESCOLA
	,TE.CD_TIPO_PERIODICIDADE
	,TE.DC_TURMA_ESCOLA
	,TE.CD_TIPO_ATENDIMENTO
	,TE.CD_TIPO_TURMA
	,TE.CD_TIPO_PROGRAMA
	,TE.ST_TURMA_ESCOLA 
	,TE.HO_ENTRADA
	,TE.HO_SAIDA
	,TE.DT_INICIO_TURMA
	,TE.DT_FIM_TURMA
	,TE.DT_INICIO
	,TE.DT_FIM
	,TE.CD_TIPO_TURNO
	,TE.QT_VAGA_OFERECIDA
	,QT_IDEAL_PESSOA
	,QT_REAL_PESSOA
	,QT_AREA_UTIL
	,TE.CD_AMBIENTE_ESCOLA
	,TA.DC_TIPO_AMBIENTE
	,NR_SALA
	,EE.CD_MODALIDADE_ENSINO
	,EE.CD_ETAPA_ENSINO
	,EE.SG_ETAPA
	,SE.CD_CICLO_ENSINO
	,SE.CD_SERIE_ENSINO
	,SE.DC_SERIE_ENSINO
	,TE.CD_TURMA_PRODESP
	,CASE WHEN LEN(QT_HORA_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_HORA_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_HORA_DURACAO) END +':' + 	CASE WHEN LEN(QT_MINUTO_DURACAO) =  1 THEN '0' + CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) ELSE CONVERT(NVARCHAR(2), QT_MINUTO_DURACAO) END  
	,CD_SERIE_EOL2007
	,TE.CRDATE
	,DSAT.QTD_DIAS
	,SEG
	,TER
	,QUA
	,QUI
	,SEX
	,SAB
	,DOM


-------------------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS 																																										
	(SELECT * FROM Db_Local..SYSOBJECTS WHERE NAME = 'SME_CLASSES_DIARIO')	 																												
	DROP TABLE SME_CLASSES_DIARIO		

SELECT 
	 CD_UNIDADE_EDUCACAO as CD_ESCOLA
	,AN_LETIVO
	,CD_TURMA_ESCOLA
	,CD_TIPO_PERIODICIDADE
	,DC_TURMA_ESCOLA
	,CD_TIPO_ATENDIMENTO
	,CD_TIPO_TURMA
	,CD_TIPO_PROGRAMA
	,ST_TURMA_ESCOLA 
	,HO_ENTRADA
	,HO_SAIDA
	,DT_INICIO_TURMA--
	,DT_FIM_TURMA--
	,DT_INICIO--
	,DT_FIM--
	,CD_TIPO_TURNO
	,QT_VAGA_OFERECIDA
	,CD_MODALIDADE_ENSINO
	,CD_ETAPA_ENSINO
	,SG_ETAPA
	,CD_CICLO_ENSINO
	,CD_SERIE_ENSINO
	,DC_SERIE_ENSINO
	,CD_AMBIENTE_ESCOLA
	,DC_TIPO_AMBIENTE
	,NR_SALA
	,QT_AREA_UTIL
	,QT_IDEAL_PESSOA
	,QT_REAL_PESSOA
	,CD_TURMA_PRODESP
	,QTD_DIAS
	,SEG	
	,TER	
	,QUA	
	,QUI	
	,SEX	
	,SAB	
	,DOM	
	,DURACAO
	,SUM(AL_DI)		 AS AL_DI
	,SUM(AL_PEN_REM) AS AL_PEN_REM
	,SUM(AL_DESLOC)	 AS AL_DESLOC
	,SUM(AL_AT)		 AS AL_AT
	,SUM(AL_TRANSF)	 AS AL_TRANSF
	,SUM(AL_FALEC)	 AS AL_FALEC
	,SUM(AL_NCOM)	 AS AL_NCOM
	,SUM(AL_EXCL)	 AS AL_EXCL
	,SUM(AL_CESSA)	 AS AL_CESSA
	,SUM(AL_REMAN)	 AS AL_REMAN
	,SUM(AL_RECLAS)	 AS AL_RECLAS
	,SUM(AL_APROV)	 AS AL_APROV
	,SUM(AL_REPRON)	 AS AL_REPRON
	,SUM(AL_REPROF)	 AS AL_REPROF
	,SUM(AL_EVAD)	 AS AL_EVAD
	,CRDATE
INTO SME_CLASSES_DIARIO
FROM ##TABELA	
GROUP BY 	 CD_UNIDADE_EDUCACAO
	,AN_LETIVO
	,CD_TURMA_ESCOLA
	,CD_TIPO_PERIODICIDADE
	,DC_TURMA_ESCOLA
	,CD_TIPO_ATENDIMENTO
	,CD_TIPO_TURMA
	,CD_TIPO_PROGRAMA
	,ST_TURMA_ESCOLA 
	,HO_ENTRADA
	,HO_SAIDA
	,DT_INICIO_TURMA--
	,DT_FIM_TURMA--
	,DT_INICIO--
	,DT_FIM--
	,CD_TIPO_TURNO
	,QT_VAGA_OFERECIDA
	,CD_MODALIDADE_ENSINO
	,CD_ETAPA_ENSINO
	,SG_ETAPA
	,CD_CICLO_ENSINO
	,CD_SERIE_ENSINO
	,DC_SERIE_ENSINO
	,CD_AMBIENTE_ESCOLA
	,DC_TIPO_AMBIENTE
	,NR_SALA
	,QT_AREA_UTIL
	,QT_IDEAL_PESSOA
	,QT_REAL_PESSOA
	,CD_TURMA_PRODESP
	,QTD_DIAS
	,SEG	
	,TER	
	,QUA	
	,QUI	
	,SEX	
	,SAB	
	,DOM	
	,DURACAO
	,CRDATE

CREATE INDEX INDEX_CD_TURMA_ESCOLA							ON SME_CLASSES_DIARIO (CD_TURMA_ESCOLA)
CREATE INDEX INDEX_CD_UNIDADE_EDUCACAO						ON SME_CLASSES_DIARIO (CD_ESCOLA)

--EXEC GERA_CLASSES_DIARIO
--SELECT * FROM SME_CLASSES_DIARIO
