
/*estudo migrantes - venezuela,bolivia,haiti*/

DROP TABLE ##RELACAO_MATRIC_MIGRANTES
SELECT DISTINCT

DRE,
COUNT (DISTINCT CASE WHEN SG_ETAPA IS NOT NULL THEN CD_ALUNO ELSE NULL END) AS MATR,
COUNT (DISTINCT CASE WHEN (SG_ETAPA IS NOT NULL AND CD_PAIS_MEC<>'10') THEN CD_ALUNO ELSE NULL END) AS MIGRANTES,
CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
INTO ##RELACAO_MATRIC_MIGRANTES
FROM SME_ALUNOS A
JOIN SME_ESCOLA B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE SG_ETAPA IS NOT NULL
GROUP BY
DRE,A.CRDATE--WITH ROLLUP
ORDER BY 3 DESC
--SELECT * FROM ##RELACAO_MATRIC_MIGRANTES
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/


DROP TABLE ##MATRICULAS_ETAPA_PAIS_ORIGEM
SELECT DISTINCT
DRE,
SG_ETAPA,
C.NM_PAIS_MEC,
COUNT (DISTINCT CASE WHEN A.CD_PAIS_MEC<>10 THEN CD_ALUNO ELSE NULL END) AS MATRIC,
CONVERT(VARCHAR,A.CRDATE-1, 103) AS DT_BASE
INTO ##MATRICULAS_ETAPA_PAIS_ORIGEM
FROM SME_ALUNOS A
JOIN SME_ESCOLA B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN PAIS_EOL_MEC C ON A.CD_PAIS_MEC=C.CD_PAIS_MEC
WHERE SG_ETAPA IS NOT NULL
GROUP BY 
DRE,
SG_ETAPA,
C.NM_PAIS_MEC,
A.CRDATE
--SELECT * FROM ##MATRICULAS_ETAPA_PAIS_ORIGEM

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

DROP TABLE ##RESUMO_MIGRANTES_BOLIVIA_HAITI_VENEZUELA
SELECT 
DRE,
COUNT (DISTINCT CASE WHEN CD_PAIS_MEC<>10 THEN CD_ALUNO ELSE NULL END) AS MIGRANTES,
COUNT (DISTINCT CASE WHEN CD_PAIS_MEC=22 THEN CD_ALUNO ELSE NULL END) AS BOLIVIA,
COUNT (DISTINCT CASE WHEN CD_PAIS_MEC=92 THEN CD_ALUNO ELSE NULL END) AS VENEZUELA,
COUNT (DISTINCT CASE WHEN CD_PAIS_MEC=62 THEN CD_ALUNO ELSE NULL END) AS HAITI
INTO ##RESUMO_MIGRANTES_BOLIVIA_HAITI_VENEZUELA
FROM 
##MATRICULAS_ETAPA_PAIS_ORIGEM
WHERE CD_PAIS_MEC IN (22,62,92)
GROUP BY DRE
ORDER BY COUNT (DISTINCT CASE WHEN CD_PAIS_MEC<>10 THEN CD_ALUNO ELSE NULL END) DESC
--SELECT * FROM ##RESUMO_MIGRANTES_BOLIVIA_HAITI_VENEZUELA

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/