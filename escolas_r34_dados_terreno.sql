/*
Considerando a solicita��o do setor de Pr�dios da DRE Campo Limpo, seria poss�vel acrescentar no relat�rio R34-ESCOLAS PARA DRE TODAS, 
as informa��es que constam no campo 5 (Descri��o do Terreno) da Ficha Cadastral da Escola? A saber:
*/
DROP TABLE ##R34_DESCRICAO_TERRENO
SELECT * 
INTO ##R34_DESCRICAO_TERRENO
FROM [dbo].[R34] A
LEFT JOIN VW_ESCOLAS_INF_GERAIS B ON A.CODESC=B.CD_ESCOLA COLLATE Latin1_General_CI_AS
WHERE DIRETORIA = 'CAMPO LIMPO'
--SELECT * FROM ##R34_DESCRICAO_TERRENO