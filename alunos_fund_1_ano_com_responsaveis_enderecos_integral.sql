/*
Prezados
Boa noite

Solicitamos um arquivo dos estudantes matriculados no 1º ano do Ensino Fundamental, no turno Integral, com as seguintes informações:

DRE
Dados completos do estudante (nome, data de nascimento, endereço, responsáveis, telefones de contato, código EOL)
Dados da Unidade de matrícula

*/

drop table ##alunos_fund_1_ano_com_responsaveis_enderecos_integral
SELECT DISTINCT
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
dc_tipo_turno AS TURNO,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
CONVERT(DATE,DT_NASCIMENTO_ALUNO, 103) AS DT_NASCIMENTO,
CONCAT(TP_LOGRADOURO,' ',ENDEREÇO) AS ENDERECO,
NR,
COMPL,
BAIRRO,
RESPONSÁVEL,
TEL_CELULAR,
TEL_FIXO,
EMAIL_RESPONSAVEL,
CRDATE AS DT_BASE

INTO ##alunos_fund_1_ano_com_responsaveis_enderecos_integral
FROM 
VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS A
jOIN (SELECT 
      A.CD_ALUNO,
      A.CD_TURMA_ESCOLA,
      B.CD_TIPO_TURNO,
      C.dc_tipo_turno
      FROM SME_ALUNOS_DIARIO A
      JOIN SME_CLASSES_DIARIO B ON A.CD_TURMA_ESCOLA=B.CD_TURMA_ESCOLA
      JOIN tipo_turno C ON B.CD_TIPO_TURNO=C.cd_tipo_turno
      WHERE B.CD_TIPO_TURNO=6 AND A.SG_ETAPA='ENS FUND9A' AND A.SG_SERIE_ENSINO='1º ANO') B ON A.COD_ALUNO=B.CD_ALUNO
WHERE ETAPA='ENS FUND9A' AND SERIE_ANO='1º ANO'
--select * from ##alunos_fund_1_ano_com_responsaveis_enderecos_integral

select * from ##alunos_fund_1_ano_com_responsaveis_enderecos A


SELECT 
A.CD_ALUNO,
A.CD_TURMA_ESCOLA,
B.CD_TIPO_TURNO,
C.dc_tipo_turno

 FROM SME_ALUNOS_DIARIO A
JOIN SME_CLASSES_DIARIO B ON A.CD_TURMA_ESCOLA=B.CD_TURMA_ESCOLA
JOIN tipo_turno C ON B.CD_TIPO_TURNO=C.cd_tipo_turno
WHERE B.CD_TIPO_TURNO=6 AND A.SG_ETAPA='ENS FUND9A' AND A.SG_SERIE_ENSINO='1º ANO'
