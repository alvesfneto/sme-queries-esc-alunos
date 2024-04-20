

SELECT DISTINCT
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
INTO ##SEM_CNPJ_EXEC
FROM SME_ESCOLA_DIARIO A 
JOIN D_ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE (cd_cnpj_entidade_executora IS NULL AND cd_cnpj_unidade_privada IS NOT NULL) AND A.CD_SIT = 1 AND A.TP_ESCOLA=15 
--------------------------------------------------------------
SELECT DISTINCT
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
INTO ##SEM_CNPJ_PRIV
FROM SME_ESCOLA_DIARIO A 
JOIN D_ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE (cd_cnpj_entidade_executora IS NOT NULL AND cd_cnpj_unidade_privada IS  NULL) AND A.CD_SIT = 1 AND A.TP_ESCOLA=15 

-----------------------------------------------------------------
SELECT 
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
INTO ##SEM_CNPJ
FROM SME_ESCOLA_DIARIO A 
JOIN D_ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE A.CD_SIT = 1 AND A.TP_ESCOLA=15 AND (cd_cnpj_entidade_executora IS NULL AND cd_cnpj_unidade_privada IS NULL)