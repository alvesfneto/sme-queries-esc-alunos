/*
Solicito relatório de endereço dos alunos matriculados no CEI VOVO MARIAZINHA ROCHA (308258). 
O relatório deve conter : 
Nome completo
EOL
Endereço
Agrupamento
Endereço (separado por colunas)
Data de matrícula
*/


DROP TABLE ##alunos_unidade_308258
SELECT 
DRE,
UPPER(A.cd_escola) AS CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
A.NM_ALUNO,
COD_ALUNO,
UPPER(A.TP_LOGRADOURO) AS TP_LOGRADOURO,
A.ENDEREÇO,
A.NR,
A.BAIRRO,
CONVERT(DATE,C.DT_STATUS_MATRICULA,103) AS DT_MATRICULA

INTO ##alunos_unidade_308258

FROM 
VW_ALUNOS_ENDERECOS A
JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA
JOIN SME_ALUNOS_DIARIO C ON A.COD_ALUNO=C.CD_ALUNO


 WHERE A.cd_escola=308258
 --SELECT * FROM ##alunos_unidade_308258

--SELECT * FROM SME_ALUNOS_DIARIO