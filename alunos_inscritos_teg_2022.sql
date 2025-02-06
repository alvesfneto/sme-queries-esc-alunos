/*
Venho pedir encarecidamente, que por favor disponibilizem relatórios de 
Inscritos referentes ao dia 01 de dezembro de 2021, e ao dia 01 de dezembro de 2022. 
Precisamos para consulta e pesquisa, e não temos nenhum salvo em Área K pois a época o gerente EOL da DRE PJ não salvou os arquivos.
*/
DROP TABLE ##CADASTRO_TEG_2022
SELECT DISTINCT
ACT.cd_aluno,
dc_motivo_transporte,
dc_situacao_candidato_transporte,
an_letivo,
DT_SITUACAO

INTO ##CADASTRO_TEG_2022

FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[ALUNO_CANDIDATO_TRANSPORTE] ACT
JOIN [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[motivo_transporte] MT ON ACT.cd_motivo_transporte=MT.cd_motivo_transporte
JOIN [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[situacao_candidato_transporte] SCT ON ACT.cd_situacao_candidato_transporte=SCT.cd_situacao_candidato_transporte
JOIN (SELECT
      cd_aluno,
      MAX(dt_situacao_candidato_transporte) AS DT_SITUACAO
      FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[ALUNO_CANDIDATO_TRANSPORTE]
      WHERE dt_situacao_candidato_transporte between '2021-12-31' and '2022-12-31' AND AN_LETIVO='2022'
	  GROUP BY cd_aluno) DT_SIT ON ACT.cd_aluno=DT_SIT.CD_ALUNO


WHERE ACT.dt_situacao_candidato_transporte =DT_SIT.DT_SITUACAO

--SELECT * FROM ##CADASTRO_TEG_2022


SELECT DISTINCT
DRE,
CODLOC,
SG_TP_ESCOLA,
NOMESC,
CL_ALU_CODIGO,
MODAL,
TEG, B.*

FROM [dbo].[ALUNO_NA_TURMA_DEZ_22] A
JOIN ##CADASTRO_TEG_2022 B ON A.CL_ALU_CODIGO=B.CD_ALUNO
JOIN SME_ESCOLA_DIARIO C ON A.CODLOC=C.CD_ESCOLA COLLATE Latin1_General_CI_AS

WHERE DRE = 'DRE - PJ' AND CL_ST IN('I','S','C')
ORDER BY CD_ALUNO
--SELECT * FROM [dbo].[ALUNO_NA_TURMA_DEZ_22]

