USE Db_Local_0

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC PROC_AUX_MIEST

DECLARE @an_letivo int SET @an_letivo = YEAR(GETDATE())

DECLARE @DURCLASSE INT SET @DURCLASSE = 0 
DECLARE @SEMESTRE DATE SET @SEMESTRE = (SELECT DT_INICIO_SEGUNDO_SEMESTRE FROM DB_EDUCACAO_1_PRODAM.se1426_ss.dbo.calendario
										where an_letivo = @an_letivo)

      IF (SELECT  MIN(@AN_LETIVO)  FROM /*EOQ.SE1426.DBO.*/DB_LOCAL_M..SME_CLASSES) > YEAR(GETDATE()) 
         (SELECT @DURCLASSE = @DURCLASSE + 2) 
  ELSE
  
   IF (SELECT  MIN(@AN_LETIVO)  FROM /*EOQ.SE1426.DBO.*/DB_LOCAL_M..SME_CLASSES) < YEAR(GETDATE())  
  (SELECT @DURCLASSE = @DURCLASSE + 1) 
   ELSE
  IF MONTH(@SEMESTRE) < MONTH(GETDATE()) 
  (SELECT @DURCLASSE = @DURCLASSE + 1) 
   ELSE 
  (SELECT @DURCLASSE = @DURCLASSE + 2)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1.	Quantidade turmas, e de estudantes matriculados por série, no Ensino Médio e Curso Normal de nível Médio nas seguintes Unidades educacionais:
 DROP TABLE ##TEMP
SELECT 
	 DRE, 
	 SG_TP_ESCOLA
	,NOMESC
	,CD_ESCOLA
	,TP_RACA_COR
	,IDADE 
	,MT_M1 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (90,98,101,102) THEN CD_ALUNO ELSE NULL END))
	,MT_M2 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (91,99,103,104) THEN CD_ALUNO ELSE NULL END))
	,MT_M3 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (92,100,105,106) THEN CD_ALUNO ELSE NULL END))
	,MT_M4 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (107,108) THEN CD_ALUNO ELSE NULL END))
	,CRDATE
	INTO ##TEMP
	FROM 
		(	SELECT 
			DRE, 
			DISTR, 
			SETOR,
			SG_TP_ESCOLA,
			a.CD_ESCOLA,
			NOMESC,
			B.CD_TURMA_ESCOLA, 
			B.CD_TIPO_PROGRAMA, 
			TIPO_PROG, 
			B.CD_ETAPA_ENSINO, 
			B.CD_SERIE_ENSINO, 
			TP_RACA_COR = case	when TP_RACA_COR = 1 then 'BRANCA' 
								when TP_RACA_COR = 2 then 'PRETA' 
								when TP_RACA_COR = 3 then 'PARDA' 
								when TP_RACA_COR = 4 then 'AMARELA' 
								when TP_RACA_COR = 5 then 'INDIGENA' 
								when TP_RACA_COR = 6 then 'NAO INFORMADA' 
								when TP_RACA_COR = 7 then 'RECUSOU INFORMAR' 
								when TP_RACA_COR IS NULL then 'NAO INFORMADA' 
							end, --select * from eol.se1426.dbo.tipo_raca_cor
			CD_ALUNO,
			(YEAR(GETDATE()) - YEAR(A.DT_NASCIMENTO_ALUNO)) AS IDADE,
			A.CRDATE
			FROM Db_Local_M..SME_ALUNOS a
			join Db_Local_M..SME_CLASSES b on a.CD_TURMA_ESCOLA  = b.CD_TURMA_ESCOLA 
			join Db_Local_M..SME_ESCOLA c on b.CD_ESCOLA = c.CD_ESCOLA
			LEFT JOIN ##TIPO_PROGRAMA D ON B.CD_TIPO_PROGRAMA = D.CD_TIPO_PROGRAMA

			WHERE 
				CASE	WHEN CD_TIPO_PERIODICIDADE  IN (1,2) THEN 0 
						WHEN CD_TIPO_PERIODICIDADE  IN (3) THEN 1 
						WHEN CD_TIPO_PERIODICIDADE  IN (4) THEN 2 ELSE CD_TIPO_PERIODICIDADE 
				END <> @DURCLASSE
				and (SG_TP_ESCOLA = 'EMEFM' OR NOMESC LIKE '%HELEN KELLER%')
		) AS TABELA

GROUP BY DRE, 
	SG_TP_ESCOLA
	,NOMESC
	,CD_ESCOLA
	,TP_RACA_COR
	,IDADE
	,CRDATE


--SELECT * FROM ##TEMP
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1.	Quantidade turmas, e de estudantes matriculados por série, no Ensino Médio e Curso Normal de nível Médio nas seguintes Unidades educacionais:
 DROP TABLE ##TEMPB
SELECT 
	DRE, 
	SG_TP_ESCOLA
	,NOMESC
	,CD_ESCOLA
	,CL_M1 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (90,98,101,102)	THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CL_M2 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (91,99,103,104)	THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CL_M3 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (92,100,105,106)	THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CL_M4 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (107,108)			THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CRDATE
	INTO ##TEMPB
	FROM 
		(	SELECT 
			DRE, 
			DISTR, 
			SETOR,
			SG_TP_ESCOLA,
			a.CD_ESCOLA,
			NOMESC,
			B.CD_TURMA_ESCOLA, 
			B.CD_TIPO_PROGRAMA, 
			TIPO_PROG, 
			B.CD_ETAPA_ENSINO, 
			B.CD_SERIE_ENSINO, 
			TP_RACA_COR = case	when TP_RACA_COR = 1 then 'BRANCA' 
								when TP_RACA_COR = 2 then 'PRETA' 
								when TP_RACA_COR = 3 then 'PARDA' 
								when TP_RACA_COR = 4 then 'AMARELA' 
								when TP_RACA_COR = 5 then 'INDIGENA' 
								when TP_RACA_COR = 6 then 'NAO INFORMADA' 
								when TP_RACA_COR = 7 then 'RECUSOU INFORMAR' 
								when TP_RACA_COR IS NULL then 'NAO INFORMADA' 
							end, --select * from eol.se1426.dbo.tipo_raca_cor
			CD_ALUNO,
			(YEAR(GETDATE()) - YEAR(A.DT_NASCIMENTO_ALUNO)) AS IDADE,
			A.CRDATE
			FROM Db_Local_M..SME_ALUNOS a
			join Db_Local_M..SME_CLASSES b on a.CD_TURMA_ESCOLA  = b.CD_TURMA_ESCOLA 
			join Db_Local_M..SME_ESCOLA c on b.CD_ESCOLA = c.CD_ESCOLA
			LEFT JOIN ##TIPO_PROGRAMA D ON B.CD_TIPO_PROGRAMA = D.CD_TIPO_PROGRAMA

			WHERE 
				CASE	WHEN CD_TIPO_PERIODICIDADE  IN (1,2) THEN 0 
						WHEN CD_TIPO_PERIODICIDADE  IN (3) THEN 1 
						WHEN CD_TIPO_PERIODICIDADE  IN (4) THEN 2 ELSE CD_TIPO_PERIODICIDADE 
				END <> @DURCLASSE
				and (SG_TP_ESCOLA = 'EMEFM' OR NOMESC LIKE '%HELEN KELLER%')
		) AS TABELA

GROUP BY DRE 
		,SG_TP_ESCOLA
		,NOMESC
		,CD_ESCOLA,
		CRDATE



--SELECT * FROM ##TEMPB WHERE IDADE>=60
------------------------------------------------------------------------------------------------------------------------------------------------------------


--2.	Quantidade de estudantes matriculados no Itinerários Técnico e de Qualificação Profissional (Farmácia, Contabilidade, Marketing, Informática e Gerência em Saúde) nas seguintes Unidades Educacionais:
DROP TABLE ##QT_MAT_MEDIO_ITINERARIO_TEC_QUAL_PROF
SELECT	DRE, 
		SG_TP_ESCOLA, 
		NOMESC, 
		CD_ESCOLA,
		DC_TIPO_TURMA, 
		COUNT(CD_TURMA_ESCOLA) AS QT_TURMA,
		SUM(AL_AT) AS AL_AT,
		CRDATE
		INTO ##QT_MAT_MEDIO_ITINERARIO_TEC_QUAL_PROF
		FROM (	SELECT	DRE, 
						SG_TP_ESCOLA,
						NOMESC, 
						A.CD_ESCOLA, 
						CD_TURMA_ESCOLA, 
						DC_TURMA_ESCOLA, 
						B.CD_TIPO_TURMA,
						dc_tipo_turma,
						CD_TIPO_TURNO,
						AL_AT,
						A.CRDATE
						FROM Db_Local_M..SME_ESCOLA A
						JOIN Db_Local_M..SME_CLASSES B ON A.CD_ESCOLA  = B.CD_ESCOLA 
						join D_TIPO_TURMA C ON B.CD_TIPO_TURMA = C.cd_tipo_turma AND C.dt_cancelamento IS NULL
						WHERE	b.cd_etapa_ensino in (14,18)--SELECT * FROM D_ETAPA_ENSINO
								--AND C.CD_TIPO_TURMA NOT IN (1,2,3,4,5)
								AND B.ST_TURMA_ESCOLA NOT IN ('E')
								and SG_TP_ESCOLA IN ('EMEFM')
			) AS TABELA
		GROUP BY 
			DRE, 
			SG_TP_ESCOLA, 
			NOMESC, 
			CD_ESCOLA,
			DC_TIPO_TURMA,
			CRDATE
		order by 3, 4

--2.	Quantidade de turmas, e de estudantes matriculados nos diferentes Itinerários Formativos/Unidades de Percurso nas seguintes Unidades Educacionais: 
DROP TABLE ##QT_MAT_MEDIO_ITINERARIO
SELECT	DRE, 
		SG_TP_ESCOLA, 
		NOMESC, 
		CD_ESCOLA,
		DC_TIPO_TURMA, 
		COUNT(CD_TURMA_ESCOLA) AS QT_TURMA,
		SUM(AL_AT) AS AL_AT,
		CRDATE
		INTO ##QT_MAT_MEDIO_ITINERARIO
		FROM (	SELECT	DRE, 
						SG_TP_ESCOLA,
						NOMESC, 
						A.CD_ESCOLA, 
						CD_TURMA_ESCOLA, 
						DC_TURMA_ESCOLA, 
						B.CD_TIPO_TURMA,
						dc_tipo_turma,
						CD_TIPO_TURNO,
						AL_AT,
						A.CRDATE
						FROM Db_Local_M..SME_ESCOLA A
						JOIN Db_Local_M..SME_CLASSES B ON A.CD_ESCOLA  = B.CD_ESCOLA 
						join D_TIPO_TURMA C ON B.CD_TIPO_TURMA = C.cd_tipo_turma AND C.dt_cancelamento IS NULL
						WHERE	C.CD_TIPO_TURMA NOT IN (1,2,3,4,5)
								AND B.ST_TURMA_ESCOLA NOT IN ('E')
			) AS TABELA
		GROUP BY 
			DRE, 
			SG_TP_ESCOLA, 
			NOMESC, 
			CD_ESCOLA,
			DC_TIPO_TURMA,
			CRDATE
		order by 3, 4

--6.	Estudantes público-alvo da Educação Especial (quantidade, distribuição nas séries e tipo de deficiência) matriculados no Ensino Médio e Curso Normal de nível médio nas seguintes Unidades Educacionais: 
 DROP TABLE ##QT_MAT_MEDIO_EDUC_ESPECIAL
SELECT 
	 DRE, 
	 SG_TP_ESCOLA
	,NOMESC
	,CD_ESCOLA
	,MT_M1 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (90,98,101,102,303) THEN CD_ALUNO ELSE NULL END))
	,MT_M2 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (91,99,103,104,304) THEN CD_ALUNO ELSE NULL END))
	,MT_M3 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (92,100,105,106,305) THEN CD_ALUNO ELSE NULL END))
	,MT_M4 = COUNT((CASE WHEN CD_SERIE_ENSINO IN (107,108) THEN CD_ALUNO ELSE NULL END))
	
	,CL_M1 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (90,98,101,102,303)	THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CL_M2 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (91,99,103,104,304)	THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CL_M3 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (92,100,105,106,305)	THEN CD_TURMA_ESCOLA ELSE NULL END))
	,CL_M4 = COUNT(DISTINCT(CASE WHEN CD_SERIE_ENSINO IN (107,108)			THEN CD_TURMA_ESCOLA ELSE NULL END))



	,CRDATE
	INTO ##QT_MAT_MEDIO_EDUC_ESPECIAL
	FROM 
		(	SELECT 
			DRE, 
			DISTR, 
			SETOR,
			SG_TP_ESCOLA,
			b.CD_ESCOLA,
			NOMESC,
			B.CD_TURMA_ESCOLA, 
			B.CD_TIPO_PROGRAMA, 
			TIPO_PROG, 
			B.CD_ETAPA_ENSINO, 
			B.CD_SERIE_ENSINO, 
			TP_RACA_COR = case	when TP_RACA_COR = 1 then 'BRANCA' 
								when TP_RACA_COR = 2 then 'PRETA' 
								when TP_RACA_COR = 3 then 'PARDA' 
								when TP_RACA_COR = 4 then 'AMARELA' 
								when TP_RACA_COR = 5 then 'INDIGENA' 
								when TP_RACA_COR = 6 then 'NAO INFORMADA' 
								when TP_RACA_COR = 7 then 'RECUSOU INFORMAR' 
								when TP_RACA_COR IS NULL then 'NAO INFORMADA' 
							end, --select * from eol.se1426.dbo.tipo_raca_cor
			CD_ALUNO,
			(YEAR(GETDATE()) - YEAR(A.DT_NASCIMENTO_ALUNO)) AS IDADE,
			A.CRDATE
			FROM Db_Local_M..SME_ALUNOS a
			join Db_Local_M..SME_CLASSES b on a.CD_TURMA_ESCOLA  = b.CD_TURMA_ESCOLA  
			join Db_Local_M..SME_ESCOLA c on b.CD_ESCOLA = c.CD_ESCOLA
			LEFT JOIN ##TIPO_PROGRAMA D ON B.CD_TIPO_PROGRAMA = D.CD_TIPO_PROGRAMA

			WHERE 
				CASE	WHEN CD_TIPO_PERIODICIDADE  IN (1,2) THEN 0 
						WHEN CD_TIPO_PERIODICIDADE  IN (3) THEN 1 
						WHEN CD_TIPO_PERIODICIDADE  IN (4) THEN 2 ELSE CD_TIPO_PERIODICIDADE 
				END <> @DURCLASSE
				and (SG_TP_ESCOLA = 'EMEBS')
		) AS TABELA

GROUP BY DRE, 
	SG_TP_ESCOLA
	,NOMESC
	,CD_ESCOLA
	,CRDATE


DROP TABLE ##REL_MAT_MEDIO_DEFI
SELECT	DRE, 
		SG_TP_ESCOLA,
		NOMESC, 
		A.CD_ESCOLA, 
		b.CD_TURMA_ESCOLA, 
		DC_TURMA_ESCOLA, 
		CD_TIPO_TURNO,
		CD_ALUNO,
		DEF1,
		DEF2,
		DEF3,
		DEF4,
		DEF5,
		DEF6,
		DEF7,
		DEF8,
		DEF9,
		DEF10,
		NM_ALUNO, 
		C.SG_ETAPA,
		SG_SERIE_ENSINO,
		DT_NASCIMENTO_ALUNO,
		A.CRDATE
		INTO ##REL_MAT_MEDIO_DEFI
		FROM Db_Local_M..SME_ESCOLA A
		JOIN Db_Local_M..SME_CLASSES B ON A.CD_ESCOLA  = B.CD_ESCOLA 
		JOIN Db_Local_M..SME_ALUNOS C ON B.CD_TURMA_ESCOLA = C.CD_TURMA_ESCOLA
		WHERE	B.ST_TURMA_ESCOLA NOT IN ('E')
				AND CD_MODALIDADE_ENSINO = 2 
				--and SG_TP_ESCOLA like '%emebs%'
				and c.CD_SERIE_ENSINO IN (90,98,101,102,91,99,103,104,92,100,105,106,107,108,303,304,305) 
				AND CD_SITUACAO_ALUNO IN (1,5,6,10,13)			

