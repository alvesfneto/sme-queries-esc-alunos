USE [Db_local]
GO

/****** Object:  View [dbo].[VW_COMPARA_CODIGOS]    Script Date: 23/04/2024 08:23:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_COMPARA_CODIGOS] AS 
SELECT 
A.tp_escola,
dc_tipo_escola,sg_tp_escola,
cd_escola,
COD

FROM D_ESCOLA A
JOIN TIPO_ESCOLA B ON A.tp_escola=B.tp_escola
JOIN base_sequencia C ON A.cd_escola=C.COD collate SQL_Latin1_General_CP1_CI_AI
UNION
SELECT 
A.tp_unidade_administrativa,
dc_tipo_unidade_administrativa,sg_unidade_administrativa,
cd_unidade_administrativa,
COD

FROM D_UNIDADE_ADMINISTRATIVA A
JOIN TIPO_UNIDADE_ADMINISTRATIVA B ON A.tp_unidade_administrativa=B.tp_unidade_administrativa
JOIN base_sequencia C ON A.cd_unidade_administrativa=C.COD collate SQL_Latin1_General_CP1_CI_AI
GO


