<<<<<<< HEAD

/*

1 -->   Solicitamos para estudo de demanda uma planilha que conste todos os alunos por agrupamento, com c�digo EOL da crian�a, nome completo, filia��o, endere�o completo e data de nascimento das EMEIs abaixo:

      - CEU EMEI BUTANT�  Infantil I e II ( 019281 );
	  - CEU CEI BUTANT� MGII  (400514)
      - CEI  BLANDINA MEIRELLES MGII (306186)
      - CEI LAR PAULO DE TARSO MGII (306201)
      - CEI NOSSA SRA. ASSUN��O MGII (400332)
      - CEI JARDIM JULIETA MGII (400089)
      - CEI JOS� OZI, PROF. MGII (400163)
      - CEI YVONE LEMOS DE ALMEIDA FRAGA (400268)
      - CEI VOV� JOS� MGII (308942)


2 -->   Necessitamos de uma planilha indicando a quantidade de MGII matriculados  por CEI, do seguinte Distrito:

    - Distrito Rio Pequeno;

*/

EXEC GERA_DEMANDA_POR_ESCOLA_COM_PREF

--1
DROP TABLE ##demanda_para_escolas_especificas
SELECT * 
into ##demanda_para_escolas_especificas
FROM [dbo].[BT]
where cd_escola in(019281,400514,306186,306201,400332,400089,400163,400268,308942)
--SELECT * FROM ##demanda_para_escolas_especificas

----------------------------------------------------------------------------------------------------------------

--2

DROP Table ##LISTA_ALUNOS_MGII_DRE_BT
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
CONVERT(DATE,A.CRDATE, 103) AS DT_BASE

INTO ##LISTA_ALUNOS_MGII_DRE_BT

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
C.DISTR = 'RIO PEQUENO' 
AND TP_ESCOLA IN (10,11,12,18,28,31)
AND D.CD_FAIXA=4
--SELECT * FROM ##LISTA_ALUNOS_MGII_DRE_BT


=======

/*

1 -->   Solicitamos para estudo de demanda uma planilha que conste todos os alunos por agrupamento, com c�digo EOL da crian�a, nome completo, filia��o, endere�o completo e data de nascimento das EMEIs abaixo:

      - CEU EMEI BUTANT�  Infantil I e II ( 019281 );
	  - CEU CEI BUTANT� MGII  (400514)
      - CEI  BLANDINA MEIRELLES MGII (306186)
      - CEI LAR PAULO DE TARSO MGII (306201)
      - CEI NOSSA SRA. ASSUN��O MGII (400332)
      - CEI JARDIM JULIETA MGII (400089)
      - CEI JOS� OZI, PROF. MGII (400163)
      - CEI YVONE LEMOS DE ALMEIDA FRAGA (400268)
      - CEI VOV� JOS� MGII (308942)


2 -->   Necessitamos de uma planilha indicando a quantidade de MGII matriculados  por CEI, do seguinte Distrito:

    - Distrito Rio Pequeno;

*/

EXEC GERA_DEMANDA_POR_ESCOLA_COM_PREF

--1
DROP TABLE ##demanda_para_escolas_especificas
SELECT * 
into ##demanda_para_escolas_especificas
FROM [dbo].[BT]
where cd_escola in(019281,400514,306186,306201,400332,400089,400163,400268,308942)
--SELECT * FROM ##demanda_para_escolas_especificas

----------------------------------------------------------------------------------------------------------------

--2

DROP Table ##LISTA_ALUNOS_MGII_DRE_BT
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
CONVERT(DATE,A.CRDATE, 103) AS DT_BASE

INTO ##LISTA_ALUNOS_MGII_DRE_BT

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
C.DISTR = 'RIO PEQUENO' 
AND TP_ESCOLA IN (10,11,12,18,28,31)
AND D.CD_FAIXA=4
--SELECT * FROM ##LISTA_ALUNOS_MGII_DRE_BT


>>>>>>> b46c277944e78f2cfc8c734a3e235543716689cb
