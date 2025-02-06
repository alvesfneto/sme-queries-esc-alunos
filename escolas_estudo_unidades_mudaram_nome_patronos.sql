/*DROP TABLE ##DT_DENOMINACAO
           SELECT DISTINCT
           cd_unidade_educacao, 
           --A.tp_ocorrencia_historica,
           B.dc_tipo_ocorrencia_historica,
           MAX(dt_inicio_ocorrencia_unidade) AS DT_DENOMINACAO 
           INTO ##DT_DENOMINACAO
           FROM D_HISTORICO_UNIDADE A
           JOIN tipo_ocorrencia_historica B ON A.tp_ocorrencia_historica=B.tp_ocorrencia_historica
           WHERE A.tp_ocorrencia_historica=11 AND dc_ato NOT IN ('IDENTIFICA AS CRECHES MUNICIPAIS DA SEBES','ALTERA O ARTIGO 1º DO DECRETO 42.788','DISTRITO DE CIDADE TIRADENTES','REMO RINALDI NADDEO, PROF.')
           GROUP BY
           cd_unidade_educacao, 
           B.dc_tipo_ocorrencia_historica


                      SELECT
                      cd_unidade_educacao,
                      COUNT (cd_unidade_educacao) AS QTDE
                      FROM 
                      ##DT_DENOMINACAO
                      GROUP BY
                      cd_unidade_educacao
                      HAVING (COUNT (cd_unidade_educacao)>1)
                      ORDER BY 1
*/



DROP TABLE ##ESCOLAS_MUDARAM_NOME
SELECT DISTINCT
DRE,
CODESC,
TIPOESC,
NOMESC,
NOME_ANT,
CONVERT(VARCHAR,B.DT_DENOMINACAO,103) AS DT_DENOMINACAO
INTO ##ESCOLAS_MUDARAM_NOME
FROM VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL A
JOIN (SELECT DISTINCT
      cd_unidade_educacao, 
      B.dc_tipo_ocorrencia_historica,
      CASE WHEN A.tp_ocorrencia_historica=11 THEN MIN(A.dt_inicio_ocorrencia_unidade) ELSE NULL END  AS DT_DENOMINACAO 
      FROM D_HISTORICO_UNIDADE A
      JOIN tipo_ocorrencia_historica B ON A.tp_ocorrencia_historica=B.tp_ocorrencia_historica
      WHERE A.tp_ocorrencia_historica=11 AND 
	  dc_ato NOT IN 
	  ('IDENTIFICA AS CRECHES MUNICIPAIS DA SEBES','ALTERA O ARTIGO 1º DO DECRETO 42.788','DISTRITO DE CIDADE TIRADENTES','REMO RINALDI NADDEO, PROF.',
	  'LUIZ CINTRTA DO PRADO, PROF.','NEUSA BASSETO, PROFA.','PROF MARIA APARECIDA RODRIGUES CINTRA',
	  'TRES PONTES - NIZETE LETICIA BISPO DOS SANTOS LIMA, PROF','WLADIMIR HERZOG','')
	  AND DC_ATO IS NOT NULL
      GROUP BY
      cd_unidade_educacao, 
      B.dc_tipo_ocorrencia_historica) B ON A.CODESC=B.cd_unidade_educacao
where NOME_ANT is not null and rede='dir' AND NOMESC<>NOME_ANT
AND NOME_ANT NOT IN  ('IDENTIFICA AS CRECHES MUNICIPAIS DA SEBES','ALTERA O ARTIGO 1º DO DECRETO 42.788','DISTRITO DE CIDADE TIRADENTES','REMO RINALDI NADDEO, PROF.',
	  'LUIZ CINTRTA DO PRADO, PROF.','NEUSA BASSETO, PROFA.','PROF MARIA APARECIDA RODRIGUES CINTRA',
	  'TRES PONTES - NIZETE LETICIA BISPO DOS SANTOS LIMA, PROF','WLADIMIR HERZOG','')
--SELECT * FROM ##ESCOLAS_MUDARAM_NOME-- WHERE CODESC=019230

/*

SELECT
CODESC,
COUNT (CODESC) AS QTDE
FROM 
##ESCOLAS_MUDARAM_NOME
GROUP BY
CODESC
HAVING (COUNT (CODESC)>1)
ORDER BY 1
*/







