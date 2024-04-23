USE [Db_local]
GO

/****** Object:  View [dbo].[VW_CEUS]    Script Date: 23/04/2024 08:23:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_CEUS] AS
SELECT  TOP 100
cd_unidade_administrativa AS CODEOL,
A.tp_unidade_administrativa AS [TP UNIDADE],
sg_unidade_administrativa AS TIPO,
C.dc_ato AS NOME,
A.cd_operador AS OPERADOR,
C.dt_inicio_ocorrencia_unidade AS [DT ATO],
C.dt_atualizacao_tabela AS [DT CRIACAO EOL]
FROM D_UNIDADE_ADMINISTRATIVA A
JOIN TIPO_UNIDADE_ADMINISTRATIVA B ON A.tp_unidade_administrativa=B.tp_unidade_administrativa
JOIN D_HISTORICO_UNIDADE C ON A.cd_unidade_administrativa=C.cd_unidade_educacao
WHERE A.tp_unidade_administrativa = 19 AND C.tp_ocorrencia_historica=1 AND C.tp_atualizacao_registro IS NULL
ORDER BY 1 DESC

GO


