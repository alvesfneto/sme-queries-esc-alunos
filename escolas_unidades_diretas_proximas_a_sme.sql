
/*Gostaria da rela��o de EMEIs, CEMEIs e EMEFs em um raio de 15 Km da SME. Na planilha, favor incluir endere�o, DRE e dist�ncia.*/

DROP TABLE ##ESCOLAS_PROXIMAS_SME
SELECT DISTINCT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
ENDERECO,
NR,
COMPL,
BAIRRO,
FLOOR(FLOOR(SQRT(POWER((CD_COORDENADA_GEO_Y * 1000000 - (-23.595182136902334 * 1000000) ),2) +  
				 POWER((CD_COORDENADA_GEO_X * 1000000 - (-46.64881799173911 * 1000000)),2)) / 10)/0.6) AS DIST_SME,
CONVERT(VARCHAR,CRDATE-1, 103) AS DT_BASE

INTO ##ESCOLAS_PROXIMAS_SME
FROM SME_ESCOLA_DIARIO

WHERE CD_SIT=1 AND TP_ESCOLA IN(1,2,16,17,28,31)
AND 
FLOOR(FLOOR(SQRT(POWER((CD_COORDENADA_GEO_Y * 1000000 - (-23.595182136902334 * 1000000) ),2) +  
				 POWER((CD_COORDENADA_GEO_X * 1000000 - (-46.64881799173911 * 1000000)),2)) / 10)/0.6) <=15000
--SELECT * FROM ##ESCOLAS_PROXIMAS_SME
--------------------------------------------------------------------------------------------------------------
 