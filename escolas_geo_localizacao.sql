
/*
Dispomos, por favor, das informa��es de geolocaliza��o (latitude e latitude) das  UEs da RME?
Se sim, conseguimos agregar �s informa��es abaixo? 

DRE
UE
C�DIGO ESCOLA
ENDERE�O
DISTRITO
E-MAIL
TELEFONE
GEOLOCALIZA��O

*/
DROP TABLE ##escolas_geo_localizacao
SELECT 
DRE,
CODESC AS [CODIGO ESCOLA],
ENDERECO,
NUMERO,
DISTRITO,
EMAIL,
TEL1,
TEL2,
LATITUDE,
LONGITUDE,
[DATABASE]
INTO ##escolas_geo_localizacao
FROM [dbo].[VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL]
--SELECT * FROM ##escolas_geo_localizacao