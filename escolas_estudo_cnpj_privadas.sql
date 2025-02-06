
SELECT DISTINCT
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
--INTO ##SEM_CNPJ_EXEC
FROM SME_ESCOLA_DIARIO A 
JOIN DB_EDUCACAO_1_PRODAM.se1426.dbo.ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE (cd_cnpj_entidade_executora IS NULL AND cd_cnpj_unidade_privada IS NOT NULL) AND A.CD_SIT = 1 AND A.TP_ESCOLA=12
AND DRE = 'DRE - BT'
ORDER BY A.CD_ESCOLA
--------------------------------------------------------------
SELECT DISTINCT
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
--INTO ##SEM_CNPJ_PRIV
FROM SME_ESCOLA_DIARIO A 
JOIN DB_EDUCACAO_1_PRODAM.se1426.dbo.ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE (cd_cnpj_entidade_executora IS NOT NULL AND cd_cnpj_unidade_privada IS  NULL) AND A.CD_SIT = 1 AND A.TP_ESCOLA=12 

-----------------------------------------------------------------
SELECT 
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
--INTO ##SEM_CNPJ
FROM SME_ESCOLA_DIARIO A 
JOIN DB_EDUCACAO_1_PRODAM.se1426.dbo.ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE A.CD_SIT = 1 AND A.TP_ESCOLA=12 AND (cd_cnpj_entidade_executora IS NULL AND cd_cnpj_unidade_privada IS NULL)
--SELECT * FROM ##SEM_CNPJ


SELECT DISTINCT
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.cd_cnpj_entidade_executora,
B.cd_cnpj_unidade_privada
--INTO ##SEM_CNPJ_EXEC
FROM SME_ESCOLA_DIARIO A 
JOIN DB_EDUCACAO_1_PRODAM.se1426.dbo.ESCOLA B ON A.CD_ESCOLA=B.cd_escola
WHERE A.CD_SIT = 1 AND A.TP_ESCOLA=15 