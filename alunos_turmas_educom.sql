
/*

EDUCOMUNICA��O - ANIMA��O/STOPMOTION       -N�O LOCALIZADO NA TABELA TIPO_PROGRAMA
EDUCOMUNICA��O - CINEMA/CINECLUBE		   -N�O LOCALIZADO NA TABELA TIPO_PROGRAMA
EDUCOMUNICA��O - FAKE NEWS E DESINFORMA��O -N�O LOCALIZADO NA TABELA TIPO_PROGRAMA
EDUCOMUNICA��O � IMPRENSA MIRIM			   -N�O LOCALIZADO NA TABELA TIPO_PROGRAMA
EDUCOMUNICA��O - PRODU��O DE V�DEO		   -N�O LOCALIZADO NA TABELA TIPO_PROGRAMA
EDUCOMUNICA��O - REVISTA				   -N�O LOCALIZADO NA TABELA TIPO_PROGRAMA

EDUCOMUNICA��O - BLOG/SITE OK
EDUCOMUNICA��O - FANZINE OK
EDUCOMUNICA��O - FOTOGRAFIA OK
EDUCOMUNICA��O - HIST�RIA EM QUADRINHOS OK
EDUCOMUNICA��O - IMPRENSA JOVEM OK
EDUCOMUNICA��O - JORNAL ESCOLAR OK
EDUCOMUNICA��O - M�DIAS SOCIAIS OK
EDUCOMUNICA��O - R�DIO ESCOLAR OK
EDUCOMUNICA��O - VIDEOPERFORMANCE OK
EDUCOMUNICA��O - CULTURA DIGITAL OK
EDUCOMUNICA��O - JORNAL MURAL OK
*/


USE Db_Local
DROP TABLE ##TURMAS_EDUCOMUNICACAO
SELECT 
DRE, 
A.CD_ESCOLA, 
SG_TP_ESCOLA, 
NOMESC,
C.dc_tipo_programa AS PROGRAMA,
COUNT (DISTINCT CASE WHEN A.CD_TIPO_PROGRAMA in (406,560,317,322,355,319,416,321,323,329,357,320,324,327,328,330) THEN A.CD_TURMA_ESCOLA ELSE NULL END) AS QT_TUR,
SUM(CASE WHEN  A.CD_TIPO_PROGRAMA in (406,560,317,322,355,319,416,321,323,329,357,320,324,327,328,330) THEN AL_AT ELSE NULL END) AS QT_MT,
CONVERT(VARCHAR,A.CRDATE-1, 103) AS DT_BASE
INTO ##TURMAS_EDUCOMUNICACAO
FROM SME_CLASSES_DIARIO A
LEFT JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_TIPO_PROGRAMA C ON A.CD_TIPO_PROGRAMA=C.cd_tipo_programa
where A.CD_TIPO_PROGRAMA in (406,560,317,322,355,319,416,321,323,329,357,320,324,327,328,330)	
GROUP BY DRE, A.CD_ESCOLA, SG_TP_ESCOLA, NOMESC,C.dc_tipo_programa, A.CRDATE
--SELECT * FROM ##TURMAS_EDUCOMUNICACAO

-----------------------------------------------------------------------------------------------
--lista de turmas co dc_turma
SELECT 
DRE, 
A.CD_ESCOLA, 
SG_TP_ESCOLA, 
NOMESC,
C.dc_tipo_programa AS PROGRAMA,
A.CD_TURMA_ESCOLA,
CONVERT(VARCHAR,A.CRDATE-1, 103) AS DT_BASE
INTO ##TURMAS_EDUCOMUNICACAO_1
FROM SME_CLASSES_DIARIO A
LEFT JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_TIPO_PROGRAMA C ON A.CD_TIPO_PROGRAMA=C.cd_tipo_programa
where A.CD_TIPO_PROGRAMA in (406,560,317,322,355,319,416,321,323,329,357,320,324,327,328,330)	





