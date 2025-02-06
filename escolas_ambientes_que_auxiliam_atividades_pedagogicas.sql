/*

e) Quantas unidades escolares apresentam instalações de quadra poliesportiva,
laboratórios, inclusive de informática, espaços para atividades culturais, biblioteca,
auditórios, entre outras estruturas que possam auxiliar as atividades pedagógicas?

*/

EXEC BI_ESCOLA_AMBIENTE

DROP TABLE ##AMBIENTES_AUXILIARES_ATIVIDADES_PEDAGOGICAS
SELECT 
DRE,
REDE,
CD_ESCOLA,
SG_TP_ESCOLA,
tp_ambiente,
A.DC_TIPO_AMBIENTE,
QT_AMBIENTE,
CONVERT(VARCHAR,CRDATE-1, 103) AS DT_BASE
INTO ##AMBIENTES_AUXILIARES_ATIVIDADES_PEDAGOGICAS
FROM ESCOLA_AMBIENTES A
JOIN tipo_ambiente B ON A.DC_TIPO_AMBIENTE=B.dc_tipo_ambiente
WHERE TP_AMBIENTE IN(137,10003,127,23,135,119,62,138,128,10008,125,142,28,25,26,103,29,27,24,46,47,53,139,55,133,44,45,52,131,9,10004,12,79,10005,141,10007,43,123,126,136,140)
AND REDE IN ('DIR','CONV')

--SELECT * FROM ##AMBIENTES_AUXILIARES_ATIVIDADES_PEDAGOGICAS

drop ##descricao_tipo_escola
SELECT 
sg_tp_escola,
dc_tipo_escola
INTO ##descricao_tipo_escola
FROM D_TIPO_ESCOLA
WHERE dt_cancelamento IS NULL ORDER BY 1
--select * from ##descricao_tipo_escola
