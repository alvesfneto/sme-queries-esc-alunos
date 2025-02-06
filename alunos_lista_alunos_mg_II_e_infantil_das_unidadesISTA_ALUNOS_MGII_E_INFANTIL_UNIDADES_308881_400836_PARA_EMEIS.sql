
/*
Solicitamos o ponto a ponto dos endere�os das crian�as com idade de EMEI para 2025 incluindo o infantil das unidades abaixo:

-CEI Educando (308881) para as Emeis at� 1,5 km.
-CEI Kandinsky(400836) para as Emeis at� 1,5 km.

*/

DROP TABLE ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
A.SG_SERIE_ENSINO,
D.DC_SERIE_ENSINO,
CD_ALUNO,
NM_ALUNO,
NM_MAE_ALUNO,
NM_PAI_ALUNO,
CONVERT(DATE,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
B.ENDERECO,
B.NR,
B.COMPL,
B.BAIRRO,
B.CEP,
DIST_ESCOLA,
B.LAT_ALUNO,
B.LON_ALUNO,



CONVERT(DATE,A.CRDATE, 103) AS DT_BASE



INTO ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836

FROM SME_ALUNOS_DIARIO A
JOIN (SELECT DISTINCT
      COD_ALUNO,
      CONCAT(TP_LOGRADOURO,' ',ENDERE�O) AS ENDERECO,
      NR,
      COMPL,
      BAIRRO,
      CEP,
      DIST_ESCOLA,
      LAT_ALUNO,
      LON_ALUNO
      FROM VW_ALUNOS_ENDERECOS) B ON A.CD_ALUNO=B.COD_ALUNO
JOIN SME_ESCOLA_DIARIO C ON A.CD_ESCOLA=C.CD_ESCOLA

JOIN (SELECT	DISTINCT --EM TESE N�O DEVERIA HAVER DUPLICADAS, MAS POR SEGURAN�A
       	CD_FAIXA,
       	CONVERT(DATETIME,CONVERT(VARCHAR(4),DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA) + CONVERT(VARCHAR(2), MM_INICIO_FAIXA) + CONVERT(VARCHAR(2), DD_INICIO_FAIXA)) AS DT_INICIO_FAIXA,
       	CONVERT(DATETIME,CONVERT(VARCHAR(4),DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_FIM_FAIXA) + CONVERT(VARCHAR(2), MM_FIM_FAIXA) + CONVERT(VARCHAR(2), DD_FIM_FAIXA)) AS DT_FIM_FAIXA,
       	CASE 
       		WHEN (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ - (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA)) = 1 THEN '0 E 1 ANO'
       		ELSE CONVERT(VARCHAR(2),(DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ - (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA))) + ' ANOS' 
       		END AS IDADE,
       	T1.CD_SERIE_ENSINO, 
       	T2.DC_SERIE_ENSINO,
       	T2.CD_CICLO_ENSINO,
       	T2.SG_SERIE_ENSINO,
       	T2.cd_etapa_ensino,
       	T3.dc_etapa_ensino
       FROM	D_FAIXA_SERIE AS T1
       INNER JOIN D_SERIE_ENSINO AS T2 ON T1.CD_SERIE_ENSINO = T2.CD_SERIE_ENSINO
       INNER JOIN D_ETAPA_ENSINO AS T3 ON T2.cd_etapa_ensino = T3.cd_etapa_ensino
       WHERE	T1.DT_INICIO <= GETDATE()
       		AND (T1.DT_FIM IS NULL OR T1.DT_FIM >= CONVERT(DATE,GETDATE()))
       		AND TP_FAIXA =5) D ON A.DT_NASCIMENTO_ALUNO BETWEEN D.DT_INICIO_FAIXA AND D.DT_FIM_FAIXA


WHERE 
C.DRE = 'DRE - IP'
AND C.REDE IN ('DIR','CONV')
AND D.CD_FAIXA=4

UNION

SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
A.SG_SERIE_ENSINO,
D.DC_SERIE_ENSINO,
CD_ALUNO,
NM_ALUNO,
NM_MAE_ALUNO,
NM_PAI_ALUNO,
CONVERT(DATE,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
B.ENDERECO,
B.NR,
B.COMPL,
B.BAIRRO,
B.CEP,
DIST_ESCOLA,
LAT_ALUNO,
LON_ALUNO,

CONVERT(DATE,A.CRDATE, 103) AS DT_BASE

FROM SME_ALUNOS_DIARIO A
JOIN (SELECT DISTINCT
      COD_ALUNO,
      CONCAT(TP_LOGRADOURO,' ',ENDERE�O) AS ENDERECO,
      NR,
      COMPL,
      BAIRRO,
      CEP,
      DIST_ESCOLA,
      LAT_ALUNO,
      LON_ALUNO
      FROM VW_ALUNOS_ENDERECOS) B ON A.CD_ALUNO=B.COD_ALUNO
JOIN SME_ESCOLA_DIARIO C ON A.CD_ESCOLA=C.CD_ESCOLA

JOIN (SELECT	DISTINCT --EM TESE N�O DEVERIA HAVER DUPLICADAS, MAS POR SEGURAN�A
       	CD_FAIXA,
       	CONVERT(DATETIME,CONVERT(VARCHAR(4),DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA) + CONVERT(VARCHAR(2), MM_INICIO_FAIXA) + CONVERT(VARCHAR(2), DD_INICIO_FAIXA)) AS DT_INICIO_FAIXA,
       	CONVERT(DATETIME,CONVERT(VARCHAR(4),DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_FIM_FAIXA) + CONVERT(VARCHAR(2), MM_FIM_FAIXA) + CONVERT(VARCHAR(2), DD_FIM_FAIXA)) AS DT_FIM_FAIXA,
       	CASE 
       		WHEN (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ - (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA)) = 1 THEN '0 E 1 ANO'
       		ELSE CONVERT(VARCHAR(2),(DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ - (DATEPART(YYYY, GETDATE()) /*@ANO_REFERENCIA_PARAMETRO_MATRICULA*/ + AN_INCREMENTO_INICIO_FAIXA))) + ' ANOS' 
       		END AS IDADE,
       	T1.CD_SERIE_ENSINO, 
       	T2.DC_SERIE_ENSINO,
       	T2.CD_CICLO_ENSINO,
       	T2.SG_SERIE_ENSINO,
       	T2.cd_etapa_ensino,
       	T3.dc_etapa_ensino
       FROM	D_FAIXA_SERIE AS T1
       INNER JOIN D_SERIE_ENSINO AS T2 ON T1.CD_SERIE_ENSINO = T2.CD_SERIE_ENSINO
       INNER JOIN D_ETAPA_ENSINO AS T3 ON T2.cd_etapa_ensino = T3.cd_etapa_ensino
       WHERE	T1.DT_INICIO <= GETDATE()
       		AND (T1.DT_FIM IS NULL OR T1.DT_FIM >= CONVERT(DATE,GETDATE()))
       		AND TP_FAIXA =5) D ON A.DT_NASCIMENTO_ALUNO BETWEEN D.DT_INICIO_FAIXA AND D.DT_FIM_FAIXA

WHERE 
C.CD_ESCOLA IN (308881,400836) 

AND D.cd_faixa IN (5,6)
--SELECT * FROM ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836



DROP TABLE ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836_PARA_EMEIS
SELECT 
A.*,
CONCAT(B.CD_ESCOLA,' ',B.SG_TP_ESCOLA,'',B.NOMESC) AS EMEI_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6) AS DISTANCIA

INTO ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836_PARA_EMEIS

FROM ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836 A, SME_ESCOLA_DIARIO B

WHERE B.TP_ESCOLA IN (2,17,28,31) AND B.DRE = 'DRE - IP'
AND 
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6)<=1500
--SELECT * FROM ##LISTA_ALUNOS_MGII_E_INFANTIL_UNIDADES_308881_400836_PARA_EMEIS