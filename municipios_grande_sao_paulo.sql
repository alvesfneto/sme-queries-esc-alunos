
--Munic�pios da grande S�o Paulo


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
'Aruj�', 
'Biritiba-Mirim', 
'Ferraz de Vasconcelos', 
'Guararema', 
'Guarulhos', 
'Itaquaquecetuba', 
'Mogi das Cruzes', 
'Po�', 
'Sales�polis', 
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
'Mau�', 
'Ribeir�o Pires', 
'Rio Grande da Serra', 
'Santo Andr�', 
'S�o Bernardo do Campo', 
'S�o Caetano do Sul')
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
'S�o Lourenco da Serra', 
'Tabo�o da Serra', 
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
'Carapicu�ba', 
'Itapevi', 
'Jandira', 
'Osasco', 
'Pirapora do Bom Jesus', 
'Santana de Parna�ba')
AND sg_uf='SP'


--SELECT * FROM MUNICIPIOS_GRANDE_SAO_PAULO





