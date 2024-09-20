﻿/*


Peço seus préstimos para nos fornecer relatório para alunos matriculados com distância linear a menos 1km para o endereço 
RUA ALBA VALDEZ, 101 - JD REIMBERG(-23.750748856036285, -46.69657503237254)


Por favor,  uma planilha(relatório)  para cada endereço. 


No relatório deve constar:

Nome do aluno
EOL do aluno
Agrupamento
Endereço do aluno (separado por coluna, nome da rua, numero, bairro e CEP)
Unidade de matrícula
Distância da Unidade de matrícula
Distância para o endereço indicado
Se possui TEG
Se tem deficiência

*/
DROP TABLE ##alunos_infantil_distantes_ate_1km_RUA_ALBA_VALDEZ_101_JD_REIMBERG
SELECT 
ETAPA,
SERIE_ANO,
NOME_ALUNO,
COD_ALUNO AS 'EOL_ALUNO',
CONVERT(DATE,DT_NASCIMENTO_ALUNO, 103) AS 'DATA_NASCIMENTO',
--Apenas aluno de Infantil
UPPER(CONCAT(TP_LOGRADOURO,' ', ENDEREÇO)) AS ENDERECO,
NR,
COMPL,
BAIRRO,
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
--Unidade de Matrícula
DIST_ESCOLA AS 'Dist_unidade_matrícula',
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.750748856036285 * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (-46.69657503237254 * 1000000)),2)) / 10)/0.6) AS 'DIST_RUA_ALBA_VALDEZ_101_JD_REIMBERG',
CASE WHEN DEF1 IS NOT NULL THEN 'S' ELSE NULL END AS 'DEFICIENCIA',
CASE WHEN TEG ='SIM' THEN 'S' ELSE NULL END AS 'TEG',
A.CRDATE

INTO ##alunos_infantil_distantes_ate_1km_RUA_ALBA_VALDEZ_101_JD_REIMBERG

FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR A
LEFT JOIN (SELECT DISTINCT CD_ALUNO,DEF1 FROM SME_ALUNOS_DIARIO
	  WHERE DEF1 IS NOT NULL AND SG_ETAPA='ED INF') B ON A.COD_ALUNO=B.CD_ALUNO
LEFT JOIN (SELECT DISTINCT CD_ALUNO,TEG,TEG_BARREIRA,DC_MOTIVO_TRANSPORTE FROM ALUNOS_COM_TEG
		   WHERE TEG = 'SIM'
		   AND SG_ETAPA='ED INF') C ON A.COD_ALUNO=C.CD_ALUNO

WHERE ETAPA = 'ED INF' AND DRE='DRE - CS'
AND FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.750748856036285 * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (-46.69657503237254 * 1000000)),2)) / 10)/0.6)<=1000

--SELECT * FROM ##alunos_infantil_distantes_ate_1km_RUA_ALBA_VALDEZ_101_JD_REIMBERG