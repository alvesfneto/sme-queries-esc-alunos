--ESTUDO DE AMBIENTES COMPARTILHADOS ENTRE ESCOLAS DA RME

DROP TABLE ##AMBIENTES_COMPARTILHADOS_OUTRAS_UNIDADES
SELECT DISTINCT 
C.DRE,
A.CD_ESCOLA,
C.SG_TP_ESCOLA AS TIPO,
C.NOMESC,
B.tp_ambiente,
B.dc_tipo_ambiente AS AMBIENTE,
CONCAT(cd_unidade_educacao_compartilhada,' - ',D.SG_TP_ESCOLA,' ',D.NOMESC) AS UNID_COMPARTILHADA,
in_utilizacao_sala_aula,
CONVERT(VARCHAR,A.CRDATE-1, 103) AS DT_BASE
INTO ##AMBIENTES_COMPARTILHADOS_OUTRAS_UNIDADES
FROM D_AMBIENTE_ESCOLA A
JOIN tipo_ambiente B ON A.tp_ambiente=B.tp_ambiente
JOIN SME_ESCOLA_DIARIO C ON A.cd_escola=C.CD_ESCOLA
JOIN SME_ESCOLA_DIARIO D ON A.cd_unidade_educacao_compartilhada=D.CD_ESCOLA
WHERE cd_unidade_educacao_compartilhada IS NOT NULL AND A.dt_fim IS NULL AND C.CD_SIT=1 AND C.TP_ESCOLA IN (1,2,3,4,10,11,12,13,16,17,18,28,30,31)
ORDER BY 1

--SELECT * FROM ##AMBIENTES_COMPARTILHADOS_OUTRAS_UNIDADES

--SELECT DISTINCT TP_AMBIENTE,AMBIENTE FROM ##AMBIENTES_COMPARTILHADOS_OUTRAS_UNIDADES

--SELECT * FROM ##AMBIENTES_COMPARTILHADOS_OUTRAS_UNIDADES WHERE TIPO NOT LIKE 'CEU%' AND UNID_COMPARTILHADA NOT LIKE '7%'