USE Db_Local

IF EXISTS 
	(SELECT 'TRUE' FROM Db_Local..SYSOBJECTS WHERE NAME = 'ALUNOS_CADASTRO')
DROP TABLE ALUNOS_CADASTRO


SELECT	DISTINCT	
		DRE,
		DISTR,
		SETOR,
		SG_TP_ESCOLA,
		CD_ESCOLA,
		NM_UNIDADE_EDUCACAO,
		SUB_SOLICITACAO.CD_SOLICITACAO_MATRICULA,	
		ORIGEM,
		CD_ALUNO,
		DT_NASCIMENTO_ALUNO,
		[NM_ALUNO],
		NM_MAE,
		NIS,
		SUB_FAIXA_SERIE.DC_ETAPA_ENSINO,
		--SUB_FAIXA_SERIE.CD_CICLO_ENSINO,
		SUB_FAIXA_SERIE.CD_SERIE_ENSINO AS [CÓD. SÉR. ENS.],
		SUB_FAIXA_SERIE.SG_SERIE_ENSINO AS [DESC. SÉR. ENS.],
		DT_INSCRICAO,
		[DT CADASTRO/REATIVAÇÃO],
		[DT CARGA],
		AGUARDANDO,
		TP_PREFERENCIA,
		CD_SOLICITACAO_MATRICULA_PREFERENCIAL,
		CD_UNIDADE_EDUCACAO, 
		DC_OBSERVACAO_STATUS,
		DT_INICIO,
		LOGRADOURO_ALU,	
		NR_ALU, 
		COMP_ALU,
		BAIRRO_ALU,	
		CEP_ALU,	
		MUN_ALU,
		DISTR_ALU,
		SETOR_ALU,
		CD_COORDENADA_GEO_Y AS CD_COORDENADA_GEO_Y, 
		CD_COORDENADA_GEO_X AS CD_COORDENADA_GEO_X, 
		CASE WHEN CD_COORDENADA_GEO_Y IS NOT NULL THEN CD_COORDENADA_GEO_Y * 1000000 ELSE 9999999 END AS COORDENADA_Y_ALU,
		CASE WHEN CD_COORDENADA_GEO_X IS NOT NULL THEN CD_COORDENADA_GEO_X * 1000000 ELSE 9999999 END AS COORDENADA_X_ALU,
		--CADUNICO = CASE WHEN B.NOM_PESSOA IS NOT NULL OR C.NOM_PESSOA IS NOT NULL THEN 'S' ELSE 'N' END,
		--BOLSA_FAMILIA = CASE WHEN B.RECEBE_PBF = 'SIM' OR C.RECEBE_PBF = 'SIM' THEN 'S' ELSE 'N' END,
		SUB_SOLICITACAO.CRDATE
		INTO ALUNOS_CADASTRO
							FROM(	
									SELECT	RIGHT(G.NM_UNIDADE_EDUCACAO, (LEN(G.NM_UNIDADE_EDUCACAO)+1) - REVERSE(CHARINDEX('EDUCACAO', G.NM_UNIDADE_EDUCACAO))) AS DRE,
											LEFT(I.NM_MICRO_REGIAO,CHARINDEX('SETOR', I.NM_MICRO_REGIAO)-1) AS DISTR,
											RIGHT(I.NM_MICRO_REGIAO,2) SETOR,
											J.SG_TP_ESCOLA,
											A.CD_UNIDADE_EDUCACAO AS CD_ESCOLA,
											F.NM_UNIDADE_EDUCACAO,
											A.TP_ORIGEM,
											B.CD_ALUNO, 
											B.NM_ALUNO AS [NM_ALUNO],
											B.nm_mae_aluno AS [NM_MAE],
											B.DT_NASCIMENTO_ALUNO,
											B.cd_identificacao_social AS NIS,
											A.CD_SOLICITACAO_MATRICULA,
											TSP.CD_NIVEL_PRIORIDADE,
											ORIGEM = CASE	WHEN TP_ORIGEM = 'C' THEN 'Cadastro Infantil'
															WHEN TP_ORIGEM = 'A' THEN 'Cadastro EJA'
															WHEN TP_ORIGEM = 'T' THEN 'Transferencia Infantil'
															WHEN TP_ORIGEM = 'P' THEN 'PRODESP'
															WHEN TP_ORIGEM = 'I' THEN 'Continuidade Infantil'
															WHEN TP_ORIGEM = 'R' THEN 'Transferencia EJA' END,
											CONVERT(DATE,DT_INSCRICAO,109) AS DT_INSCRICAO,
											CONVERT(DATE,DT_STATUS_SOLICITACAO,109) AS [DT CADASTRO/REATIVAÇÃO],
											CONVERT(DATE,DT_ATLZ_TAB,109) AS [DT CARGA],
											DATEDIFF(DAY,DT_STATUS_SOLICITACAO,GETDATE()) AS AGUARDANDO,
											E.NM_LOGRADOURO AS LOGRADOURO_ALU,	
											E.CD_NR_ENDERECO AS NR_ALU, 
											E.DC_COMPLEMENTO_ENDERECO COMP_ALU,
											E.NM_BAIRRO AS BAIRRO_ALU,	
											E.CD_CEP AS CEP_ALU,	
											EE.NM_MUNICIPIO AS MUN_ALU,
											LEFT(I.NM_MICRO_REGIAO,CHARINDEX('SETOR', I.NM_MICRO_REGIAO)-1) AS DISTR_ALU,
											RIGHT(I.NM_MICRO_REGIAO,2) SETOR_ALU,
											CD_COORDENADA_GEO_Y AS CD_COORDENADA_GEO_Y,
											CD_COORDENADA_GEO_X AS CD_COORDENADA_GEO_X, 
											CASE WHEN CD_COORDENADA_GEO_Y IS NOT NULL THEN CD_COORDENADA_GEO_Y * 1000000 ELSE 9999999 END AS COORDENADA_Y_ALU,
											CASE WHEN CD_COORDENADA_GEO_X IS NOT NULL THEN CD_COORDENADA_GEO_X * 1000000 ELSE 9999999 END AS COORDENADA_X_ALU,
											SMP.TP_PREFERENCIA,
											SMP.CD_SOLICITACAO_MATRICULA_PREFERENCIAL,
											SMP.CD_UNIDADE_EDUCACAO, 
											SMP.DC_OBSERVACAO_STATUS,
											SMP.DT_INICIO,
											A.CRDATE										
											FROM		D_SOLICITACAO_MATRICULA A 
											LEFT JOIN	D_ALUNO B				ON A.CD_ALUNO = B.CD_ALUNO 
											LEFT JOIN	D_ENDERECO_ALUNO C						ON B.CD_ALUNO = C.CD_ALUNO 
											LEFT JOIN	D_ENDERECO_ALUNO_TIPO_ENDERECO D		ON C.CD_ENDERECO_ALUNO = D.CD_ENDERECO_ALUNO 
											LEFT JOIN	D_ENDERECO E							ON C.CI_ENDERECO = E.CI_ENDERECO
											LEFT JOIN	D_MUNICIPIO	EE ON E.CD_MUNICIPIO = EE.CD_MUNICIPIO
											LEFT JOIN	D_MICRO_REGIAO I ON A.CD_MICRO_REGIAO = I.CD_MICRO_REGIAO AND I.cd_micro_regiao>0
											LEFT JOIN	D_UNIDADE_EDUCACAO F	ON A.CD_UNIDADE_EDUCACAO = F.CD_UNIDADE_EDUCACAO
											LEFT JOIN	D_UNIDADE_EDUCACAO G	ON F.CD_UNIDADE_ADMINISTRATIVA_REFERENCIA = G.CD_UNIDADE_EDUCACAO
											LEFT OUTER JOIN	(--TABELA DE SOLICITACAO DE MATRICULA PRIORIDADE AGRUPANDO TODOS OS REGISTROS DE SOLICITACAO DE MATRICULA COM A PRIORIDADE MAIS URGENTE
															SELECT	CD_SOLICITACAO_MATRICULA, 
																	MIN(CD_NIVEL_PRIORIDADE) AS CD_NIVEL_PRIORIDADE
																	FROM D_SOLICITACAO_MATRICULA_PRIORIDADE AS A --RELACIONANDO A TABELA DE SOLICTACAO_MATRICULA_PRIORIDADE COM A TIPO_PRIORIDADE PARA PODER PEGAR O NÍVEL DA PRIORIDADE MAIS URGENTE
																	INNER JOIN	TIPO_PRIORIDADE_LISTA AS B ON CD_PRIORIDADE_LISTA = CD_TIPO_PRIORIDADE
																	WHERE	DT_FIM IS NULL --CONSIDERANDO SOMENTE OS REGISTROS DE PRIORIDADES ATIVOS, POIS HÁ CASOS QUE HOUVERAM MUDANÇA NO NÍVEL DE PRIORIDADE DAQUELA CRIANÇA
																	GROUP BY	CD_SOLICITACAO_MATRICULA --AGRUPANDO PELO CD_SOLICITACAO_MATRICULA, POIS HÁ ALGUNS CASOS ONDE HÁ MAIS DE UM NÍVEL DE PRIORIDA ATIVO, CONSIDEROU-SE O REGISTRO COM O NÍVEL DE PRIORIDADE MAIS URGENTE
															) AS TSP ON A.CD_SOLICITACAO_MATRICULA = TSP.CD_SOLICITACAO_MATRICULA
											LEFT JOIN D_ESCOLA Z ON F.CD_UNIDADE_EDUCACAO = Z.CD_ESCOLA
											LEFT JOIN TIPO_ESCOLA J ON Z.TP_ESCOLA = J.TP_ESCOLA
											LEFT JOIN D_solicitacao_matricula_preferencial SMP ON  a.CD_SOLICITACAO_MATRICULA = SMP.CD_SOLICITACAO_MATRICULA AND SMP.DT_FIM IS NULL AND (convert(date,a.DT_STATUS_SOLICITACAO) BETWEEN CONVERT(DATE,SMP.DT_INICIO) AND CONVERT(DATE,ISNULL(SMP.DT_FIM,CONVERT(DATE,'2099-12-18 00:00:00.000'))) or  convert(date,a.DT_ENDERECO_BASE) BETWEEN CONVERT(DATE,SMP.DT_INICIO) AND CONVERT(DATE,ISNULL(SMP.DT_FIM,CONVERT(DATE,'2099-12-18 00:00:00.000')))
																																													or CONVERT(DATE,SMP.DT_INICIO) >= convert(date,a.DT_STATUS_SOLICITACAO) AND SMP.DT_FIM IS NULL)

											WHERE                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
											A.CD_ETAPA_ENSINO = 1
											AND ST_SOLICITACAO = 'S' 
											AND tp_origem = 'C'
											AND D.CI_TIPO_ENDERECO = 1 
											AND D.DT_FIM IS NULL 
											AND C.DT_FIM IS NULL
											AND (E.CD_MUNICIPIO=3550308 OR E.CD_CEP BETWEEN 01000000 AND 05999999 OR E.CD_CEP BETWEEN 08000000 AND 08499999)
											) AS SUB_SOLICITACAO
							INNER JOIN (	SELECT	DISTINCT --EM TESE NÃO DEVERIA HAVER DUPLICADAS, MAS POR SEGURANÇA
													CD_FAIXA,
													CONVERT(DATETIME,CONVERT(VARCHAR(4),DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA) + CONVERT(VARCHAR(2), MM_INICIO_FAIXA) + CONVERT(VARCHAR(2), DD_INICIO_FAIXA)) AS DT_INICIO_FAIXA,
													CONVERT(DATETIME,CONVERT(VARCHAR(4),DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_FIM_FAIXA) + CONVERT(VARCHAR(2), MM_FIM_FAIXA) + CONVERT(VARCHAR(2), DD_FIM_FAIXA)) AS DT_FIM_FAIXA,
													CASE 
														WHEN (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ - (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA)) = 1 THEN '0 E 1 ANO'
														ELSE CONVERT(VARCHAR(2),(DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ - (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA))) + ' ANOS' 
														END AS IDADE,
													T1.CD_SERIE_ENSINO, 
													T2.DC_SERIE_ENSINO,
													T2.CD_CICLO_ENSINO,
													T2.SG_SERIE_ENSINO,
													T2.cd_etapa_ensino,
													T3.dc_etapa_ensino
											FROM	D_FAIXA_SERIE AS T1
											INNER JOIN D_SERIE_ENSINO AS T2 ON T1.CD_SERIE_ENSINO = T2.CD_SERIE_ENSINO
											INNER JOIN D_ETAPA_ENSINO AS T3 ON T2.cd_etapa_ensino = T3.cd_etapa_ensino
											WHERE	T1.DT_INICIO <= GETDATE()
													AND (T1.DT_FIM IS NULL OR T1.DT_FIM >= CONVERT(DATE,GETDATE()))
													AND TP_FAIXA =5
											) AS SUB_FAIXA_SERIE
							ON  SUB_SOLICITACAO.DT_NASCIMENTO_ALUNO >= SUB_FAIXA_SERIE.DT_INICIO_FAIXA
							AND SUB_SOLICITACAO.DT_NASCIMENTO_ALUNO <= SUB_FAIXA_SERIE.DT_FIM_FAIXA
							--WHERE CD_CICLO_ENSINO = 2
							/*
							LEFT JOIN (select * from CADUNICO_0A7ANOS 
										where	COD_EST_CADASTRAL_FAM = 3 
												and COD_EST_CADASTRAL_MEMB = 3) B ON 	[NM_ALUNO] = B.NOM_PESSOA COLLATE SQL_Latin1_General_CP1_CI_AI
																						AND [NM_MAE] =B.NOM_COMPLETO_MAE_PESSOA COLLATE SQL_Latin1_General_CP1_CI_AI
																						AND DT_NASCIMENTO_ALUNO = CONVERT(DATE,CONVERT(VARCHAR,B.DTA_NASC_PESSOA),103)
																						
							LEFT JOIN (select * from CADUNICO_0A7ANOS
										where	COD_EST_CADASTRAL_FAM = 3 
												and COD_EST_CADASTRAL_MEMB = 3) C ON 	NIS = C.NUM_NIS_PESSOA_ATUAL COLLATE SQL_Latin1_General_CP1_CI_AI
							*/
------------------------------------------------------------------------------------------------------------------------------------------------------
-- SELECT * FROM ALUNOS_CADASTRO
------------------------------------------------------------------------------------------------------------------------------------------------------
--DEMANDA POR DRE - RESUMO
------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE RESUMO_ALUNOS_CADASTRO
SELECT
	 DRE= CASE WHEN DRE IS NULL THEN 'TOTAL' ELSE DRE END, 
	 [BERC I],
	 [BERC II],
	 [MG I],
	 [MG II],
	 [INFANTIL I],
	 [INFANTIL II],
	 [TOTAL GERAL]
	 INTO RESUMO_ALUNOS_CADASTRO
FROM (
		SELECT 

				DRE,
				COUNT (DISTINCT CASE WHEN [DESC. SÉR. ENS.] = 'BERC I' THEN CD_ALUNO ELSE NULL END) AS [BERC I],
				COUNT (DISTINCT CASE WHEN [DESC. SÉR. ENS.] = 'BERC II' THEN CD_ALUNO ELSE NULL END) AS [BERC II],
				COUNT (DISTINCT CASE WHEN [DESC. SÉR. ENS.] = 'MG I' THEN CD_ALUNO ELSE NULL END) AS [MG I],
				COUNT (DISTINCT CASE WHEN [DESC. SÉR. ENS.] = 'MG II' THEN CD_ALUNO ELSE NULL END) AS [MG II],
				COUNT (DISTINCT CASE WHEN [DESC. SÉR. ENS.] = 'INFANTIL I' THEN CD_ALUNO ELSE NULL END) AS [INFANTIL I],
				COUNT (DISTINCT CASE WHEN [DESC. SÉR. ENS.] = 'INFANTIL II' THEN CD_ALUNO ELSE NULL END) AS [INFANTIL II],
				COUNT (DISTINCT CASE WHEN [DC_ETAPA_ENSINO] = 'EDUCACAO INFANTIL' THEN CD_ALUNO ELSE NULL END) AS [TOTAL GERAL]

		FROM ALUNOS_CADASTRO
GROUP BY
DRE
WITH ROLLUP)  AS A

--SELECT * FROM RESUMO_ALUNOS_CADASTRO ORDER BY 1

--select * from D_FAIXA_SERIE

--SELECT * FROM D_SERIE_ENSINO

--SELECT * FROM D_ETAPA_ENSINO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE Db_Local

DECLARE @an_letivo int SET @an_letivo = 0  -- zero para ano letivo vigente
DECLARE @cd_escola int SET @cd_escola = 0  -- zero para quando não for escola especifica

---------------------------------------------------------------------------------------------------------------------------------------------------------
--EXEC PROC_AUX_MIEST
---------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @DURCLASSE INT SET @DURCLASSE = 0 
DECLARE @SEMESTRE DATE SET @SEMESTRE = '2010-07-21' 

      IF (SELECT  MIN(case when @an_letivo = 0 then YEAR(GETDATE()) else @an_letivo end)  FROM /*EOL.SE1426.DBO.*/D_TURMA_ESCOLA) > YEAR(GETDATE()) 
         (SELECT @DURCLASSE = @DURCLASSE + 2) 
  ELSE
  
  IF MONTH(@SEMESTRE) < MONTH(GETDATE()) 
 (SELECT @DURCLASSE = @DURCLASSE + 1) 
  ELSE 
 (SELECT @DURCLASSE = @DURCLASSE + 2)


 DROP TABLE SALDO_VAGAS
 


 SELECT	DRE
		,DISTR
		,SETOR
		,AN_LETIVO
		,CD_ESCOLA
		,COD_ESC
		,SG_TP_ESCOLA
		,NM_UNIDADE_EDUCACAO
		
		,LTRIM(RTRIM(UPPER (DC_TP_LOGRADOURO))) + ' ' + LTRIM(RTRIM(UPPER (NM_LOGRADOURO))) AS ENDERECO
		,CD_NR_ENDERECO AS NR
		,DC_COMPLEMENTO_ENDERECO AS COMPL
		,NM_BAIRRO AS BAIRRO
		,CEP = CASE WHEN LEN(CD_CEP) < 8 THEN REPLICATE('0', 8 - LEN(CD_CEP)) + RTrim(CD_CEP) else convert(NVARCHAR(8), CD_CEP) END
		,CD_COORDENADA_GEO_Y
		CD_COORDENADA_GEO_X
		,CASE WHEN CD_COORDENADA_GEO_Y IS NOT NULL THEN CD_COORDENADA_GEO_Y * 1000000 ELSE 9999999 END AS COORDENADA_Y_ESC
		,CASE WHEN CD_COORDENADA_GEO_X IS NOT NULL THEN CD_COORDENADA_GEO_X * 1000000 ELSE 9999999 END AS COORDENADA_X_ESC
		----,CD_SERIE_ENSINO
		--,DC_ETAPA_ENSINO
		----,SG_SERIE_ENSINO
		--,UPPER(DC_SERIE_ENSINO) AS DC_SERIE_ENSINO
		--,QTD_TURMA = ISNULL(SUB_TU,0) 
		--,QTD_VAGAS_OFER = ISNULL(SUB_VG,0)
		--,QTD_MATRIC = ISNULL(SUB_M,0) + ISNULL(SUB_HM,0) 
		--,QTD_ENCAMI = ISNULL(SUB_E,0)
		--,QTD_MATRIC_COMP = (ISNULL(SUB_M,0) + ISNULL(SUB_HM,0) + ISNULL(SUB_E,0))
		--,QTD_VAGAS_REMAN = ISNULL(SUB_VG,0) - (ISNULL(SUB_M,0) + ISNULL(SUB_HM,0) + ISNULL(SUB_E,0))

		,[B1] = SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3) THEN SUB_E ELSE 0 END) )
		,[B2] = SUM(CASE WHEN CD_SERIE_ENSINO IN (4,6) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (4,6) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (4,6) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (4,6) THEN SUB_E ELSE 0 END) )
		,[MG1] = SUM(CASE WHEN CD_SERIE_ENSINO IN (11,27) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (11,27) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (11,27) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (11,27) THEN SUB_E ELSE 0 END) )
		,[MG2] = SUM(CASE WHEN CD_SERIE_ENSINO IN (28,29) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (28,29) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (28,29) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (28,29) THEN SUB_E ELSE 0 END) )
		,[TOTAL CRECHE] =	SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3,4,6,11,27,28,29) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3,4,6,11,27,28,29)THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (1,3,4,6,11,27,28,29) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN(1,4,27,28)THEN SUB_E ELSE 0 END) )
		,[IN1] = SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,297) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,297) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,297) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,297) THEN SUB_E ELSE 0 END) )
		,[IN2] = SUM(CASE WHEN CD_SERIE_ENSINO IN (25,26) THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (25,26) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (25,26) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (25,26) THEN SUB_E ELSE 0 END) )
		,[TOTAL INFANTIL]=SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,25,26,297)	 THEN SUB_VG ELSE 0 END) - (SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,25,26,297) THEN SUB_M ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,25,26,297) THEN SUB_HM ELSE 0 END) + SUM(CASE WHEN CD_SERIE_ENSINO IN (23,24,25,26,297)	 THEN SUB_E ELSE 0 END) )

		,CRDATE
		INTO SALDO_VAGAS
		FROM (	SELECT DISTINCT SUBSTRING(B.NM_UNIDADE_EDUCACAO,32,20) AS DRE,
								LEFT(G.NM_MICRO_REGIAO,CHARINDEX('SETOR', G.NM_MICRO_REGIAO)-1) AS DISTR,
								RIGHT(G.NM_MICRO_REGIAO,2) SETOR,
								M.AN_LETIVO,
								A.CD_UNIDADE_EDUCACAO AS CD_ESCOLA,
								RIGHT(A.cd_cie_unidade_educacao,6) AS COD_ESC,
								SG_TP_ESCOLA,
								A.NM_UNIDADE_EDUCACAO,
								P.CD_SERIE_ENSINO, 
								Q.DC_ETAPA_ENSINO,
								P.DC_SERIE_ENSINO,
								SG_SERIE_ENSINO,
								E.CD_CEP,
								E.NM_BAIRRO,
								E.NM_LOGRADOURO,
								E.CD_NR_ENDERECO,
								E.DC_COMPLEMENTO_ENDERECO,
								E.CD_COORDENADA_GEO_Y,
								E.CD_COORDENADA_GEO_X,
								DC_TP_LOGRADOURO,

								SUB_TU = (	SELECT	CAMPO = COUNT(DISTINCT(SUB_TURMA_ESCOLA_TURMA.CD_TURMA_ESCOLA)) 
													FROM	 D_TURMA_ESCOLA AS SUB_TURMA_ESCOLA_TURMA
													LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL AS SUB_CORRESPONDENCIA_SERIE_EOL	ON SUB_TURMA_ESCOLA_TURMA.CD_CORRESPONDENCIA_SERIE = SUB_CORRESPONDENCIA_SERIE_EOL.CD_CORRESPONDENCIA_SERIE
													LEFT JOIN D_SERIE_ENSINO AS SUB_SERIE_ENSINO ON SUB_CORRESPONDENCIA_SERIE_EOL.CD_SERIE_EOL2007 = SUB_SERIE_ENSINO.CD_SERIE_ENSINO
													WHERE 
														SUB_TURMA_ESCOLA_TURMA.AN_LETIVO = CASE WHEN @AN_LETIVO = 0 THEN YEAR(GETDATE()) ELSE @AN_LETIVO END
														AND CD_TIPO_TURMA IN (1,3,5)
														AND SUB_TURMA_ESCOLA_TURMA.ST_TURMA_ESCOLA NOT IN ('E') 
														AND SUB_SERIE_ENSINO.CD_ETAPA_ENSINO IN (1,10,5,13)
														AND A.CD_UNIDADE_EDUCACAO = SUB_TURMA_ESCOLA_TURMA.CD_ESCOLA
														AND P.CD_SERIE_ENSINO = SUB_SERIE_ENSINO.CD_SERIE_ENSINO
										),
								SUB_VG = (	SELECT	CAMPO = SUM(SUB_TURMA_ESCOLA.QT_VAGA_OFERECIDA) 
													FROM	 D_TURMA_ESCOLA AS SUB_TURMA_ESCOLA
													LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL AS SUB_CORRESPONDENCIA_SERIE_EOL	ON SUB_TURMA_ESCOLA.CD_CORRESPONDENCIA_SERIE = SUB_CORRESPONDENCIA_SERIE_EOL.CD_CORRESPONDENCIA_SERIE
													LEFT JOIN D_SERIE_ENSINO AS SUB_SERIE_ENSINO ON SUB_CORRESPONDENCIA_SERIE_EOL.CD_SERIE_EOL2007 = SUB_SERIE_ENSINO.CD_SERIE_ENSINO
													WHERE 
														SUB_TURMA_ESCOLA.AN_LETIVO = CASE WHEN @AN_LETIVO = 0 THEN YEAR(GETDATE()) ELSE @AN_LETIVO END
														AND CD_TIPO_TURMA IN (1,3,5)
														AND SUB_TURMA_ESCOLA.ST_TURMA_ESCOLA NOT IN ('E') 
														AND SUB_SERIE_ENSINO.CD_ETAPA_ENSINO IN (1,10,5,13)
														AND A.CD_UNIDADE_EDUCACAO = SUB_TURMA_ESCOLA.CD_ESCOLA
														AND P.CD_SERIE_ENSINO = SUB_SERIE_ENSINO.CD_SERIE_ENSINO
										),
								SUB_M = (	SELECT 	CAMPO = COUNT(CASE WHEN SUB_M_MATRICULA_TURMA_ESCOLA.CD_SITUACAO_ALUNO IN (1,5,6,10,13) THEN SUB_M_MATRICULA_TURMA_ESCOLA.CD_MATRICULA END ) 
													FROM	 D_TURMA_ESCOLA AS SUB_M_TURMA_ESCOLA
													LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL AS SUB_M_CORRESPONDENCIA_SERIE_EOL ON SUB_M_TURMA_ESCOLA.CD_CORRESPONDENCIA_SERIE = SUB_M_CORRESPONDENCIA_SERIE_EOL.CD_CORRESPONDENCIA_SERIE
													LEFT JOIN D_SERIE_ENSINO AS SUB_M_SERIE_ENSINO ON SUB_M_CORRESPONDENCIA_SERIE_EOL.CD_SERIE_EOL2007 = SUB_M_SERIE_ENSINO.CD_SERIE_ENSINO
													LEFT JOIN D_MATRICULA_TURMA_ESCOLA AS SUB_M_MATRICULA_TURMA_ESCOLA	ON SUB_M_TURMA_ESCOLA.CD_TURMA_ESCOLA = SUB_M_MATRICULA_TURMA_ESCOLA.CD_TURMA_ESCOLA
													WHERE 
														SUB_M_TURMA_ESCOLA.AN_LETIVO = CASE WHEN @AN_LETIVO = 0 THEN YEAR(GETDATE()) ELSE @AN_LETIVO END
														AND CD_TIPO_TURMA IN (1,3,5)
														AND SUB_M_TURMA_ESCOLA.ST_TURMA_ESCOLA NOT IN ('E') 
														AND SUB_M_SERIE_ENSINO.CD_ETAPA_ENSINO IN (1,10,5,13)
														AND A.CD_UNIDADE_EDUCACAO = SUB_M_TURMA_ESCOLA.CD_ESCOLA
														AND P.CD_SERIE_ENSINO = SUB_M_SERIE_ENSINO.CD_SERIE_ENSINO
										),
								SUB_HM = (	SELECT	CAMPO = COUNT(CASE WHEN SUB_HM_HISTORICO_MATRICULA_TURMA_ESCOLA.CD_SITUACAO_ALUNO IN (5) THEN SUB_HM_HISTORICO_MATRICULA_TURMA_ESCOLA.CD_MATRICULA END ) 
													FROM	 D_TURMA_ESCOLA AS SUB_HM_TURMA_ESCOLA
													LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL AS SUB_HM_CORRESPONDENCIA_SERIE_EOL ON SUB_HM_TURMA_ESCOLA.CD_CORRESPONDENCIA_SERIE = SUB_HM_CORRESPONDENCIA_SERIE_EOL.CD_CORRESPONDENCIA_SERIE
													LEFT JOIN D_SERIE_ENSINO AS SUB_HM_SERIE_ENSINO ON SUB_HM_CORRESPONDENCIA_SERIE_EOL.CD_SERIE_EOL2007 = SUB_HM_SERIE_ENSINO.CD_SERIE_ENSINO
													LEFT JOIN D_HISTORICO_MATRICULA_TURMA_ESCOLA	AS SUB_HM_HISTORICO_MATRICULA_TURMA_ESCOLA	ON SUB_HM_TURMA_ESCOLA.CD_TURMA_ESCOLA = SUB_HM_HISTORICO_MATRICULA_TURMA_ESCOLA.CD_TURMA_ESCOLA
													WHERE 
														SUB_HM_TURMA_ESCOLA.AN_LETIVO = CASE WHEN @AN_LETIVO = 0 THEN YEAR(GETDATE()) ELSE @AN_LETIVO END
														AND CD_TIPO_TURMA IN (1,3,5)
														AND SUB_HM_TURMA_ESCOLA.ST_TURMA_ESCOLA NOT IN ('E') 
														AND CD_ETAPA_ENSINO IN (1,10,5,13)
														AND A.CD_UNIDADE_EDUCACAO = SUB_HM_TURMA_ESCOLA.CD_ESCOLA 
														AND P.CD_SERIE_ENSINO = SUB_HM_SERIE_ENSINO.CD_SERIE_ENSINO
										),
								 SUB_E = (	SELECT 	COUNT(SUB_E_SOLICITACAO_MATRICULA.CD_SOLICITACAO_MATRICULA)QTD_ENC
													FROM D_SOLICITACAO_MATRICULA AS SUB_E_SOLICITACAO_MATRICULA 
													WHERE 
														AN_LETIVO = CASE WHEN @AN_LETIVO = 0 THEN YEAR(GETDATE()) ELSE @AN_LETIVO END
														AND TP_ORIGEM NOT IN ('T') --EXISTE UM "I" DE CONTINUIDADE INFANTIL PARA O ANO 2019
														
														--AND TP_ORIGEM IN ('C') 
														AND ST_SOLICITACAO = 'E' 
														AND A.CD_UNIDADE_EDUCACAO = SUB_E_SOLICITACAO_MATRICULA.CD_UNIDADE_EDUCACAO 
														AND P.CD_SERIE_ENSINO = SUB_E_SOLICITACAO_MATRICULA.CD_SERIE_ENSINO
										),
								A.CRDATE
								FROM	  D_UNIDADE_EDUCACAO A
								LEFT JOIN D_UNIDADE_EDUCACAO B ON A.CD_UNIDADE_ADMINISTRATIVA_REFERENCIA = B.CD_UNIDADE_EDUCACAO
								LEFT JOIN D_ESCOLA C ON A.CD_UNIDADE_EDUCACAO = C.CD_ESCOLA
								LEFT JOIN D_ENDERECO E ON A.CI_ENDERECO = E.CI_ENDERECO 
								LEFT JOIN D_MICRO_REGIAO G ON E.CD_MICRO_REGIAO = G.CD_MICRO_REGIAO 
								LEFT JOIN TIPO_LOGRADOURO H ON E.TP_LOGRADOURO = H.TP_LOGRADOURO
								LEFT JOIN D_TURMA_ESCOLA M ON A.CD_UNIDADE_EDUCACAO = M.CD_ESCOLA 
								LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL M1	ON M.CD_CORRESPONDENCIA_SERIE = M1.CD_CORRESPONDENCIA_SERIE
								LEFT JOIN D_SERIE_ENSINO P ON M1.CD_SERIE_EOL2007 = P.CD_SERIE_ENSINO
								LEFT JOIN D_MATRICULA_TURMA_ESCOLA N ON M.CD_TURMA_ESCOLA = N.CD_TURMA_ESCOLA
								LEFT JOIN D_ETAPA_ENSINO Q ON P.CD_ETAPA_ENSINO = Q.CD_ETAPA_ENSINO
								LEFT JOIN TIPO_ESCOLA R ON C.TP_ESCOLA = R.TP_ESCOLA
								WHERE
									A.TP_SITUACAO_UNIDADE = 1	
									AND A.TP_UNIDADE_EDUCACAO = 1
									AND C.TP_ESCOLA not in (15, 29)
									AND P.CD_ETAPA_ENSINO IN (1,10,5,13)
									--AND CD_CICLO_ENSINO IN (1,2)
									AND M.ST_TURMA_ESCOLA <> 'E'
									AND M.AN_LETIVO = CASE WHEN @AN_LETIVO = 0 THEN YEAR(GETDATE()) ELSE @AN_LETIVO END
									
			) AS GERAL
	GROUP BY DRE
		,DISTR
		,SETOR
		,AN_LETIVO
		,CD_ESCOLA
		,COD_ESC
		,SG_TP_ESCOLA
		,NM_UNIDADE_EDUCACAO
		,CD_CEP
		,NM_BAIRRO
		,DC_TP_LOGRADOURO
		,NM_LOGRADOURO
		,CD_NR_ENDERECO
		,DC_COMPLEMENTO_ENDERECO
		,CD_COORDENADA_GEO_Y
		,CD_COORDENADA_GEO_X
		,CRDATE
--SELECT * FROM SALDO_VAGAS
-------------------------------------------------------------------------------------------------------------------------------------------------


