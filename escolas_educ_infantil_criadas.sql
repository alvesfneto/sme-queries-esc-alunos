
/* UNIDADES EMEI E CEU EMEI*/

	SELECT D.DRE,A.CD_ESCOLA,A.tp_escola--CD_ESCOLA,COUNT(*) 
	FROM D_ESCOLA A--570
	INNER JOIN (SELECT A.*
				FROM D_HISTORICO_UNIDADE AS A
				INNER JOIN	(SELECT A.cd_unidade_educacao, A.tp_ocorrencia_historica, MIN(A.dt_atualizacao_tabela) AS dt_atualizacao_tabela
							FROM D_HISTORICO_UNIDADE A
							INNER JOIN (SELECT A.cd_unidade_educacao, A.DT_ATUALIZACAO_TABELA, MIN(tp_ocorrencia_historica) AS tp_ocorrencia_historica 
										FROM D_HISTORICO_UNIDADE A
										INNER JOIN (SELECT cd_unidade_educacao,MIN(DT_ATUALIZACAO_TABELA) AS DT_ATUALIZACAO_TABELA
													FROM D_HISTORICO_UNIDADE 
													WHERE tp_ocorrencia_historica IN (1,2,3,9,18,27) --AND cd_unidade_educacao=	019230
													GROUP BY cd_unidade_educacao) B ON A.cd_unidade_educacao=B.cd_unidade_educacao AND A.dt_atualizacao_tabela= B.DT_ATUALIZACAO_TABELA
										WHERE tp_ocorrencia_historica IN (1,2,3,9,18,27) --AND A.cd_unidade_educacao=	019230
										GROUP BY A.cd_unidade_educacao, A.DT_ATUALIZACAO_TABELA) B ON A.cd_unidade_educacao = B.cd_unidade_educacao AND A.tp_ocorrencia_historica = B.tp_ocorrencia_historica
							WHERE A.tp_ocorrencia_historica IN (1,2,3,9,18,27) 	--AND A.cd_unidade_educacao=	019230
							GROUP BY A.cd_unidade_educacao, A.tp_ocorrencia_historica) AS B ON A.cd_unidade_educacao = B.cd_unidade_educacao AND A.dt_atualizacao_tabela = B.dt_atualizacao_tabela AND A.tp_ocorrencia_historica = B.tp_ocorrencia_historica
				WHERE A.tp_ocorrencia_historica IN (1,2,3,9,18,27) 	--AND A.cd_unidade_educacao=	019230
				) B ON A.cd_escola=B.cd_unidade_educacao
	
	LEFT JOIN D_UNIDADE_EDUCACAO C ON A.cd_escola=C.cd_unidade_educacao

	LEFT JOIN (SELECT CD_UNIDADE_EDUCACAO,B.DRE
			          FROM D_UNIDADE_EDUCACAO A
					  JOIN tbl_dre B ON A.cd_unidade_administrativa_portal=B.CD_DRE COLLATE SQL_Latin1_General_CP1_CI_AI) D ON A.cd_escola=D.cd_unidade_educacao
	
	WHERE A.tp_escola IN(2,17) AND tp_ocorrencia_historica IN (1,2,3,9,18,27)  AND C.tp_situacao_unidade=1 
	--GROUP BY CD_ESCOLA
	--ORDER BY COUNT(*) DESC
	AND CD_ESCOLA = 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	

	SELECT  *--CD_ESCOLA,COUNT(*) 
	FROM D_ESCOLA A--570
	INNER JOIN (SELECT A.*
				FROM D_HISTORICO_UNIDADE AS A
				INNER JOIN	(SELECT A.cd_unidade_educacao, A.tp_ocorrencia_historica, MIN(A.dt_atualizacao_tabela) AS dt_atualizacao_tabela
							FROM D_HISTORICO_UNIDADE A
							INNER JOIN (SELECT A.cd_unidade_educacao, A.DT_ATUALIZACAO_TABELA, MIN(tp_ocorrencia_historica) AS tp_ocorrencia_historica
										FROM D_HISTORICO_UNIDADE A
										INNER JOIN (SELECT cd_unidade_educacao,MIN(DT_ATUALIZACAO_TABELA) AS DT_ATUALIZACAO_TABELA
													FROM D_HISTORICO_UNIDADE 
													WHERE tp_ocorrencia_historica IN (1,2,3,9,18,27) --AND cd_unidade_educacao=	019230
													GROUP BY cd_unidade_educacao) B ON A.cd_unidade_educacao=B.cd_unidade_educacao AND A.dt_atualizacao_tabela= B.DT_ATUALIZACAO_TABELA
										WHERE tp_ocorrencia_historica IN (1,2,3,9,18,27) --AND A.cd_unidade_educacao=	019230
										GROUP BY A.cd_unidade_educacao, A.DT_ATUALIZACAO_TABELA,A.DT_PUBLICACAO_DOM) B ON A.cd_unidade_educacao = B.cd_unidade_educacao AND A.tp_ocorrencia_historica = B.tp_ocorrencia_historica
													INNER JOIN (SELECT distinct cd_unidade_educacao,MIN(dt_publicacao_dom) AS dt_publicacao_dom
															    FROM D_HISTORICO_UNIDADE 
															    WHERE tp_ocorrencia_historica IN (1,2,3,9,18,27)-- and cd_unidade_educacao in (097705,400224,400227,400223,097691,400230,400152) 
																GROUP BY cd_unidade_educacao,dt_publicacao_dom) C ON A.CD_UNIDADE_EDUCACAO=C.CD_UNIDADE_EDUCACAO-- AND A.dt_publicacao_dom=C.dt_publicacao_dom
													
							WHERE A.tp_ocorrencia_historica IN (1,2,3,9,18,27) 	--AND A.cd_unidade_educacao=	019230
							GROUP BY A.cd_unidade_educacao, A.tp_ocorrencia_historica) AS B ON A.cd_unidade_educacao = B.cd_unidade_educacao AND A.dt_atualizacao_tabela = B.dt_atualizacao_tabela AND A.tp_ocorrencia_historica = B.tp_ocorrencia_historica
				WHERE A.tp_ocorrencia_historica IN (1,2,3,9,18,27) --AND A.cd_unidade_educacao=	019230
				) B ON A.cd_escola=B.cd_unidade_educacao
	
	LEFT JOIN D_UNIDADE_EDUCACAO C ON A.cd_escola=C.cd_unidade_educacao
	JOIN D_TIPO_ESCOLA D ON A.tp_escola=D.tp_escola
	WHERE 
	A.tp_escola IN(1,2,3,4,10,11,12,13,16,17,18,28,30,31) 
	AND tp_ocorrencia_historica IN (1,2,3,9,18,27)  
	AND C.tp_situacao_unidade=1 
	
	
	--GROUP BY CD_ESCOLA
	--ORDER BY COUNT(*) DESC


	--AND A.cd_escola IN (097705,400224,400227,400223,097691,400230,400152) 
	--ORDER BY 1


	--SELECT * FROM D_HISTORICO_UNIDADE WHERE cd_unidade_educacao = 097705
	--
	--SELECT * FROM D_TIPO_ESCOLA
	
	
	
	
	--SELECT 
	--CD_ESCOLA,
	--nr_ato,
	--dc_ato,
	----CONVERT(INT,NR_ATO) AS NR_ATO,
	--MIN(dt_publicacao_dom) AS dt_publicacao_dom
	--FROM D_HISTORICO_UNIDADE A
	--JOIN D_ESCOLA B ON A.cd_unidade_educacao=B.cd_escola
	--WHERE tp_ocorrencia_historica = 1 /*IN (1,2,3,9,18,27)*/ and cd_unidade_educacao in (097705,400224,400227,400223,097691,400230,400152) 
	--GROUP BY cd_escola,dt_publicacao_dom, nr_ato, dc_ato
	--ORDER by 1
	
	
	
	
	
	
	
	
	
	--SELECT * FROM ##CRIACAO_EXTINCAO_UNIDADES

	SELECT 
	ANO,
	(EMEI_IN+CEI_DIR_IN+CEI_INDIR_IN+CPCONV_IN) AS CRIADAS,
	(EMEI_OUT+CEI_DIR_OUT+CEI_INDIR_OUT+CPCONV_OUT) AS EXTINTAS
		FROM ##CRIACAO_EXTINCAO_UNIDADES
	GROUP BY ANO,EMEI_IN,CEI_DIR_IN,CEI_INDIR_IN,CPCONV_IN,EMEI_OUT,CEI_DIR_OUT,CEI_INDIR_OUT,CPCONV_OUT



	
	
	--SELECT TOP 10 * FROM D_HISTORICO_UNIDADE


	SELECT TOP 10 * FROM D_UNIDADE_EDUCACAO