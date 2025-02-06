/*Estamos organizando e planejando o 

Para tanto, solicitamos por gentileza:

1-Relação das escolas municipalizadas 2024 - por DRE; Nome da Unidade; ano/turma e quantidade de estudantes.

2-Relação das escolas municipalizadas 2025 - por DRE - há o nome dessas unidade e o quantitativo de estudantes previstos?

3-Relação das escolas das DREs JT e PE - com o número de estudantes (2024) por turma, para que possamos planejar o número de equipes que deveremos contratar para atender cada uma das DREs.
*/
DROP TABLE ##escolas_municipalizadas_2024_2025_com_turmas_matriculas
SELECT
C.ANO_MUNIC,
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
CL_FUND AS TURMAS,
MT_FUND AS MATR_FUND,
MT_F1 AS '1º ANO',
MT_F2 AS '2º ANO',
MT_F3 AS '3º ANO',
MT_F4 AS '4º ANO',
MT_F5 AS '5º ANO',
MT_F6 AS '6º ANO',
MT_F7 AS '7º ANO',
MT_F8 AS '8º ANO',
MT_F9 AS '9º ANO',
A.CRDATE

INTO ##escolas_municipalizadas_2024_2025_com_turmas_matriculas

 FROM MISME_ESCOLA_TOTAL A
 --JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
 JOIN (SELECT 
cd_unidade_educacao,
dt_atualizacao_tabela,
CASE WHEN dt_atualizacao_tabela<'2024-06-30' THEN '2024'
     WHEN dt_atualizacao_tabela>'2024-06-30' THEN '2025'
ELSE NULL END AS ANO_MUNIC
FROM M_HISTORICO_UNIDADE WHERE tp_ocorrencia_historica=1 AND CD_ato LIKE '%MUNIC%') C ON A.CD_ESCOLA=C.cd_unidade_educacao

 GROUP BY
 C.ANO_MUNIC,
 DRE,
 CD_ESCOLA,
 SG_TP_ESCOLA,
 NOMESC,
 MT_FUND,
 MT_F1,
 MT_F2,
 MT_F3,
 MT_F4,
 MT_F5,
 MT_F6,
 MT_F7,
 MT_F8,
 MT_F9,
 CL_FUND,
 A.CRDATE

 --SELECT * FROM ##escolas_municipalizadas_2024_2025_com_turmas_matriculas

 ---------------------------------------------------------------------------------------
 DROP TABLE ##escolas_dre_pe_jt_com_matriculas
 SELECT 
 AN_LETIVO,
 DRE,
 B.CD_ESCOLA,
 SG_TP_ESCOLA,
 NOMESC,
 SG_ETAPA,
 SG_SERIE_ENSINO,
COUNT (DISTINCT CD_ALUNO) AS MATRICULAS,
CONVERT(VARCHAR, A.CRDATE-1, 103) AS DT_BASE
 
 INTO ##escolas_dre_pe_jt_com_matriculas
 
 FROM SME_ALUNOS_DIARIO A
 JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
 WHERE 
 SG_ETAPA IS NOT NULL 
 AND DRE IN ('DRE - JT','DRE - PE')
 AND REDE IN ('DIR','CONV')
 GROUP BY
 AN_LETIVO,
 DRE,
 B.CD_ESCOLA,
 SG_TP_ESCOLA,
 NOMESC,
 SG_ETAPA,
 SG_SERIE_ENSINO,
 A.CRDATE
 --SELECT * FROM ##escolas_dre_pe_jt_com_matriculas

 