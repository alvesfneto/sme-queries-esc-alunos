/*Bom dia!

Por favor, solicitamos o estudo ponto a ponto 
dos alunos do MGII e MGM com idade para EMEI 
matriculados nas unidades abaixo relacionadas 
em rela��o a 
EMEI Jo�o Theodoro - 091880 e 
EMEI Alceu Maynard de Araujo - 091898.

CR.P.CONV. Casa Dom Gast�o -          306402 --select cd_sit,cd_escola,nomesc,sg_tp_escola from sme_escola_diario where nomesc like '%social da crianca%' and dre = 'dre - ip'
CR.P.CONV. Gr�o de Gente II -         306408
CR.P.CONV. Lar Crian�a Feliz -        400480
CR.P.CONV. Centro Social da Crian�a - 306540
CEI Indir. Ponte Pequena -            400322

Atenciosamente,
*/DROP TABLE ##LISTA_ALUNOS_MG2
SELECT 
C.DRE,
A.CD_ESCOLA,
C.SG_TP_ESCOLA,
C.NOMESC,
A.SG_ETAPA,
A.SG_SERIE_ENSINO,
D.DC_SERIE_ENSINO,
A.CD_ALUNO,
NM_ALUNO,
NM_MAE_ALUNO,
NM_PAI_ALUNO,
CONVERT(DATE,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
B.ENDERECO,
B.NR,
B.COMPL,
B.BAIRRO,
B.CEP,
B.DIST_ESCOLA,
CASE WHEN DEF1 IS NOT NULL THEN 'SIM' ELSE NULL END AS DEFICIENCIA,
E.TEG,
B.LAT_ALUNO,
B.LON_ALUNO,



CONVERT(DATE,A.CRDATE, 103) AS DT_BASE



INTO ##LISTA_ALUNOS_MG2

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
LEFT JOIN ALUNOS_COM_TEG E ON A.CD_ALUNO=E.CD_ALUNO

WHERE 
A.cd_escola IN ( 306402,306408,400480,306540,400322)

AND D.CD_FAIXA=4

--SELECT * FROM ##LISTA_ALUNOS_MG2



DROP TABLE ##alunos_lista_alunos_mg2
SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
dc_serie_ensino,
CD_ALUNO,
NM_ALUNO,
ENDERECO,
NR,
COMPL,
BAIRRO,
CEP,
DIST_ESCOLA,
'EMEI JOAO THEODORO' AS DESTINO_1,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( -23.532245 * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.634934 * 1000000)),2)) / 10)/0.6) AS DIST_DESTINO_1,

'EMEI Alceu Maynard de Araujo' AS DESTINO_2,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( -23.519089 * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.649773 * 1000000)),2)) / 10)/0.6) AS DIST_DESTINO_2,

--SELECT CD_ESCOLA,NOMESC,CD_COORDENADA_GEO_Y,CD_COORDENADA_GEO_X FROM SME_ESCOLA_DIARIO WHERE CD_ESCOLA IN(091880,091898)

TEG,
DEFICIENCIA,
DT_BASE
INTO ##alunos_lista_alunos_mg2
 FROM ##LISTA_ALUNOS_MG2



--WHERE FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( -23.751254995709367 * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.69653150353766 * 1000000)),2)) / 10)/0.6)<=1000

--SELECT * FROM ##alunos_lista_alunos_mg2
