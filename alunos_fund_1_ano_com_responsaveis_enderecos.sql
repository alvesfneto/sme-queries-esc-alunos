/*
Prezados
Boa noite

Solicitamos um arquivo dos estudantes matriculados no 1º ano do Ensino Fundamental, no turno Integral, com as seguintes informações:

DRE
Dados completos do estudante (nome, data de nascimento, endereço, responsáveis, telefones de contato, código EOL)
Dados da Unidade de matrícula

*/

drop table ##alunos_fund_1_ano_com_responsaveis_enderecos
SELECT DISTINCT
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
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

INTO ##alunos_fund_1_ano_com_responsaveis_enderecos
FROM 
VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS
WHERE ETAPA='ENS FUND9A' AND SERIE_ANO='1º ANO'
--select * from ##alunos_fund_1_ano_com_responsaveis_enderecos

