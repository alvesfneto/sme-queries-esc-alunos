
/*
Bom dia!

Por favor, gostaria de receber um levantamento de quantas escolas atendem crian�as com defici�ncias na rede.

Dentre elas, poderiam discriminar as que possuem salas de recursos especiais e as que n�o possuem?

Favor levantar as escolas por DRE.

 */

DROP TABLE ##ESCOLAS_ATENDEM_NEE
SELECT DISTINCT 
B.DRE,
B.REDE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
CD_ALUNO,
--DEF1,
--DEF2,
--DEF3,
--DEF4,
--DEF5,
--DEF6,
--DEF7,
--DEF8,
--DEF9,
--DEF10,
CASE WHEN (DEF1 IS NOT NULL AND DEF2 IS NULL) THEN C.dc_necessidade_especial
     WHEN (DEF1 IS NOT NULL AND DEF2 IS NOT NULL) THEN 'DEFICIENCIA MULTIPLA'
	 ELSE NULL END AS DEF,

CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE

INTO ##ESCOLAS_ATENDEM_NEE
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN tipo_necessidade_especial C ON A.DEF1=C.tp_necessidade_especial
WHERE DEF1 IS NOT NULL AND SG_ETAPA IS NOT NULL
--SELECT * FROM ##ESCOLAS_ATENDEM_NEE
---------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE ##ESCOLAS_ATENDEM_NEE_RESUMO
SELECT DISTINCT
A.DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
'SIM' AS ATENDE_NEE,
CASE WHEN [SALA RECURSOS MULTIFUNCIONAIS] IS NOT NULL THEN 'SIM' ELSE 'N�O' END AS SRM,
DT_BASE
INTO ##ESCOLAS_ATENDEM_NEE_RESUMO
FROM ##ESCOLAS_ATENDEM_NEE A
JOIN ##ESCOLA_AMBIENTES_LINEAR B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE A.REDE = 'DIR'

--SELECT * FROM ##ESCOLAS_ATENDEM_NEE_RESUMO




SELECT DISTINCT 
B.DRE,
B.SG_TP_ESCOLA,
COUNT (DISTINCT CASE WHEN DEF1 IS NOT NULL THEN B.CD_ESCOLA ELSE NULL END) AS ATENDE_NEE,
COUNT (DISTINCT CASE WHEN C.[SALA RECURSOS MULTIFUNCIONAIS] IS NOT NULL THEN C.CD_ESCOLA ELSE NULL END) AS SRM,
CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE

--INTO ##ESCOLAS_ATENDEM_NEE
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN (SELECT 
		CD_ESCOLA,
		[SALA RECURSOS MULTIFUNCIONAIS] 
		FROM ##ESCOLA_AMBIENTES_LINEAR
		WHERE [SALA RECURSOS MULTIFUNCIONAIS] IS NOT NULL) C ON B.CD_ESCOLA=C.CD_ESCOLA
WHERE DEF1 IS NOT NULL AND SG_ETAPA IS NOT NULL AND B.REDE='DIR'
GROUP BY
B.DRE,
B.SG_TP_ESCOLA,
A.CRDATE

--SELECT * FROM ##ESCOLAS_ATENDEM_NEE



/*


SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
CD_ALUNO,
CASE WHEN DEF1 = 1 THEN 'ALTAS HABILIDADES/SUPERDOTACAO'
     WHEN DEF1 = 2 THEN 'AUTISMO'
     WHEN DEF1 = 5 THEN 'SURDEZ LEVE/MODERADA'
     WHEN DEF1 = 6 THEN 'SURDEZ SEVERA/PROFUNDA'
     WHEN DEF1 = 8 THEN 'DEFICIENCIA INTELECTUAL'
     WHEN DEF1 = 9	THEN  ''
     WHEN DEF1 = 11	THEN 'CEGUEIRA'
     WHEN DEF1 = 12	THEN 'BAIXA VISAO OU VISAO SUBNORMAL'
     WHEN DEF1 = 14	THEN 'SURDOCEGUEIRA'
     WHEN DEF1 = 15	THEN ' '
     WHEN DEF1 = 16	THEN 'TRANST DESINTEGRATIVO INFANCIA'
     WHEN DEF1 = 17	THEN 'SINDROME DE ASPERGER'
     WHEN DEF1 = 18	THEN 'SINDROME DE RETT'
     WHEN DEF1 = 19	THEN 'DEFIC. FISICA NAO CADEIRANTE'
     WHEN DEF1 = 20	THEN 'DEFICIENCIA F�SICA CADEIRANTE'
     WHEN DEF1 = 21	THEN 'SINDROME DE DOWN'
     WHEN DEF1 = 22	THEN 'FISICA PARALISIA CEREBRAL'
     WHEN DEF1 = 23	THEN 'VISAO MONOCULAR'
ELSE NULL END AS DEF01,

CASE WHEN DEF2 = 1 THEN 'ALTAS HABILIDADES/SUPERDOTACAO'
     WHEN DEF2 = 2 THEN 'AUTISMO'
     WHEN DEF2 = 5 THEN 'SURDEZ LEVE/MODERADA'
     WHEN DEF2 = 6 THEN 'SURDEZ SEVERA/PROFUNDA'
     WHEN DEF2 = 8 THEN 'DEFICIENCIA INTELECTUAL'
     WHEN DEF2 = 9	THEN  ''
     WHEN DEF2 = 11	THEN 'CEGUEIRA'
     WHEN DEF2 = 12	THEN 'BAIXA VISAO OU VISAO SUBNORMAL'
     WHEN DEF2 = 14	THEN 'SURDOCEGUEIRA'
     WHEN DEF2 = 15	THEN ' '
     WHEN DEF2 = 16	THEN 'TRANST DESINTEGRATIVO INFANCIA'
     WHEN DEF2 = 17	THEN 'SINDROME DE ASPERGER'
     WHEN DEF2 = 18	THEN 'SINDROME DE RETT'
     WHEN DEF2 = 19	THEN 'DEFIC. FISICA NAO CADEIRANTE'
     WHEN DEF2 = 20	THEN 'DEFICIENCIA F�SICA CADEIRANTE'
     WHEN DEF2 = 21	THEN 'SINDROME DE DOWN'
     WHEN DEF2 = 22	THEN 'FISICA PARALISIA CEREBRAL'
     WHEN DEF2 = 23	THEN 'VISAO MONOCULAR'
ELSE NULL END AS DEF02,

CASE WHEN DEF3 = 1 THEN 'ALTAS HABILIDADES/SUPERDOTACAO'
     WHEN DEF3 = 2 THEN 'AUTISMO'
     WHEN DEF3 = 5 THEN 'SURDEZ LEVE/MODERADA'
     WHEN DEF3 = 6 THEN 'SURDEZ SEVERA/PROFUNDA'
     WHEN DEF3 = 8 THEN 'DEFICIENCIA INTELECTUAL'
     WHEN DEF3 = 9	THEN  ''
     WHEN DEF3 = 11	THEN 'CEGUEIRA'
     WHEN DEF3 = 12	THEN 'BAIXA VISAO OU VISAO SUBNORMAL'
     WHEN DEF3 = 14	THEN 'SURDOCEGUEIRA'
     WHEN DEF3 = 15	THEN ' '
     WHEN DEF3 = 16	THEN 'TRANST DESINTEGRATIVO INFANCIA'
     WHEN DEF3 = 17	THEN 'SINDROME DE ASPERGER'
     WHEN DEF3 = 18	THEN 'SINDROME DE RETT'
     WHEN DEF3 = 19	THEN 'DEFIC. FISICA NAO CADEIRANTE'
     WHEN DEF3 = 20	THEN 'DEFICIENCIA F�SICA CADEIRANTE'
     WHEN DEF3 = 21	THEN 'SINDROME DE DOWN'
     WHEN DEF3 = 22	THEN 'FISICA PARALISIA CEREBRAL'
     WHEN DEF3 = 23	THEN 'VISAO MONOCULAR'
ELSE NULL END AS DEF03,

CASE WHEN DEF4 = 1 THEN 'ALTAS HABILIDADES/SUPERDOTACAO'
     WHEN DEF4 = 2 THEN 'AUTISMO'
     WHEN DEF4 = 5 THEN 'SURDEZ LEVE/MODERADA'
     WHEN DEF4 = 6 THEN 'SURDEZ SEVERA/PROFUNDA'
     WHEN DEF4 = 8 THEN 'DEFICIENCIA INTELECTUAL'
     WHEN DEF4 = 9	THEN  ''
     WHEN DEF4 = 11	THEN 'CEGUEIRA'
     WHEN DEF4 = 12	THEN 'BAIXA VISAO OU VISAO SUBNORMAL'
     WHEN DEF4 = 14	THEN 'SURDOCEGUEIRA'
     WHEN DEF4 = 15	THEN ' '
     WHEN DEF4 = 16	THEN 'TRANST DESINTEGRATIVO INFANCIA'
     WHEN DEF4 = 17	THEN 'SINDROME DE ASPERGER'
     WHEN DEF4 = 18	THEN 'SINDROME DE RETT'
     WHEN DEF4 = 19	THEN 'DEFIC. FISICA NAO CADEIRANTE'
     WHEN DEF4 = 20	THEN 'DEFICIENCIA F�SICA CADEIRANTE'
     WHEN DEF4 = 21	THEN 'SINDROME DE DOWN'
     WHEN DEF4 = 22	THEN 'FISICA PARALISIA CEREBRAL'
     WHEN DEF4 = 23	THEN 'VISAO MONOCULAR'
ELSE NULL END AS DEF04,

CASE WHEN DEF5 = 1 THEN 'ALTAS HABILIDADES/SUPERDOTACAO'
     WHEN DEF5 = 2 THEN 'AUTISMO'
     WHEN DEF5 = 5 THEN 'SURDEZ LEVE/MODERADA'
     WHEN DEF5 = 6 THEN 'SURDEZ SEVERA/PROFUNDA'
     WHEN DEF5 = 8 THEN 'DEFICIENCIA INTELECTUAL'
     WHEN DEF5 = 9	THEN  ''
     WHEN DEF5 = 11	THEN 'CEGUEIRA'
     WHEN DEF5 = 12	THEN 'BAIXA VISAO OU VISAO SUBNORMAL'
     WHEN DEF5 = 14	THEN 'SURDOCEGUEIRA'
     WHEN DEF5 = 15	THEN ' '
     WHEN DEF5 = 16	THEN 'TRANST DESINTEGRATIVO INFANCIA'
     WHEN DEF5 = 17	THEN 'SINDROME DE ASPERGER'
     WHEN DEF5 = 18	THEN 'SINDROME DE RETT'
     WHEN DEF5 = 19	THEN 'DEFIC. FISICA NAO CADEIRANTE'
     WHEN DEF5 = 20	THEN 'DEFICIENCIA F�SICA CADEIRANTE'
     WHEN DEF5 = 21	THEN 'SINDROME DE DOWN'
     WHEN DEF5 = 22	THEN 'FISICA PARALISIA CEREBRAL'
     WHEN DEF5 = 23	THEN 'VISAO MONOCULAR'
ELSE NULL END AS DEF05,

--CASE WHEN DEF6 = 1 THEN 'ALTAS HABILIDADES/SUPERDOTACAO'
--     WHEN DEF6 = 2 THEN 'AUTISMO'
--     WHEN DEF6 = 5 THEN 'SURDEZ LEVE/MODERADA'
--     WHEN DEF6 = 6 THEN 'SURDEZ SEVERA/PROFUNDA'
--     WHEN DEF6 = 8 THEN 'DEFICIENCIA INTELECTUAL'
--     WHEN DEF6 = 9	THEN  ''
--     WHEN DEF6 = 11	THEN 'CEGUEIRA'
--     WHEN DEF6 = 12	THEN 'BAIXA VISAO OU VISAO SUBNORMAL'
--     WHEN DEF6 = 14	THEN 'SURDOCEGUEIRA'
--     WHEN DEF6 = 15	THEN ' '
--     WHEN DEF6 = 16	THEN 'TRANST DESINTEGRATIVO INFANCIA'
--     WHEN DEF6 = 17	THEN 'SINDROME DE ASPERGER'
--     WHEN DEF6 = 18	THEN 'SINDROME DE RETT'
--     WHEN DEF6 = 19	THEN 'DEFIC. FISICA NAO CADEIRANTE'
--     WHEN DEF6 = 20	THEN 'DEFICIENCIA F�SICA CADEIRANTE'
--     WHEN DEF6 = 21	THEN 'SINDROME DE DOWN'
--     WHEN DEF6 = 22	THEN 'FISICA PARALISIA CEREBRAL'
--     WHEN DEF6 = 23	THEN 'VISAO MONOCULAR'
--ELSE NULL END AS DEF06,
DEF,
DT_BASE

FROM ##ESCOLAS_ATENDEM_NEE 


WHERE DEF = 'DEFICIENCIA MULTIPLA'

*/