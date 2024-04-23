USE [Db_local]
GO

/****** Object:  View [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS]    Script Date: 23/04/2024 08:25:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
CÓDIGO QUE GERA A VIEW VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
--DROP VIEW VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS
CREATE VIEW [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS] AS
SELECT distinct 
I.DRE,
I.CD_ESCOLA,
I.SG_TP_ESCOLA,
I.NOMESC AS NOME_ESCOLA,
H.SG_ETAPA AS ETAPA,
H.SG_SERIE_ENSINO AS SERIE_ANO,
A.cd_aluno AS COD_ALUNO, 
H.NM_ALUNO AS NOME_ALUNO,
H.DT_NASCIMENTO_ALUNO,
H.NM_MAE_ALUNO AS MÃE_ALUNO,
G.nm_responsavel AS RESPONSÁVEL,
G.NR_RG_RESPONSAVEL,
G.CD_DIGITO_RG_RESPONSAVEL,
G.SG_UF_RG_RESPONSAVEL,
G.CD_CPF_RESPONSAVEL,
G.cd_ddd_celular_responsavel AS DDD,
G.nr_celular_responsavel AS TEL_CELULAR,
G.nr_telefone_fixo_responsavel AS TEL_FIXO,
G.EMAIL_RESPONSAVEL,
E.dc_tp_logradouro AS TP_LOGRADOURO,
D.nm_logradouro AS ENDEREÇO, 
D.cd_nr_endereco AS NR, 
D.dc_complemento_endereco AS COMPL, 
D.nm_bairro AS BAIRRO, 
D.cd_cep AS CEP, 
D.cd_coordenada_geo_y AS LAT_ALUNO, 
D.cd_coordenada_geo_x AS LON_ALUNO,
A.qt_distancia AS DIST_ESCOLA,
A.qt_distancia_carro AS DIST_CARRO,
A.an_letivo AS ANO_LETIVO, 
CONVERT(VARCHAR, A.CRDATE,103) AS CRDATE

FROM D_MATRICULA A 
INNER JOIN ((D_ENDERECO_ALUNO B
INNER JOIN D_endereco_aluno_tipo_endereco C ON B.cd_endereco_aluno = C.cd_endereco_aluno) 
INNER JOIN D_endereco D ON B.ci_endereco = D.ci_endereco) ON A.cd_aluno = B.cd_aluno
INNER JOIN D_TIPO_LOGRADOURO E ON D.tp_logradouro= E.tp_logradouro
INNER JOIN TIPO_ENDERECO F ON C.ci_tipo_endereco =F.ci_tipo_endereco
LEFT JOIN D_RESPONSAVEL_ALUNO G ON A.cd_aluno=G.cd_aluno
LEFT JOIN SME_ALUNOS_DIARIO H ON A.cd_aluno=H.CD_ALUNO
LEFT JOIN SME_ESCOLA_DIARIO I ON H.CD_ESCOLA=I.CD_ESCOLA
WHERE B.dt_fim Is Null 
AND A.st_matricula='1'
AND A.an_letivo=YEAR(GETDATE())
AND C.dt_fim Is Null
AND F.ci_tipo_endereco='1'
AND G.dt_fim IS NULL
AND I.TP_ESCOLA IN (1,2,3,4,10,11,12,13,16,17,18,28,30,31,32,33) AND H.SG_ETAPA IS NOT NULL

--SELECT * FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
GO


