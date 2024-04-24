USE [Db_local]
GO

/****** Object:  View [dbo].[VW_ULTIMAS_ESCOLAS_CRIADAS]    Script Date: 23/04/2024 08:26:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from tbl_dre

CREATE VIEW [dbo].[VW_ULTIMAS_ESCOLAS_CRIADAS] AS

	SELECT TOP 5000
	 E.DRE,
	 A.cd_unidade_educacao AS CD_ESCOLA,
	 Right(D.cd_cie_unidade_educacao,6) as CIE,
	 D.cd_unidade_educacao_prodesp AS [COD_UNIDADE],
	 C.SG_TP_ESCOLA AS TIPO,
	 D.nm_unidade_educacao AS [NOME_ESCOLA],
	 ISNULL(G.TURMAS,0) AS TURMAS,
	 ISNULL(G.VAGAS,0) AS VAGAS,
	 ISNULL(G.ALUNOS,0) AS ALUNOS,
	 DC_ATO AS OCORRÊNCIA,
	 A.dt_inicio_ocorrencia_unidade AS [DT_ATO],
	 MIN(A.dt_atualizacao_tabela) AS [DT_CRIACAO],
	 F.[sg_tipo_situacao_unidade] AS SITUACAO,
	 A.CD_OPERADOR AS OPERADOR,
	 --H.RF,
	 --H.Nome,
	 A.CRDATE
 
	FROM D_HISTORICO_UNIDADE A
	LEFT JOIN D_ESCOLA B ON A.cd_unidade_educacao=B.CD_ESCOLA
	JOIN TIPO_ESCOLA C ON B.tp_escola=C.tp_escola
	LEFT JOIN D_UNIDADE_EDUCACAO D ON A.cd_unidade_educacao=D.cd_unidade_educacao
	JOIN tbl_dre E ON D.cd_unidade_administrativa_referencia = E.CD_DRE --COLLATE SQL_Latin1_General_CP1_CI_AI
	JOIN tipo_situacao_unidade F ON D.tp_situacao_unidade = F.tp_situacao_unidade
	LEFT JOIN (SELECT CD_ESCOLA,
				 COUNT (DISTINCT CD_TURMA_ESCOLA) AS TURMAS,	
				 SUM(QT_VAGA_OFERECIDA) AS VAGAS,
				 SUM(AL_AT) AS ALUNOS
		 FROM SME_CLASSES_DIARIO GROUP BY CD_ESCOLA WITH ROLLUP) G ON A.cd_unidade_educacao=G.CD_ESCOLA
	--LEFT JOIN OPERADORES_EOL H ON A.cd_operador=H.CD_OPERADOR collate SQL_Latin1_General_CP1_CI_AI
		 

	WHERE tp_ocorrencia_historica=1 AND A.tp_atualizacao_registro IS NULL
	GROUP BY
	E.DRE,
	 A.cd_unidade_educacao,
	 Right(D.cd_cie_unidade_educacao,6),
	 D.cd_unidade_educacao_prodesp,
	 C.SG_TP_ESCOLA,
	 D.nm_unidade_educacao,
	 ISNULL(G.TURMAS,0),
	 ISNULL(G.VAGAS,0),
	 ISNULL(G.ALUNOS,0),
	 DC_ATO,
	 A.dt_inicio_ocorrencia_unidade,
	 A.dt_atualizacao_tabela,
	 F.[sg_tipo_situacao_unidade],
	 A.CD_OPERADOR,
	 --H.RF,
	 --H.Nome,
	 A.CRDATE

	 ORDER BY A.dt_atualizacao_tabela DESC


GO

--select * from VW_ULTIMAS_ESCOLAS_CRIADAS where tipo = 'ESC.PART.' and cie is null  ORDER BY cd_escola desc

