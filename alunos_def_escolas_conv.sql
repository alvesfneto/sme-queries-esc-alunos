
/*
Recebemos o SEI, em epígrafe, que trata das matrículas das crianças com deficiência.

Do solicitado no ofício, em anexo, deveremos responder às perguntas abaixo:
a) Quantas creches conveniadas existem no município de São Paulo?

b) Qual o número de crianças matriculadas em creches conveniadas que possuem alguma deficiência?
 */
DROP TABLE ##alunos_def_escolas_conv
SELECT
DRE,

COUNT (DISTINCT CASE WHEN TP_ESCOLA=11 THEN A.CD_ESCOLA ELSE NULL END) AS 'CEI INDIR',
COUNT (DISTINCT CASE WHEN TP_ESCOLA=12 THEN A.CD_ESCOLA ELSE NULL END) AS 'CR.P.CONV.',
COUNT (DISTINCT CASE WHEN TP_ESCOLA IN (11,12) THEN A.CD_ESCOLA ELSE NULL END) AS 'TOT_ESCOLAS',
COUNT (DISTINCT CASE WHEN DEF1 IS NOT NULL THEN CD_ALUNO ELSE NULL END) AS QT_DEF
INTO ##alunos_def_escolas_conv
FROM SME_ESCOLA_DIARIO A 
JOIN SME_ALUNOS_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE CD_SERIE_ENSINO IN (1,4,3,6,27,11,28,29,321,322) AND TP_ESCOLA IN (11,12)
GROUP BY DRE WITH ROLLUP

--SELECT * FROM ##alunos_def_escolas_conv

