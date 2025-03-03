<<<<<<< HEAD
/*
Solicitamos o ponto a ponto dos endere�os das crian�as que ir�o para a EMEI em 2025:

DE: 
CR.P CONV Rugrats II, 307990
CR.P CONV Educar, 308756
CR.P CONV Trilhando caminhos, 309297
CR.P CONV Ipiranga, 306919
CR.P CONV Transformando Vidas,309005 
CR.P CONV Ivete Atalla, 309857
CR.P CONV Joel Correa 306308, 
CEI DIR Monumento-400183 e 
CEI INDIR Vila Monumento.306316

Para: EMEI Delfino Azevedo 091910 e 
EMEI Pedro I, D. 092011
select * from sme_escola_diario where nomesc like '%DELFINO%' and dre = 'dre - ip'
*/

DROP Table ##LISTA_ALUNOS_MGII_DRE_IP
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
DISTR AS DISTRITO_ESCOLA,
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
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - (-23.580083 * 1000000) ),2) +  
				           POWER((LON_ALUNO * 1000000 - (-46.605766 * 1000000)),2)) / 10)/0.6) AS DIST_EMEI_PEDRO_I,

FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - (-23.582629 * 1000000) ),2) +  
				           POWER((LON_ALUNO * 1000000 - (-46.613615 * 1000000)),2)) / 10)/0.6) AS DIST_EMEI_DELFINO,



CONVERT(DATE,A.CRDATE, 103) AS DT_BASE

INTO ##LISTA_ALUNOS_MGII_DRE_IP

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
A.CD_ESCOLA IN (307990,308756,309297,306919,309005,309857,306308,400183,306316)
--C.DISTR = 'RIO PEQUENO' 
--AND TP_ESCOLA IN (10,11,12,18,28,31)
AND D.CD_FAIXA=4
=======
/*
Solicitamos o ponto a ponto dos endere�os das crian�as que ir�o para a EMEI em 2025:

DE: 
CR.P CONV Rugrats II, 307990
CR.P CONV Educar, 308756
CR.P CONV Trilhando caminhos, 309297
CR.P CONV Ipiranga, 306919
CR.P CONV Transformando Vidas,309005 
CR.P CONV Ivete Atalla, 309857
CR.P CONV Joel Correa 306308, 
CEI DIR Monumento-400183 e 
CEI INDIR Vila Monumento.306316

Para: EMEI Delfino Azevedo 091910 e 
EMEI Pedro I, D. 092011
select * from sme_escola_diario where nomesc like '%DELFINO%' and dre = 'dre - ip'
*/

DROP Table ##LISTA_ALUNOS_MGII_DRE_IP
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
DISTR AS DISTRITO_ESCOLA,
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
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - (-23.580083 * 1000000) ),2) +  
				           POWER((LON_ALUNO * 1000000 - (-46.605766 * 1000000)),2)) / 10)/0.6) AS DIST_EMEI_PEDRO_I,

FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - (-23.582629 * 1000000) ),2) +  
				           POWER((LON_ALUNO * 1000000 - (-46.613615 * 1000000)),2)) / 10)/0.6) AS DIST_EMEI_DELFINO,



CONVERT(DATE,A.CRDATE, 103) AS DT_BASE

INTO ##LISTA_ALUNOS_MGII_DRE_IP

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
A.CD_ESCOLA IN (307990,308756,309297,306919,309005,309857,306308,400183,306316)
--C.DISTR = 'RIO PEQUENO' 
--AND TP_ESCOLA IN (10,11,12,18,28,31)
AND D.CD_FAIXA=4
>>>>>>> b46c277944e78f2cfc8c734a3e235543716689cb
--SELECT * FROM ##LISTA_ALUNOS_MGII_DRE_IP