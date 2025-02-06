/*
Solicitamos a gentileza de encaminhar, com a maior brevidade possível, 
relatório dos alunos matriculados na 
Unidade Cr.P.Conv. Libertários - EOL 309331 
contendo 
nome, 
data de nascimento, 
código EOL, 
turma 
e endereço residencial 
para estudo prévio de acomodação devido a possível 
devolução do prédio onde funciona esta Unidade, impedindo a continuidade das atividades.
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
UPPER(CONCAT(TP_LOGRADOURO,' ',ENDEREÇO,',',NR,' ',COMPL,' ',BAIRRO)) AS ENDEREÇO
INTO ##alunos_enderecos_unidade_309331
FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS
WHERE CD_ESCOLA=309331
--select * from ##alunos_enderecos_unidade_309331