/*
Prezado, solicito relatório para estudo de transferência de alunos de Infantil 
para prédio sito à Rua Alba Valdez, 05. (-23.751313916487813, -46.69654223237254)
No relatório deve constar: 
     Nome do aluno
     EOL do aluno
     Data de nascimento
     Apenas aluno de Infantil
     Endereço
     Unidade de Matrícula
     Distância da unidade de matrícula
     Distância para Rua Alba Valdez, 05
     Se o aluno tem deficiência
     Se tem TEG
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
drop table ##alunos_infantil_distantes_ate_5km_rua_alba_valdez_05
SELECT 
ETAPA,
SERIE_ANO,
NOME_ALUNO,
COD_ALUNO AS 'EOL_ALUNO',
CONVERT(DATE,DT_NASCIMENTO_ALUNO, 103) AS 'DATA_NASCIMENTO',
--Apenas aluno de Infantil
CONCAT(TP_LOGRADOURO,' ', ENDEREÇO) AS ENDERECO,
NR,
COMPL,
BAIRRO,
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
--Unidade de Matrícula
DIST_ESCOLA AS 'Dist_unidade_matrícula',
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.751313916487813 * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (-46.69654223237254 * 1000000)),2)) / 10)/0.6) AS 'Dist_Rua_Alba_Valdez_05',
CASE WHEN DEF1 IS NOT NULL THEN 'S' ELSE NULL END AS 'DEFICIENCIA',
CASE WHEN TEG ='SIM' THEN 'S' ELSE NULL END AS 'TEG',
A.CRDATE

INTO ##alunos_infantil_distantes_ate_5km_rua_alba_valdez_05

FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR A
LEFT JOIN (SELECT DISTINCT CD_ALUNO,DEF1 FROM SME_ALUNOS_DIARIO
	  WHERE DEF1 IS NOT NULL AND SG_ETAPA='ED INF') B ON A.COD_ALUNO=B.CD_ALUNO
LEFT JOIN (SELECT DISTINCT CD_ALUNO,TEG,TEG_BARREIRA,DC_MOTIVO_TRANSPORTE FROM ALUNOS_COM_TEG
		   WHERE TEG = 'SIM'
		   AND SG_ETAPA='ED INF') C ON A.COD_ALUNO=C.CD_ALUNO

WHERE ETAPA = 'ED INF' AND DRE='DRE - CS'
AND FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.751313916487813 * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (-46.69654223237254 * 1000000)),2)) / 10)/0.6)<=1500

--SELECT * FROM ##alunos_infantil_distantes_ate_5km_rua_alba_valdez_05

