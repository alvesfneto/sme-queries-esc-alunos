/*
Solicitamos a gentileza de encaminhar, com a maior brevidade poss�vel, 
relat�rio dos alunos matriculados na 
Unidade Cr.P.Conv. Libert�rios - EOL 309331 
contendo 
nome, 
data de nascimento, 
c�digo EOL, 
turma 
e endere�o residencial 
para estudo pr�vio de acomoda��o devido a poss�vel 
devolu��o do pr�dio onde funciona esta Unidade, impedindo a continuidade das atividades.
*/
drop table ##alunos_enderecos_unidade_309331
SELECT
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
DT_NASCIMENTO_ALUNO,
UPPER(CONCAT(TP_LOGRADOURO,' ',ENDERE�O,',',NR,' ',COMPL,' ',BAIRRO)) AS ENDERE�O
INTO ##alunos_enderecos_unidade_309331
FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS
WHERE CD_ESCOLA=309331
--select * from ##alunos_enderecos_unidade_309331