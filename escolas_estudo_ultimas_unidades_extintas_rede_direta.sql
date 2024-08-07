--RELA��O DAS ULTIMAS UNIDADES EXTINTAS - SOMENTE REDE DIRETA

SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
CD_SIT,
MAX(B.DT_ATUALIZACAO_TABELA) AS DT_EXTINCAO

FROM SME_ESCOLA_DIARIO A
JOIN D_HISTORICO_UNIDADE B ON A.CD_ESCOLA=B.cd_unidade_educacao

WHERE CD_SIT=2 AND SG_TP_ESCOLA = 'EMEF' AND YEAR(DT_ATUALIZACAO_TABELA)>2010


GROUP BY
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
CD_SIT
ORDER BY MAX(B.DT_ATUALIZACAO_TABELA) DESC


