
/*
 Solicitamos, por gentileza,  uma planilha dos alunos matriculados do CEI Vov� Ana (308665), 
 para estudo da demanda, nesta precisa conter 
 nome da crian�a, 
 c�digo e EOL , 
 nome do respons�vel, 
 endere�o completo, , 
 contato telef�nico e 
 e-mail, 
 agrupamento 
 na qual a crian�a esta matriculada. 
 */

 DROP TABLE ##alunos_escola_308665_enderecos_contatos_responsaveis
SELECT 
DRE,
A.cd_escola AS CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
A.nm_aluno AS NOME_ALUNO,
C.SG_ETAPA,
C.SG_SERIE_ENSINO,
CONVERT(VARCHAR,C.DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
C.NM_MAE_ALUNO,
A.ENDERE�O,
A.NR,
A.COMPL,
A.BAIRRO,
A.CEP,
D.RESPONS�VEL,
D.TEL_FIXO,
D.TEL_CELULAR,
D.EMAIL_RESPONSAVEL


INTO ##alunos_escola_308665_enderecos_contatos_responsaveis

FROM VW_ALUNOS_ENDERECOS A
JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA 
JOIN SME_ALUNOS_DIARIO C ON A.COD_ALUNO=C.CD_ALUNO
JOIN VW_ALUNOS_RESPONSAVEIS D ON A.COD_ALUNO=D.COD_ALUNO
WHERE A.cd_escola = 308665

--SELECT * FROM ##alunos_escola_308665_enderecos_contatos_responsaveis