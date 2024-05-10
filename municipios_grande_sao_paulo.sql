
--Municípios da grande São Paulo


--Norte: 
SELECT  
'NORTE' AS regiao,
nm_municipio AS MUNICIPIO,
cd_municipio AS CD_MUNICIPIO,
cd_municipio_mec AS CD_MUNICIPIO_MEC,
an_inclusao_municipio AS ANO_INCLUSAO,
sg_uf AS UF,
CONVERT(VARCHAR, CRDATE-1, 103) AS DT_BASE
INTO MUNICIPIOS_GRANDE_SAO_PAULO
 FROM D_MUNICIPIO 
 WHERE nm_municipio IN (
'Caieiras', 
'Cajamar', 
'Francisco Morato', 
'Franco da Rocha',
'Mairipora') 
AND sg_uf='SP'

UNION

--Leste: 
SELECT
'LESTE' AS regiao,
nm_municipio AS MUNICIPIO,
cd_municipio AS CD_MUNICIPIO,
cd_municipio_mec AS CD_MUNICIPIO_MEC,
an_inclusao_municipio AS ANO_INCLUSAO,
sg_uf AS UF,
CONVERT(VARCHAR, CRDATE-1, 103) AS DT_BASE

FROM D_MUNICIPIO WHERE nm_municipio IN (
'Arujá', 
'Biritiba-Mirim', 
'Ferraz de Vasconcelos', 
'Guararema', 
'Guarulhos', 
'Itaquaquecetuba', 
'Mogi das Cruzes', 
'Poá', 
'Salesópolis', 
'Santa Isabel', 
'Suzano')  
AND sg_uf='SP'

UNION
--Sudeste:
 
SELECT 
'SUDESTE' AS regiao,
nm_municipio AS MUNICIPIO,
cd_municipio AS CD_MUNICIPIO,
cd_municipio_mec AS CD_MUNICIPIO_MEC,
an_inclusao_municipio AS ANO_INCLUSAO,
sg_uf AS UF,
CONVERT(VARCHAR, CRDATE-1, 103) AS DT_BASE
FROM D_MUNICIPIO WHERE nm_municipio IN (
'Diadema', 
'Mauá', 
'Ribeirão Pires', 
'Rio Grande da Serra', 
'Santo André', 
'São Bernardo do Campo', 
'São Caetano do Sul')
AND sg_uf='SP'

UNION

--Sudoeste: 

SELECT
'SUDOESTE' AS regiao,
nm_municipio AS MUNICIPIO,
cd_municipio AS CD_MUNICIPIO,
cd_municipio_mec AS CD_MUNICIPIO_MEC,
an_inclusao_municipio AS ANO_INCLUSAO,
sg_uf AS UF,
CONVERT(VARCHAR, CRDATE-1, 103) AS DT_BASE
FROM D_MUNICIPIO WHERE nm_municipio IN (
'Cotia', 
'Embu das Artes', 
'Embu-Guacu', 
'Itapecerica da Serra', 
'Juquitiba', 
'São Lourenco da Serra', 
'Taboão da Serra', 
'Vargem Grande Paulista')
AND sg_uf='SP'

UNION
--Oeste: 

SELECT
'OESTE' AS regiao,
nm_municipio AS MUNICIPIO,
cd_municipio AS CD_MUNICIPIO,
cd_municipio_mec AS CD_MUNICIPIO_MEC,
an_inclusao_municipio AS ANO_INCLUSAO,
sg_uf AS UF,
CONVERT(VARCHAR, CRDATE-1, 103) AS DT_BASE
 FROM D_MUNICIPIO WHERE nm_municipio IN (
'Barueri', 
'Carapicuíba', 
'Itapevi', 
'Jandira', 
'Osasco', 
'Pirapora do Bom Jesus', 
'Santana de Parnaíba')
AND sg_uf='SP'


--SELECT * FROM MUNICIPIOS_GRANDE_SAO_PAULO





