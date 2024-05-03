--lista de alunos eja sem cpf registrado

DROP TABLE ##alunos_eja_sem_cpf
	SELECT 
	DRE,
	A.CD_ESCOLA,
	SG_TP_ESCOLA,
	NOMESC,
	A.CD_ALUNO,
	A.NM_ALUNO,
	A.SG_ETAPA,
	A.SG_SERIE_ENSINO,
	B.cd_cpf_aluno,
	CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
	
	INTO ##alunos_eja_sem_cpf
	
	 FROM SME_ALUNOS_DIARIO A
	JOIN D_ALUNO B ON A.CD_ALUNO=B.cd_aluno
	JOIN SME_ESCOLA_DIARIO C ON A.CD_ESCOLA=C.CD_ESCOLA
	WHERE A.SG_ETAPA LIKE '%EJA%' AND B.cd_cpf_aluno IS NULL
--SELECT * FROM ##alunos_eja_sem_cpf
------------------------------------------------------------------------
DROP TABLE ##alunos_escolarizacao_sem_cpf
SELECT 
	DRE,
	A.CD_ESCOLA,
	SG_TP_ESCOLA,
	NOMESC,
	A.CD_ALUNO,
	A.NM_ALUNO,
	A.SG_ETAPA,
	A.SG_SERIE_ENSINO,
	B.cd_cpf_aluno,
	CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
	
	INTO ##alunos_escolarizacao_sem_cpf
	
	 FROM SME_ALUNOS_DIARIO A
	JOIN D_ALUNO B ON A.CD_ALUNO=B.cd_aluno
	JOIN SME_ESCOLA_DIARIO C ON A.CD_ESCOLA=C.CD_ESCOLA
	WHERE A.SG_ETAPA IS NOT NULL AND B.cd_cpf_aluno IS NULL
	--select * from ##alunos_escolarizacao_sem_cpf