

DROP TABLE ##AMBIENTES_MUNICIPALIZADAS
SELECT B.dc_tipo_ambiente,A.tp_ambiente,C.* 

INTO ##AMBIENTES_MUNICIPALIZADAS
FROM D_AMBIENTE_ESCOLA A
JOIN D_TIPO_AMBIENTE B ON A.tp_ambiente=B.tp_ambiente
JOIN VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL C ON A.cd_escola=C.CODESC

WHERE A.tp_ambiente IN (103,2,10015,70,112,7,1,11,9,10000,10007)
AND MUNICIPALIZADA IN (2024,2025)
--SELECT * FROM ##AMBIENTES_MUNICIPALIZADAS


SELECT * FROM D_TIPO_AMBIENTE ORDER BY dc_tipo_ambiente