/*
rezado José,
 
Estamos realizando um trabalho de atualização dos nomes dos patronos 
de todas as unidades escolares e, para isso, necessitamos das planilhas 
atualizadas com registro de dados históricos e datas de criação/denominações 
das unidades da rede. 
Certa de contar com a sua colaboração, desde já agradeço.
*/
DROP TABLE ##escolas_informacao_de_denominacao_patrono
SELECT
A.DRE,
A.CODESC,
A.TIPOESC,
A.NOMESC AS NOME_ATUAL,
CONVERT(VARCHAR,C.DT_DENOMINACAO,103) AS DT_DENOMINACAO,
--A.NOME_ANT,
--CASE WHEN A.NOMESC <> A.NOME_ANT THEN A.NOME_ANT ELSE NULL END AS NOME_ANTERIOR,
B.NM_CRIACAO AS NOME_CRIACAO,
CONVERT(VARCHAR,DT_CRIACAO,103) AS DT_CRIACAO,
--ANO_CRIACAO,
[DATABASE]
INTO ##escolas_informacao_de_denominacao_patrono
FROM 
VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL A
JOIN SME_ESCOLAS_ATOS_CRIACAO B ON A.CODESC=B.CD_ESCOLA
LEFT JOIN (SELECT 
           cd_unidade_educacao,
		   CASE WHEN tp_ocorrencia_historica=11 THEN MAX(dt_publicacao_dom) ELSE NULL END  AS DT_DENOMINACAO FROM D_HISTORICO_UNIDADE 
		   WHERE tp_ocorrencia_historica=11
           GROUP BY cd_unidade_educacao,tp_ocorrencia_historica ) C ON A.CODESC=C.cd_unidade_educacao
--SELECT * FROM ##escolas_informacao_de_denominacao_patrono





