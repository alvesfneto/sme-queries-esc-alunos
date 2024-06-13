
drop table ##escolas_salas_de_aula_fora_metragem_area_util
SELECT 
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
DC_TIPO_AMBIENTE,
NR_SALA,
QT_AREA_UTIL,
A.CRDATE AS DT_BASE

into ##escolas_salas_de_aula_fora_metragem_area_util
 FROM SME_CLASSES_DIARIO A
 JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
where qt_area_util>100  AND DC_TIPO_AMBIENTE IN ('SALA DE AULA PROPRIA','SALA DE AULA ADAPTADA','SALA DE ED. INFANTIL PROPRIA','SALA DE ED. INFANTIL ADAPTADA','SALA DE ED. ESPECIAL PROPRIA','SALA DE ED. ESPECIAL ADAPTADA','BERCARIO')
ORDER BY DRE

--select * from##escolas_salas_de_aula_fora_metragem_area_util

/*SELECT * FROM tipo_ambiente 
WHERE tp_ambiente IN (2,10015,1,6,5,4,3,116)
ORDER BY 2
*/