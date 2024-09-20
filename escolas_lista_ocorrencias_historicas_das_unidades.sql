--LISTA DOS REGISTROS DE DADOS HISTÓRICOS DAS UNIDADES

	SELECT 
	B.CD_SIT,
	B.DRE,
	B.CD_ESCOLA,
	B.SG_TP_ESCOLA,
	B.NOMESC,
	A.tp_ocorrencia_historica,
	C.dc_tipo_ocorrencia_historica,
	dc_ato,
	nr_ato,
	CONVERT(DATE,dt_inicio_ocorrencia_unidade,103) AS dt_inicio_ocorrencia_unidade,
	CONVERT(DATE,dt_publicacao_dom,103) AS dt_publicacao_dom,
	A.dt_atualizacao_tabela,
	tp_atualizacao_registro,
	CONVERT(DATE,A.CRDATE-1,103) AS DT_BASE

	FROM D_HISTORICO_UNIDADE A
	JOIN SME_ESCOLA_DIARIO B ON A.cd_unidade_educacao=B.CD_ESCOLA 
	JOIN tipo_ocorrencia_historica C ON A.tp_ocorrencia_historica=C.tp_ocorrencia_historica
	WHERE B.cd_escola in (019329,019214)
	ORDER BY A.cd_historico_unidade DESC


SELECT * FROM D_HISTORICO_UNIDADE


