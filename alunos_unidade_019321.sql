
/*
A fim de garantir o atendimento da continuidade dos alunos de 4º ano matriculados na EMEF Lourival Brandão em 2025, solicitamos relatório de turmas com os dados abaixo:

EMEF Lourival Brandão
Nome
RA
Código EOL
Endereço (rua, número, bairro e CEP)
*/

drop table ##alunos_unidade_019321

select DISTINCT
DRE,
A.cd_escola,
SG_TP_ESCOLA,
NOMESC,
--C.SG_ETAPA,
C.SG_SERIE_ENSINO,
C.CD_TURMA_ESCOLA,

A.nm_aluno AS NOME_ALUNO,
RA,
COD_ALUNO,
CONCAT(A.TP_LOGRADOURO,' ',A.ENDEREÇO,', ',A.NR,' ',A.COMPL,' ',A.BAIRRO) AS ENDERECO,
CONCAT('0',A.CEP) AS CEP,
A.CRDATE AS DT_BASE
INTO ##alunos_unidade_019321
 from VW_ALUNOS_ENDERECOS A
JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA
JOIN SME_ALUNOS_DIARIO C ON A.COD_ALUNO=C.CD_ALUNO
WHERE A.cd_escola=019321 AND SG_ETAPA IS NOT NULL
ORDER BY C.SG_SERIE_ENSINO,C.CD_TURMA_ESCOLA

--select * from ##alunos_unidade_019321
