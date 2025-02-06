
/*
Dispomos, por favor, das informações de geolocalização (latitude e latitude) das  UEs da RME?
Se sim, conseguimos agregar às informações abaixo? 

DRE
UE
CÓDIGO ESCOLA
ENDEREÇO
DISTRITO
E-MAIL
TELEFONE
GEOLOCALIZAÇÃO

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