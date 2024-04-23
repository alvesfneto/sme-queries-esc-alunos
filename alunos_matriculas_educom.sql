
--QTDE DE MATRICULAS PROGRAMAS EDUCOMUNICA��O 

/*
A pedido do SECOM da prefeitura precisamos encaminhar os dados referente aos projetos de Educomunica��o desenvolvidos na rede. Pedimos a gentileza de encaminhar os dados   como nome projeto, DRE, escola, nome do professor, e-mail, n� estudantes atendidos referente as seguintes propostas:

EDUCOMUNICA��O - ANIMA��O/STOPMOTION
EDUCOMUNICA��O - BLOG/SITE
EDUCOMUNICA��O - CINEMA/CINECLUBE
EDUCOMUNICA��O - FAKE NEWS E DESINFORMA��O 
EDUCOMUNICA��O - FANZINE
EDUCOMUNICA��O - FOTOGRAFIA
EDUCOMUNICA��O - HIST�RIA EM QUADRINHOS
EDUCOMUNICA��O - IMPRENSA JOVEM
EDUCOMUNICA��O � IMPRENSA MIRIM
EDUCOMUNICA��O - JORNAL ESCOLAR
EDUCOMUNICA��O - JORNAL MURAL
EDUCOMUNICA��O - M�DIAS SOCIAIS
EDUCOMUNICA��O - PRODU��O DE V�DEO
EDUCOMUNICA��O - R�DIO ESCOLAR
EDUCOMUNICA��O - REVISTA
EDUCOMUNICA��O - VIDEOPERFORMANCE
EDUCOMUNICA��O - CULTURA DIGITAL 
*********************************************************************************************/

DROP TABLE ##MATRICULAS_EDUCOM
SELECT 
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.CD_TURMA_ESCOLA,
C.dc_tipo_programa,
A.AL_AT AS MATR,
CONVERT(VARCHAR, A.CRDATE-1, 103) AS DT_BASE
INTO ##MATRICULAS_EDUCOM

FROM SME_CLASSES_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_TIPO_PROGRAMA C ON A.CD_TIPO_PROGRAMA=C.cd_tipo_programa
WHERE A.CD_TIPO_PROGRAMA IS NOT NULL AND C.DC_tipo_programa LIKE 'EDUCOM%'
GROUP BY

B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.CD_TURMA_ESCOLA,
C.dc_tipo_programa,
A.AL_AT,
A.CRDATE
ORDER BY 2,6

--SELECT * FROM ##MATRICULAS_EDUCOM
/********************************************************************************************/


