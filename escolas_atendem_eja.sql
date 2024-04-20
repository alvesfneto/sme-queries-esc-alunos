/*
Prezados, boa tarde.

Gostaria de solicitar uma planilha com as unidades educacionais (por DRE) 
que possuem alguma modalidade de EJA. 
Seria possível especificar qual a modalidade de EJA assim 
como o respectivo número de turmas?

Desde já agradeço a atenção.
*/

SELECT
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_SERIE_ENSINO,
COUNT (DISTINCT CASE WHEN SG_ETAPA LIKE '%EJA%' THEN CD_TURMA_ESCOLA ELSE NULL END) AS CL_EJA,
COUNT (DISTINCT CASE WHEN SG_ETAPA LIKE '%EJA%' THEN CD_ALUNO ELSE NULL END) AS MT_EJA,
CONVERT(VARCHAR, A.CRDATE-1,103) AS DT_BASE
INTO ##ESCOLAS_COM_EJA
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE SG_ETAPA LIKE '%EJA%'
GROUP BY 
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
A.CRDATE,
SG_SERIE_ENSINO

