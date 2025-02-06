

SELECT B.CD_UNIDADE_EDUCACAO,B.CD_UNIDADE_EDUCACAO,SG_TP_ESCOLA,NM_UNIDADE_EDUCACAO,SITUACAO,dt_inicio_ocorrencia_unidade,dt_publicacao_dom,dt_atualizacao_tabela FROM M_HISTORICO_UNIDADE A
JOIN vw_unidades_diretas_setores_internos_sme_dre_ceus B ON A.cd_unidade_educacao=B.CD_UNIDADE_EDUCACAO



WHERE tp_ocorrencia_historica=1 AND SG_TP_ESCOLA IN ('CEU','CEU CEMEI') AND YEAR(dt_inicio_ocorrencia_unidade) >2019 ORDER BY NM_UNIDADE_EDUCACAO