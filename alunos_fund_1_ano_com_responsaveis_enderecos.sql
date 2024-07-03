/*
Prezados
Boa noite

Solicitamos um arquivo dos estudantes matriculados no 1� ano do Ensino Fundamental, no turno Integral, com as seguintes informa��es:

DRE
Dados completos do estudante (nome, data de nascimento, endere�o, respons�veis, telefones de contato, c�digo EOL)
Dados da Unidade de matr�cula

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
CONCAT(TP_LOGRADOURO,' ',ENDERE�O) AS ENDERECO,
NR,
COMPL,
BAIRRO,
RESPONS�VEL,
TEL_CELULAR,
TEL_FIXO,
EMAIL_RESPONSAVEL,
CRDATE AS DT_BASE

INTO ##alunos_fund_1_ano_com_responsaveis_enderecos
FROM 
VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS
WHERE ETAPA='ENS FUND9A' AND SERIE_ANO='1� ANO'
--select * from ##alunos_fund_1_ano_com_responsaveis_enderecos

