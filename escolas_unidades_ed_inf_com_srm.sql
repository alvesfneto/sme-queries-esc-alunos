
/*
Quantidade de Salas de Recursos Multifuncionais (SRM) destinadas ao atendimento das unidades préescolares (CEI, CEMEI, EMEI, etc.);


DROP TABLE ##escolas_unidades_ed_inf_com_srm
SELECT 
DRE,
C.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
COUNT (DISTINCT CASE WHEN A.TP_AMBIENTE='10000' THEN cd_ambiente_escola ELSE NULL END) AS SALAS_SRM,
A.CRDATE
INTO ##escolas_unidades_ed_inf_com_srm
FROM D_AMBIENTE_ESCOLA A
JOIN D_TIPO_AMBIENTE B ON A.tp_ambiente=B.tp_ambiente
JOIN SME_ESCOLA_DIARIO C ON A.cd_escola=C.CD_ESCOLA
where A.tp_ambiente=10000 and A.dt_fim is null AND TP_ESCOLA IN (2,10,18,28,31)
--where A.tp_ambiente=10000 and A.dt_fim is null AND TP_ESCOLA IN (11,12)

GROUP BY
DRE,
C.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
A.CRDATE
--SELECT * FROM ##escolas_unidades_ed_inf_com_srm

DROP TABLE ##escolas_unidades_com_srm
SELECT 
DRE,
C.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
COUNT (DISTINCT CASE WHEN A.TP_AMBIENTE='10000' THEN cd_ambiente_escola ELSE NULL END) AS SALAS_SRM,
A.CRDATE
INTO ##escolas_unidades_com_srm
FROM D_AMBIENTE_ESCOLA A
JOIN D_TIPO_AMBIENTE B ON A.tp_ambiente=B.tp_ambiente
JOIN SME_ESCOLA_DIARIO C ON A.cd_escola=C.CD_ESCOLA
where A.tp_ambiente=10000 and A.dt_fim is null AND REDE = 'DIR'

GROUP BY
DRE,
C.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
A.CRDATE
--SELECT * FROM ##escolas_unidades_com_srm
*/



EXEC GERA_MISME_DIARIO

select 
A.DRE,
A.CD_ESCOLA, 
A.SG_TP_ESCOLA,
A.NOMESC,
MT_SRM,
CL_SRM, 
A.CRDATE 
from D_MISME_ESCOLA_TOTAL A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA


 where CL_SRM >0 AND TP_ESCOLA IN (2,4,10,17,18,28,30,31)

SELECT * from D_TIPO_ESCOLA ORDER BY sg_tp_escola
