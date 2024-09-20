/*
Considerando a solicitação do setor de Prédios da DRE Campo Limpo, seria possível acrescentar no relatório R34-ESCOLAS PARA DRE TODAS, 
as informações que constam no campo 5 (Descrição do Terreno) da Ficha Cadastral da Escola? A saber:
*/
DROP TABLE ##R34_DESCRICAO_TERRENO
SELECT * 
INTO ##R34_DESCRICAO_TERRENO
FROM [dbo].[R34] A
LEFT JOIN VW_ESCOLAS_INF_GERAIS B ON A.CODESC=B.CD_ESCOLA COLLATE Latin1_General_CI_AS
WHERE DIRETORIA = 'CAMPO LIMPO'
--SELECT * FROM ##R34_DESCRICAO_TERRENO