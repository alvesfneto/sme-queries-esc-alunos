	SELECT * FROM SME_CLASSES_DIARIO

	SELECT * FROM SME_ALUNOS_DIARIO


	DROP TABLE ##escolas_unidades_com_matriculas_fund

	select 
	DRE,
	CD_ESCOLA,
	SG_TP_ESCOLA,
	NOMESC,
	ENDERECO,
	NR,
	COMPL,
	BAIRRO,
	CEP,
	MT_FUND,
	MT_FINI,
	--MT_F1,
	--MT_F2,
	--MT_F3,
	--MT_F4,
	--MT_F5,
	MT_FFIN,
	--MT_F6,
	--MT_F7,
	--MT_F8,
	--MT_F9
	CRDATE
	INTO ##escolas_unidades_com_matriculas_fund
	from D_MISME_ESCOLA_TOTAL
	WHERE MT_FUND<>0
	--SELECT * FROM ##escolas_unidades_com_matriculas_fund

	DROP TABLE ##escolas_unidades_com_matriculas_fund2
	SELECT *
	INTO ##escolas_unidades_com_matriculas_fund2
	FROM ##escolas_unidades_com_matriculas_fund WHERE MT_FFIN<>0
	--SELECT * FROM ##escolas_unidades_com_matriculas_fund2

	DROP TABLE ##escolas_unidades_com_matriculas_fund1
	SELECT *
	INTO ##escolas_unidades_com_matriculas_fund1
	FROM ##escolas_unidades_com_matriculas_fund WHERE MT_FFIN=0
	--SELECT * FROM ##escolas_unidades_com_matriculas_fund1