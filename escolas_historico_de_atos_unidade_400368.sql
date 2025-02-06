


DROP TABLE ##HISTÓRICO_DE_ATOS_400368
SELECT 
DRE,
A.cd_unidade_educacao AS CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
CONVERT(date,dt_inicio_ocorrencia_unidade,103) AS DT_INICIO_OCORRENCIA,
dc_tipo_ocorrencia_historica AS TP_OCORRENCIA,
cd_ato AS CD_ATO,
NR_ATO,
dc_ato AS ATO,
CONVERT(date,dt_publicacao_dom,103) AS DT_PUBLIC,
CONVERT(date,A.dt_atualizacao_tabela,103) AS DT_ATUALIZACACAO
INTO ##HISTÓRICO_DE_ATOS_400368
FROM D_HISTORICO_UNIDADE A
JOIN tipo_ocorrencia_historica B ON A.tp_ocorrencia_historica=B.tp_ocorrencia_historica
JOIN SME_ESCOLA_DIARIO C ON A.cd_unidade_educacao=C.CD_ESCOLA

 WHERE cd_unidade_educacao=400368  ORDER BY dt_inicio_ocorrencia_unidade

--SELECT * FROM ##HISTÓRICO_DE_ATOS_400368 ORDER BY DT_INICIO_OCORRENCIA