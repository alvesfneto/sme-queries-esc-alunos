USE [Db_local]
GO

/****** Object:  View [dbo].[VW_ALUNOS_ORIGEM_RACA_IDADE]    Script Date: 23/04/2024 08:20:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_ALUNOS_ORIGEM_RACA_IDADE] AS
SELECT DISTINCT
E.DRE,
D.CD_ESCOLA,
E.TP_ESCOLA,
E.SG_TP_ESCOLA,
E.NOMESC,
A.cd_aluno,
nm_aluno,
nm_social_aluno,
dt_nascimento_aluno,
sg_uf_nascimento_aluno,
cd_sexo_aluno,
B.dc_raca_cor,
C.nm_pais_mec,
cd_nacionalidade_aluno,
cd_nacionalidade_mae,
cd_nacionalidade_pai
cd_pais_origem_mae,
cd_pais_origem_pai,
A.nm_mae_aluno,
a.nm_pai_aluno,
cd_tipo_sigilo,
CAST(DATEDIFF(DD, DT_NASCIMENTO_ALUNO, GETDATE())/365.25 AS INT) AS IDADE,
DATEDIFF(YY,DT_NASCIMENTO_ALUNO,GETDATE()) AS IDADE_AN_LETIVO,
CONVERT(VARCHAR,A.CRDATE-1, 103) AS DT_BASE

FROM D_ALUNO A
LEFT JOIN tipo_raca_cor B ON A.tp_raca_cor=B.tp_raca_cor
LEFT JOIN [dbo].[PAIS_MEC] C ON A.cd_pais_mec = C.cd_pais_mec
INNER JOIN D_MATRICULA D ON A.cd_aluno=D.cd_aluno
JOIN SME_ESCOLA_DIARIO E ON D.cd_escola=E.CD_ESCOLA
WHERE D.st_matricula=1 AND D.cd_tipo_programa IS NULL
--SELECT top 10 * FROM VW_ALUNOS_ORIGEM_RACA_IDADE

GO


