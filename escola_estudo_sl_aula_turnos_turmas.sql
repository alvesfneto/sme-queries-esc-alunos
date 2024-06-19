
/*
Conforme contato telef�nico com o Andr�, venho pelo presente solicitar 
a rela��o de salas f�sicas das unidades 
do tipo EMEF, EMEFM e CEU EMEF, com indicativo de funcionamento por per�odo (manh� e tarde), por favor.
*/

DROP TABLE ##estudo_salas_aula_turmas_por_turno
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
NR_SALA,
COUNT(DISTINCT CASE WHEN CD_TIPO_TURNO=1 THEN DC_TURMA_ESCOLA ELSE NULL END) AS MANHA,
COUNT(DISTINCT CASE WHEN CD_TIPO_TURNO=2 THEN DC_TURMA_ESCOLA ELSE NULL END) AS INTERMEDIARIO,
COUNT(DISTINCT CASE WHEN CD_TIPO_TURNO=3 THEN DC_TURMA_ESCOLA ELSE NULL END) AS TARDE,
COUNT(DISTINCT CASE WHEN CD_TIPO_TURNO=4 THEN DC_TURMA_ESCOLA ELSE NULL END) AS VESPERINO,
COUNT(DISTINCT CASE WHEN CD_TIPO_TURNO=5 THEN DC_TURMA_ESCOLA ELSE NULL END) AS NOITE,
COUNT(DISTINCT CASE WHEN CD_TIPO_TURNO=6 THEN DC_TURMA_ESCOLA ELSE NULL END) AS INTEGRAL

INTO ##estudo_salas_aula_turmas_por_turno

FROM SME_CLASSES_DIARIO A 
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE SG_ETAPA IS NOT NULL AND TP_ESCOLA IN (1,3,16)

GROUP BY 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
NR_SALA
--SELECT * FROM  ##estudo_salas_aula_turmas_por_turno order by 2,5


DROP TABLE ##estudo_salas_aula_turmas_por_turno_lista
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
NR_SALA,
DC_TURMA_ESCOLA,
CASE WHEN CD_TIPO_TURNO=1 THEN 'MANH�' 
     WHEN CD_TIPO_TURNO=2 THEN 'INTERMEDIARIO'
     WHEN CD_TIPO_TURNO=3 THEN 'TARDE'
     WHEN CD_TIPO_TURNO=4 THEN 'VESPERINO'
     WHEN CD_TIPO_TURNO=5 THEN 'NOITE'
     WHEN CD_TIPO_TURNO=6 THEN 'INTEGRAL'
ELSE NULL END AS TURNO,
CONVERT(DATE,A.CRDATE,103) AS DT_BASE

INTO ##estudo_salas_aula_turmas_por_turno_lista

FROM SME_CLASSES_DIARIO A 
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE SG_ETAPA IS NOT NULL AND TP_ESCOLA IN (1,3,16)

--SELECT * FROM ##estudo_salas_aula_turmas_por_turno_lista

