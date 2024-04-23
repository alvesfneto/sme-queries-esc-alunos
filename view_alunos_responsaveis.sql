USE [Db_local]
GO

/****** Object:  View [dbo].[VW_ALUNOS_RESPONSAVEIS]    Script Date: 23/04/2024 08:21:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_ALUNOS_RESPONSAVEIS] AS 
SELECT distinct 
A.cd_escola,
A.cd_aluno AS COD_ALUNO, 
G.nm_responsavel AS RESPONSÁVEL,
G.NR_RG_RESPONSAVEL,
G.CD_DIGITO_RG_RESPONSAVEL,
G.SG_UF_RG_RESPONSAVEL,
G.CD_CPF_RESPONSAVEL,
G.cd_ddd_celular_responsavel AS DDD,
G.nr_celular_responsavel AS TEL_CELULAR,
G.nr_telefone_fixo_responsavel AS TEL_FIXO,
G.EMAIL_RESPONSAVEL,

A.an_letivo AS ANO_LETIVO, 
CONVERT(VARCHAR, A.CRDATE,103) AS CRDATE

FROM D_MATRICULA A 

LEFT JOIN D_RESPONSAVEL_ALUNO G ON A.cd_aluno=G.cd_aluno
WHERE 
A.st_matricula='1'
AND A.an_letivo=YEAR(GETDATE())
AND A.cd_serie_ensino IS NOT NULL
AND G.dt_fim IS NULL
GO


